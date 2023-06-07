// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import '../config/config.dart';
import '../elements/elements.dart';
import '../logging/logging.dart';
import '../util/find_package.dart';
import '../util/string_util.dart';
import 'visitor.dart';

/// JVM representation of type signatures.
///
/// https://docs.oracle.com/en/java/javase/18/docs/specs/jni/types.html#type-signatures
class Descriptor extends TypeVisitor<String> {
  const Descriptor();

  @override
  String visitArrayType(ArrayType node) {
    final inner = node.type.accept(this);
    return '[$inner';
  }

  @override
  String visitDeclaredType(DeclaredType node) {
    final internalName = node.binaryName.replaceAll('.', '/');
    return 'L$internalName;';
  }

  @override
  String visitPrimitiveType(PrimitiveType node) {
    return node.signature;
  }

  @override
  String visitTypeVar(TypeVar node) {
    // It should be possible to compute the erasure of a type
    // in parser itself.
    // TODO(#23): Use erasure of the type variable here.
    // This is just a (wrong) placeholder
    return super.visitTypeVar(node);
  }

  @override
  String visitWildcard(Wildcard node) {
    final extendsBound = node.extendsBound?.accept(this);
    return extendsBound ?? 'Ljava/lang/Object;';
  }

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return "Ljava/lang/Object;";
  }
}

/// Generates JNI Method signatures.
///
/// https://docs.oracle.com/en/java/javase/18/docs/specs/jni/types.html#type-signatures
/// Also see: [Descriptor]
class MethodSignature extends Visitor<Method, String> {
  const MethodSignature();

  @override
  String visit(Method node) {
    final s = StringBuffer();
    s.write('(');
    s.write(node.params
        .map((param) => param.type)
        .accept(const Descriptor())
        .join());
    s.write(')');
    final returnType = node.returnType.accept(const Descriptor());
    s.write(returnType);
    return s.toString();
  }
}

class CFieldName extends Visitor<Field, String> {
  const CFieldName();

  @override
  String visit(Field node) {
    final className = node.classDecl.uniqueName;
    final fieldName = node.finalName;
    return '${className}__$fieldName';
  }
}

class CMethodName extends Visitor<Method, String> {
  const CMethodName();

  @override
  String visit(Method node) {
    final className = node.classDecl.uniqueName;
    final methodName = node.finalName;
    return '${className}__$methodName';
  }
}

class CGenerator extends Visitor<Classes, Future<void>> {
  static const _prelude = '''// Autogenerated by jnigen. DO NOT EDIT!

#include <stdint.h>
#include "jni.h"
#include "dartjni.h"

thread_local JNIEnv *jniEnv;
JniContext *jni;

JniContext *(*context_getter)(void);
JNIEnv *(*env_getter)(void);

void setJniGetters(JniContext *(*cg)(void),
        JNIEnv *(*eg)(void)) {
    context_getter = cg;
    env_getter = eg;
}

''';

  final Config config;

  CGenerator(this.config);

  Future<void> _copyFileFromPackage(String package, String relPath, Uri target,
      {String Function(String)? transform}) async {
    final packagePath = await findPackageRoot(package);
    if (packagePath != null) {
      final sourceFile = File.fromUri(packagePath.resolve(relPath));
      final targetFile = await File.fromUri(target).create(recursive: true);
      var source = await sourceFile.readAsString();
      if (transform != null) {
        source = transform(source);
      }
      await targetFile.writeAsString(source);
    } else {
      log.warning('package $package not found! '
          'skipped copying ${target.toFilePath()}');
    }
  }

  @override
  Future<void> visit(Classes node) async {
    // Write C file and init file.
    final cConfig = config.outputConfig.cConfig!;
    final cRoot = cConfig.path;
    final preamble = config.preamble;
    log.info("Using c root = $cRoot");
    final libraryName = cConfig.libraryName;
    log.info('Creating dart init file ...');
    // Create C file.
    final subdir = cConfig.subdir ?? '.';
    final cFileRelativePath = '$subdir/$libraryName.c';
    final cFile = await File.fromUri(cRoot.resolve(cFileRelativePath))
        .create(recursive: true);
    final cFileStream = cFile.openWrite();
    // Write C Bindings.
    if (preamble != null) {
      cFileStream.writeln(preamble);
    }
    cFileStream.write(_prelude);
    final classGenerator = _CClassGenerator(config, cFileStream);
    for (final classDecl in node.decls.values) {
      classDecl.accept(classGenerator);
    }
    await cFileStream.close();
    log.info('Copying auxiliary files...');
    for (final file in ['dartjni.h', '.clang-format']) {
      await _copyFileFromPackage(
          'jni', 'src/$file', cRoot.resolve('$subdir/$file'));
    }
    await _copyFileFromPackage(
        'jnigen', 'cmake/CMakeLists.txt.tmpl', cRoot.resolve('CMakeLists.txt'),
        transform: (s) {
      return s
          .replaceAll('{{LIBRARY_NAME}}', libraryName)
          .replaceAll('{{SUBDIR}}', subdir);
    });
    log.info('Running clang-format on C bindings');
    try {
      final clangFormat = Process.runSync('clang-format', ['-i', cFile.path]);
      if (clangFormat.exitCode != 0) {
        printError(clangFormat.stderr);
        log.warning('clang-format exited with ${clangFormat.exitCode}');
      }
    } on ProcessException catch (e) {
      log.warning('cannot run clang-format: $e');
    }
  }
}

const _classVarPrefix = '_c_';
const _jniResultType = 'JniResult';
const _loadEnvCall = 'load_env();';
const _ifError =
    '(JniResult){.value = {.j = 0}, .exception = check_exception()}';

class _CClassGenerator extends Visitor<ClassDecl, void> {
  final Config config;
  final StringSink s;

  _CClassGenerator(this.config, this.s);

  @override
  void visit(ClassDecl node) {
    final classNameInC = node.uniqueName;
    final classVar = '$_classVarPrefix$classNameInC';
    // Global variable in C that holds the reference to class.
    s.write('''// ${node.binaryName}
jclass $classVar = NULL;

''');

    final methodGenerator = _CMethodGenerator(config, s);
    for (final method in node.methods) {
      method.accept(methodGenerator);
    }

    final fieldGenerator = _CFieldGenerator(config, s);
    for (final field in node.fields) {
      field.accept(fieldGenerator);
    }
  }
}

class _CLoadClassGenerator extends Visitor<ClassDecl, String> {
  _CLoadClassGenerator();

  @override
  String visit(ClassDecl node) {
    final classVar = '$_classVarPrefix${node.uniqueName}';
    return '''    load_class_global_ref(&$classVar, "${node.internalName}");
    if ($classVar == NULL) return $_ifError;''';
  }
}

class _CMethodGenerator extends Visitor<Method, void> {
  static const _methodVarPrefix = '_m_';

  final Config config;
  final StringSink s;

  _CMethodGenerator(this.config, this.s);

  @override
  void visit(Method node) {
    final classNameInC = node.classDecl.uniqueName;

    final cMethodName = node.accept(const CMethodName());
    final classRef = '$_classVarPrefix$classNameInC';
    final methodId = '$_methodVarPrefix$cMethodName';
    final cMethodParams = [
      if (!node.isCtor && !node.isStatic) 'jobject self_',
      ...node.params.accept(const _CParamGenerator(addReturnType: true)),
    ].join(',');
    final jniSignature = node.accept(const MethodSignature());
    final ifStaticMethodID = node.isStatic ? 'static_' : '';

    var javaReturnType = node.returnType.type;
    if (node.isCtor) {
      javaReturnType = DeclaredType(
        binaryName: node.classDecl.binaryName,
      );
    }
    final callType = node.returnType.accept(const _CTypeCallSite());
    final callArgs = [
      'jniEnv',
      if (!node.isCtor && !node.isStatic) 'self_' else classRef,
      methodId,
      ...node.params.accept(const _CParamGenerator(addReturnType: false))
    ].join(', ');

    var ifAssignResult = '';
    if (javaReturnType.name != 'void') {
      ifAssignResult =
          '${javaReturnType.accept(const _CReturnType())} _result = ';
    }

    final ifStaticCall = node.isStatic ? 'Static' : '';
    final envMethod =
        node.isCtor ? 'NewObject' : 'Call$ifStaticCall${callType}Method';
    final returnResultIfAny = javaReturnType.accept(const _CResult());
    s.write('''
jmethodID $methodId = NULL;
FFI_PLUGIN_EXPORT
$_jniResultType $cMethodName($cMethodParams) {
    $_loadEnvCall
    ${node.classDecl.accept(_CLoadClassGenerator())}
    load_${ifStaticMethodID}method($classRef,
      &$methodId, "${node.name}", "$jniSignature");
    if ($methodId == NULL) return $_ifError;
    $ifAssignResult(*jniEnv)->$envMethod($callArgs);
    $returnResultIfAny
}

''');
  }
}

class _CFieldGenerator extends Visitor<Field, void> {
  static const _fieldVarPrefix = '_f_';

  final Config config;
  final StringSink s;

  _CFieldGenerator(this.config, this.s);

  @override
  void visit(Field node) {
    final cClassName = node.classDecl.uniqueName;

    final fieldName = node.finalName;
    final fieldNameInC = node.accept(const CFieldName());
    final fieldVar = "$_fieldVarPrefix$fieldNameInC";

    // If the field is final and default is assigned, then no need to wrap
    // this field. It should then be a constant in dart code.
    if (node.isStatic && node.isFinal && node.defaultValue != null) {
      return;
    }

    s.write('jfieldID $fieldVar = NULL;\n');

    final classVar = '$_classVarPrefix$cClassName';
    void writeAccessor({bool isSetter = false}) {
      const cReturnType = _jniResultType;
      final cMethodPrefix = isSetter ? 'set' : 'get';
      final formalArgs = [
        if (!node.isStatic) 'jobject self_',
        if (isSetter) '${node.type.accept(const _CReturnType())} value',
      ].join(', ');
      final ifStaticField = node.isStatic ? 'static_' : '';
      final ifStaticCall = node.isStatic ? 'Static' : '';
      final callType = node.type.accept(const _CTypeCallSite());
      final objectArgument = node.isStatic ? classVar : 'self_';

      String accessorStatements;
      if (isSetter) {
        accessorStatements =
            '    (*jniEnv)->Set$ifStaticCall${callType}Field(jniEnv, '
            '$objectArgument, $fieldVar, value);\n'
            '    return $_ifError;';
      } else {
        final getterExpr =
            '(*jniEnv)->Get$ifStaticCall${callType}Field(jniEnv, '
            '$objectArgument, $fieldVar)';
        final cResultType = node.type.accept(const _CReturnType());
        final result = node.type.accept(const _CResult());
        accessorStatements = '''    $cResultType _result = $getterExpr;
    $result''';
      }
      s.write('''
FFI_PLUGIN_EXPORT
$cReturnType ${cMethodPrefix}_$fieldNameInC($formalArgs) {
    $_loadEnvCall
    ${node.classDecl.accept(_CLoadClassGenerator())}
    load_${ifStaticField}field($classVar, &$fieldVar, "$fieldName",
      "${node.type.accept(const Descriptor())}");
$accessorStatements
}

''');
    }

    writeAccessor(isSetter: false);
    if (node.isFinal) {
      return;
    }
    writeAccessor(isSetter: true);
  }
}

class _CParamGenerator extends Visitor<Param, String> {
  /// These should be avoided in parameter names.
  static const _cTypeKeywords = {
    'short',
    'char',
    'int',
    'long',
    'float',
    'double',
  };

  const _CParamGenerator({required this.addReturnType});

  final bool addReturnType;

  @override
  String visit(Param node) {
    final paramName =
        (_cTypeKeywords.contains(node.name) ? '${node.name}0' : node.name)
            .replaceAll('\$', '_');
    if (addReturnType) {
      final type = node.type.accept(const _CReturnType());
      return '$type $paramName';
    }
    return paramName;
  }
}

class _CReturnType extends TypeVisitor<String> {
  const _CReturnType();

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return 'jobject';
  }

  @override
  String visitPrimitiveType(PrimitiveType node) {
    return node.cType;
  }
}

class _CTypeCallSite extends TypeVisitor<String> {
  const _CTypeCallSite();

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return 'Object';
  }

  @override
  String visitPrimitiveType(PrimitiveType node) {
    return node.name.capitalize();
  }
}

class _CResult extends TypeVisitor<String> {
  const _CResult();

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return 'return to_global_ref_result(_result);';
  }

  @override
  String visitPrimitiveType(PrimitiveType node) {
    if (node.name == 'void') {
      return 'return $_ifError;';
    }
    // The union field is the same as the type's signature, but in lowercase.
    final unionField = node.signature.toLowerCase();
    return 'return (JniResult){.value = {.$unionField = _result}, '
        '.exception = check_exception()};';
  }
}
