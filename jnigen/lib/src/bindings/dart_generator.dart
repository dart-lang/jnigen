// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import '../config/config.dart';
import '../elements/elements.dart';
import '../logging/logging.dart';
import '../writers/bindings_writer.dart';
import 'c_generator.dart';
import 'resolver.dart';
import 'visitor.dart';

// Import prefixes
const _jni = 'jni';
const _ffi = 'ffi';

// package:jni types
const _jType = '$_jni.JObjType';
const _jPointer = '$_jni.JObjectPtr';
const _jArray = '$_jni.JArray';
const _jObject = '$_jni.JObject';
const _jThrowable = '$_jni.JThrowablePtr';
const _jResult = '$_jni.JniResult';
const _jCallType = '$_jni.JniCallType';

// package:ffi types
const _voidPointer = '$_ffi.Pointer<$_ffi.Void>';

// Prefixes and suffixes
const _typeParamPrefix = '\$';
// TODO(#143): this is a temporary fix for the name collision.
const _typeClassPrefix = '\$';
const _typeClassSuffix = 'Type';

// Misc.
const _classRef = '_classRef';
const _env = 'jniEnv';
const _accessors = 'jniAccessors';
const _lookup = 'jniLookup';
const _selfPointer = 'reference';

// Docs
const _deleteInstruction =
    '  /// The returned object must be deleted after use, '
    'by calling the `delete` method.';

extension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension on Iterable<String> {
  /// Similar to [join] but adds the [separator] to the end as well.
  String delimited([String separator = '']) {
    return map((e) => '$e$separator').join();
  }
}

/// Encloses [inside] in the middle of [open] and [close]
/// if [inside] is not empty.
String _encloseIfNotEmpty(String open, String inside, String close) {
  if (inside == '') return '';
  return '$open$inside$close';
}

String _newLine({int depth = 0}) {
  return '\n${'  ' * depth}';
}

/// **Naming Convention**
///
/// Let's take the following code as an example:
///
/// ```dart
/// Method definition
/// void f<T extends num, U>(JType<T> $T, JType<U> $U, T t, U u) {
///   // ...
/// }
/// f<int, String>($T, $U, t, u); // Calling the Method
/// ```
///
/// Here `f` will be replaced according to the place of usage.
///
/// * `fArgsDef` refers to `T t, U u` – the arguments in the method
///   definition.
/// * `fArgsCall` refer to `t, u` – the arguments passed to call the method.
/// * `fTypeParamsDef` refers to `<T extends num, U>` – the type parameters
///   of the method at the point of definition.
/// * `fTypeParamsCall` refers to `<int, String>` – the type parameters when
///   calling, or whenever we don't want to have the `extends` keyword.
/// * `fTypeClassesDef` refers to `JType<T> $T, JType<U> $U`.
/// * `fTypeClassesCall` refers to `$T, $U` when calling the method.
class DartGenerator extends Visitor<Classes, Future<void>> {
  DartGenerator(this.config);

  final Config config;

  static const cInitImport = 'import "dart:ffi" as ffi;\n'
      'import "package:jni/internal_helpers_for_jnigen.dart";\n';

  /// Initialization code for C based bindings.
  ///
  /// Should be called once in a package. In package-structured bindings
  /// this is placed in _init.dart in package root.
  String get cInitCode => '''
// Auto-generated initialization code.

final $_ffi.Pointer<T> Function<T extends $_ffi.NativeType>(String sym) $_lookup =
    ProtectedJniExtensions.initGeneratedLibrary("${config.outputConfig.cConfig!.libraryName}");


''';

  static const dartOnlyInitImport = 'import "package:jni/jni.dart" as jni;\n';

  static const dartOnlyInitCode = '''
// Auto-generated initialization code.

final $_env = $_jni.Jni.env;
final $_accessors = $_jni.Jni.accessors;


''';

  static const autoGeneratedNotice = '// Autogenerated by jnigen. '
      'DO NOT EDIT!\n\n';
  static const defaultImports = '''
import "dart:isolate" show ReceivePort;
import "dart:ffi" as ffi;
import "package:jni/internal_helpers_for_jnigen.dart";
import "package:jni/jni.dart" as jni;

''';
  static const defaultLintSuppressions = '''
// ignore_for_file: annotate_overrides
// ignore_for_file: camel_case_extensions
// ignore_for_file: camel_case_types
// ignore_for_file: constant_identifier_names
// ignore_for_file: file_names
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: overridden_fields
// ignore_for_file: unnecessary_cast
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_shown_name

''';
  static const preImportBoilerplate =
      autoGeneratedNotice + defaultLintSuppressions + defaultImports;

  @override
  Future<void> visit(Classes node) async {
    final cBased = config.outputConfig.bindingsType == BindingsType.cBased;
    final root = config.outputConfig.dartConfig.path;
    final preamble = config.preamble ?? '';
    if (config.outputConfig.dartConfig.structure ==
        OutputStructure.singleFile) {
      final file = File.fromUri(root);
      await file.create(recursive: true);
      log.info("Generating ${cBased ? "C + Dart" : "Pure Dart"} Bindings");
      final s = file.openWrite();
      s.writeln(preamble);
      s.writeln(autoGeneratedNotice);
      s.writeln(defaultLintSuppressions);
      s.writeln(defaultImports);
      if (cBased) {
        s.writeln(cInitCode);
      } else {
        s.writeln(dartOnlyInitCode);
      }
      final classGenerator = _ClassGenerator(config, s);
      node.decls.values.accept(classGenerator).toList();
      await s.close();
      await runDartFormat(file.path);
      return;
    }
    final files = <String, List<ClassDecl>>{};
    final packages = <String, Set<String>>{};
    for (final classDecl in node.decls.values) {
      final fileClass = Resolver.getFileClassName(classDecl.binaryName);

      files.putIfAbsent(fileClass, () => <ClassDecl>[]);
      files[fileClass]!.add(classDecl);

      packages.putIfAbsent(classDecl.packageName, () => {});
      packages[classDecl.packageName]!.add(fileClass.split('.').last);
    }

    log.info("Using dart root = $root");
    const initFileName = '_init.dart';
    final initFileUri = root.resolve(initFileName);
    final initFile = File.fromUri(initFileUri);
    await initFile.create(recursive: true);
    final initStream = initFile.openWrite();
    initStream.writeln(preamble);
    initStream.writeln(cBased ? cInitImport : dartOnlyInitImport);
    initStream.writeln(cBased ? cInitCode : dartOnlyInitCode);
    await initStream.close();
    for (var fileClassName in files.keys) {
      final relativeFileName = '${fileClassName.replaceAll('.', '/')}.dart';
      final dartFileUri = root.resolve(relativeFileName);
      final dartFile = await File.fromUri(dartFileUri).create(recursive: true);
      log.fine('$fileClassName -> ${dartFile.path}');

      final classesInFile = files[fileClassName]!;
      final dartFileStream = dartFile.openWrite();
      dartFileStream.writeln(preamble);
      dartFileStream.writeln(autoGeneratedNotice);
      dartFileStream.writeln(defaultLintSuppressions);
      dartFileStream.writeln(defaultImports);
      final s = StringBuffer();
      final initFilePath = ('../' *
              relativeFileName.codeUnits
                  .where((cu) => cu == '/'.codeUnitAt(0))
                  .length) +
          initFileName;
      s.write('import "$initFilePath";');
      final resolver = Resolver(
        importMap: config.importMap ?? {},
        currentClass: fileClassName,
        inputClassNames: node.decls.keys.toSet(),
      );
      classesInFile
          .accept(_ClassGenerator(config, s, resolver: resolver))
          .toList();
      dartFileStream.writeAll(resolver.getImportStrings(), '\n');
      dartFileStream.writeln(s.toString());
      await dartFileStream.close();
    }

    // write _package.dart export files
    for (var package in packages.keys) {
      final dirUri = root.resolve('${package.replaceAll('.', '/')}/');
      final exportFileUri = dirUri.resolve("_package.dart");
      final exportFile = File.fromUri(exportFileUri);
      exportFile.createSync(recursive: true);
      final exports =
          packages[package]!.map((cls) => 'export "$cls.dart";').join('\n');
      exportFile.writeAsStringSync(exports);
    }
    await runDartFormat(root.toFilePath());
    log.info('Completed.');
  }
}

/// Generates the Dart class definition, type class, and the array extension
class _ClassGenerator extends Visitor<ClassDecl, void> {
  _ClassGenerator(
    this.config,
    this.s, {
    this.resolver,
  });

  final Config config;
  final StringSink s;
  final Resolver? resolver;

  static const staticTypeGetter = 'type';
  static const instanceTypeGetter = '\$$staticTypeGetter';

  @override
  void visit(ClassDecl node) {
    final isDartOnly =
        config.outputConfig.bindingsType == BindingsType.dartOnly;

    // Docs
    s.write('/// from: ${node.binaryName}\n');
    node.javadoc?.accept(_DocGenerator(s, depth: 0));

    // Class definition
    final name = node.finalName;
    final superName = node.superclass!.accept(_TypeGenerator(resolver));
    final typeParamsDef = _encloseIfNotEmpty(
      '<',
      node.allTypeParams
          .accept(const _TypeParamGenerator(withExtends: true))
          .join(', '),
      '>',
    );
    final typeParams = node.allTypeParams
        .accept(const _TypeParamGenerator(withExtends: false));
    final typeParamsCall = _encloseIfNotEmpty(
      '<',
      typeParams.map((typeParam) => '$_typeParamPrefix$typeParam').join(', '),
      '>',
    );
    final staticTypeGetterCallArgs = _encloseIfNotEmpty(
      '(',
      typeParams.join(', '),
      ')',
    );
    final typeClassDefinitions = typeParams
        .map((typeParam) =>
            'final $_jType<$_typeParamPrefix$typeParam> $typeParam;')
        .join(_newLine(depth: 1));
    final ctorTypeClassesDef = typeParams
        .map((typeParam) => 'this.$typeParam,')
        .join(_newLine(depth: 2));
    final superClass = (node.classDecl.superclass!.type as DeclaredType);
    final superTypeClassesCall = superClass.classDecl == ClassDecl.object
        ? ''
        : superClass.params
            .accept(_TypeClassGenerator(resolver))
            .map((typeClass) => '${typeClass.name},')
            .join(_newLine(depth: 2));
    s.write('''
class $name$typeParamsDef extends $superName {
  late final $_jType? _$instanceTypeGetter;
  @override
  $_jType get $instanceTypeGetter => _$instanceTypeGetter ??= $staticTypeGetter$staticTypeGetterCallArgs;

  $typeClassDefinitions

  $name.fromRef(
    $ctorTypeClassesDef
    $_jPointer ref,
  ): super.fromRef(
    $superTypeClassesCall
    ref
  );

''');

    if (isDartOnly) {
      final internalName = node.internalName;
      s.write('''
  static final $_classRef = $_accessors.getClassOf(r"$internalName");

''');
    }

    // Static TypeClass getter
    s.writeln(
        '  /// The type which includes information such as the signature of this class.');
    final typeClassName = '$_typeClassPrefix$name$_typeClassSuffix';
    if (typeParams.isEmpty) {
      s.writeln('static const $staticTypeGetter = $typeClassName();');
    } else {
      final staticTypeGetterTypeClassesDef = typeParams
          .map(
              (typeParam) => '$_jType<$_typeParamPrefix$typeParam> $typeParam,')
          .join(_newLine(depth: 2));
      final typeClassesCall =
          typeParams.map((typeParam) => '$typeParam,').join(_newLine(depth: 3));
      s.write('''
  static $typeClassName$typeParamsCall $staticTypeGetter$typeParamsDef(
    $staticTypeGetterTypeClassesDef
  ) {
    return $typeClassName(
      $typeClassesCall
    );
  }

''');
    }

    // Fields and Methods
    final fieldGenerator = _FieldGenerator(config, resolver, s);
    for (final field in node.fields) {
      field.accept(fieldGenerator);
    }
    final methodGenerator = _MethodGenerator(config, resolver, s);
    for (final method in node.methods) {
      method.accept(methodGenerator);
    }

    // End of Class definition
    s.writeln('}');

    // TypeClass definition
    final typeClassesCall =
        typeParams.map((typeParam) => '$typeParam,').join(_newLine(depth: 2));
    final signature = node.signature;
    final superTypeClass = superClass.accept(_TypeClassGenerator(resolver));
    s.write('''
class $typeClassName$typeParamsDef extends $_jType<$name$typeParamsCall> {
  $typeClassDefinitions

  const $typeClassName(
    $ctorTypeClassesDef
  );

  @override
  String get signature => r"$signature";

  @override
  $name$typeParamsCall fromRef($_jPointer ref) => $name.fromRef(
    $typeClassesCall
    ref
  );

  @override
  $_jType get parent => ${superTypeClass.name};
}

''');
    log.finest('Generated bindings for class ${node.binaryName}');
  }
}

/// Generates the JavaDoc comments.
class _DocGenerator extends Visitor<JavaDocComment, void> {
  const _DocGenerator(this.s, {required this.depth});

  final StringSink s;
  final int depth;

  @override
  void visit(JavaDocComment node) {
    final link = RegExp('{@link ([^{}]+)}');
    final indent = '  ' * depth;
    final comments = node.comment
        .replaceAllMapped(link, (match) => match.group(1) ?? '')
        .replaceAll('#', '\\#')
        .replaceAll('<p>', '')
        .replaceAll('</p>', '\n')
        .replaceAll('<b>', '__')
        .replaceAll('</b>', '__')
        .replaceAll('<em>', '_')
        .replaceAll('</em>', '_')
        .split('\n')
        .join('\n$indent///');
    s.write('''
$indent///
$indent/// $comments
''');
  }
}

/// Generates the user-facing Dart type.
class _TypeGenerator extends TypeVisitor<String> {
  const _TypeGenerator(this.resolver);

  final Resolver? resolver;

  @override
  String visitArrayType(ArrayType node) {
    final innerType = node.type;
    if (innerType.kind == Kind.primitive) {
      return '$_jArray<$_jni.${(innerType.type as PrimitiveType).jniType}>';
    }
    return '$_jArray<${innerType.accept(this)}>';
  }

  @override
  String visitDeclaredType(DeclaredType node) {
    if (node.classDecl.binaryName == 'java.lang.Object' ||
        node.classDecl.binaryName == 'java.lang.String') {
      return '$_jni.${node.classDecl.finalName}';
    }

    // All type parameters of this type
    final allTypeParams = node.classDecl.allTypeParams
        .accept(const _TypeParamGenerator(withExtends: false))
        .toList();
    // The ones that are declared.
    final definedTypeParams = node.params.accept(this).toList();

    // Replacing the declared ones. They come at the end.
    // The rest will be JObject.
    if (allTypeParams.length >= node.params.length) {
      allTypeParams.replaceRange(
        0,
        allTypeParams.length - node.params.length,
        List.filled(
          allTypeParams.length - node.params.length,
          _jObject,
        ),
      );
      allTypeParams.replaceRange(
        allTypeParams.length - node.params.length,
        allTypeParams.length,
        definedTypeParams,
      );
    }

    final typeParams = _encloseIfNotEmpty('<', allTypeParams.join(', '), '>');
    final prefix = resolver?.resolvePrefix(node.classDecl.binaryName) ?? '';
    return '$prefix${node.classDecl.finalName}$typeParams';
  }

  @override
  String visitPrimitiveType(PrimitiveType node) {
    return node.dartType;
  }

  @override
  String visitTypeVar(TypeVar node) {
    return '$_typeParamPrefix${node.name}';
  }

  @override
  String visitWildcard(Wildcard node) {
    // TODO(#141): Support wildcards
    return super.visitWildcard(node);
  }

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return _jObject;
  }
}

class _TypeClass {
  const _TypeClass(this.name, this.canBeConst);

  final String name;
  final bool canBeConst;
}

/// Generates the type class.
class _TypeClassGenerator extends TypeVisitor<_TypeClass> {
  final bool isConst;
  final Resolver? resolver;

  _TypeClassGenerator(this.resolver, {this.isConst = true});

  @override
  _TypeClass visitArrayType(ArrayType node) {
    final innerTypeClass =
        node.type.accept(_TypeClassGenerator(resolver, isConst: false));
    final ifConst = innerTypeClass.canBeConst && isConst ? 'const ' : '';
    return _TypeClass(
      '$ifConst$_jArray$_typeClassSuffix(${innerTypeClass.name})',
      innerTypeClass.canBeConst,
    );
  }

  @override
  _TypeClass visitDeclaredType(DeclaredType node) {
    if (node.classDecl.binaryName == 'java.lang.Object' ||
        node.classDecl.binaryName == 'java.lang.String') {
      final ifConst = isConst ? 'const ' : '';
      return _TypeClass(
          '$ifConst$_jni.${node.classDecl.finalName}$_typeClassSuffix()', true);
    }
    final allTypeParams = node.classDecl.allTypeParams
        .accept(const _TypeParamGenerator(withExtends: false))
        .toList();

    // The ones that are declared.
    final definedTypeClasses =
        node.params.accept(_TypeClassGenerator(resolver, isConst: false));

    // Can be const if all the type parameters are defined and each of them are
    // also const.
    final canBeConst = definedTypeClasses.every((e) => e.canBeConst);

    // Replacing the declared ones. They come at the end.
    // The rest will be `JObjectType`.
    if (allTypeParams.length >= node.params.length) {
      allTypeParams.replaceRange(
        0,
        allTypeParams.length - node.params.length,
        List.filled(
          allTypeParams.length - node.params.length,
          // Adding const to subexpressions if the entire expression is not const.
          '${canBeConst ? '' : 'const '}$_jObject$_typeClassSuffix()',
        ),
      );
      allTypeParams.replaceRange(
        allTypeParams.length - node.params.length,
        allTypeParams.length,
        // Adding const to subexpressions if the entire expression is not const.
        definedTypeClasses.map((param) =>
            '${param.canBeConst && !canBeConst ? 'const ' : ''}${param.name}'),
      );
    }

    final args = allTypeParams.join(', ');
    final ifConst = isConst && canBeConst ? 'const ' : '';
    final prefix = resolver?.resolvePrefix(node.classDecl.binaryName) ?? '';
    return _TypeClass(
      '$ifConst$prefix$_typeClassPrefix${node.classDecl.finalName}$_typeClassSuffix($args)',
      canBeConst,
    );
  }

  @override
  _TypeClass visitPrimitiveType(PrimitiveType node) {
    final ifConst = isConst ? 'const ' : '';
    return _TypeClass('$ifConst$_jni.${node.jniType}$_typeClassSuffix()', true);
  }

  @override
  _TypeClass visitTypeVar(TypeVar node) {
    return _TypeClass(node.name, false);
  }

  @override
  _TypeClass visitWildcard(Wildcard node) {
    // TODO(#141): Support wildcards
    return super.visitWildcard(node);
  }

  @override
  _TypeClass visitNonPrimitiveType(ReferredType node) {
    final ifConst = isConst ? 'const ' : '';
    return _TypeClass('$ifConst$_jObject$_typeClassSuffix()', true);
  }
}

class _TypeParamGenerator extends Visitor<TypeParam, String> {
  const _TypeParamGenerator({required this.withExtends});

  final bool withExtends;

  @override
  String visit(TypeParam node) {
    if (!withExtends) {
      return node.name;
    }
    // TODO(#144): resolve the actual type being extended, if any.
    return '$_typeParamPrefix${node.name} extends $_jObject';
  }
}

class _JniResultGetter extends TypeVisitor<String> {
  const _JniResultGetter();

  @override
  String visitPrimitiveType(PrimitiveType node) {
    if (node.name == 'void') return 'check()';
    if (node.name == 'double') return 'doubleFloat';
    if (node.name == 'int') return 'integer';
    return node.name;
  }

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return 'object';
  }
}

/// Type signature for C-based bindings.
///
/// When `isFFi` is `true`, it generates the ffi type signature and when it's
/// false, it generates the dart type signature.
///
/// For example `ffi.Int32` is an ffi type signature while `int` is a Dart one:
/// ```dart
/// jniLookup<ffi.NativeFunction<jni.JniResult Function(ffi.Int32, ffi.Int32)>>(
///       "sum")
///   .asFunction<jni.JniResult Function(int, int)>();
/// ```
class _TypeSig extends TypeVisitor<String> {
  const _TypeSig({required this.isFfi});

  final bool isFfi;

  @override
  String visitPrimitiveType(PrimitiveType node) {
    if (isFfi) return '$_ffi.${node.ffiType}';
    if (node.name == 'boolean') return 'int';
    return node.dartType;
  }

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return _voidPointer;
  }
}

class _TypeName extends TypeVisitor<String> {
  const _TypeName();

  @override
  String visitPrimitiveType(PrimitiveType node) {
    return node.name;
  }

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return 'object';
  }
}

class _CallType extends TypeVisitor<String> {
  const _CallType();

  @override
  String visitPrimitiveType(PrimitiveType node) {
    return '$_jCallType.${node.name}Type';
  }

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return '$_jCallType.objectType';
  }
}

class _ToNativeSuffix extends TypeVisitor<String> {
  const _ToNativeSuffix();

  @override
  String visitPrimitiveType(PrimitiveType node) {
    if (node.name == 'boolean') {
      return ' ? 1 : 0';
    }
    return '';
  }

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return '.$_selfPointer';
  }
}

class _FromNative extends TypeVisitor<String> {
  const _FromNative(this.resolver, this.value);

  final Resolver? resolver;
  final String value;

  @override
  String visitPrimitiveType(PrimitiveType node) {
    return value;
  }

  @override
  String visitNonPrimitiveType(ReferredType node) {
    final typeClass = node.accept(_TypeClassGenerator(resolver)).name;
    return '$typeClass.fromRef($value)';
  }
}

class _FieldGenerator extends Visitor<Field, void> {
  const _FieldGenerator(this.config, this.resolver, this.s);

  final Config config;
  final Resolver? resolver;
  final StringSink s;

  void writeCAccessor(Field node) {
    final name = node.finalName;
    final cName = node.accept(const CFieldName());
    final ifRef = node.isStatic ? '' : '$_jPointer, ';

    s.write('''
  static final _get_$name =
      $_lookup<$_ffi.NativeFunction<$_jResult Function($ifRef)>>(
              "get_$cName")
          .asFunction<$_jResult Function($ifRef)>();

''');

    if (!node.isFinal) {
      final ffiSig = node.type.accept(const _TypeSig(isFfi: true));
      final dartSig = node.type.accept(const _TypeSig(isFfi: false));
      s.write('''
  static final _set_$name =
      $_lookup<$_ffi.NativeFunction<$_jThrowable Function($ifRef$ffiSig)>>(
              "set_$cName")
          .asFunction<$_jThrowable Function($ifRef$dartSig)>();

''');
    }
  }

  String cGetter(Field node) {
    final name = node.finalName;
    final getter = node.type.accept(const _JniResultGetter());
    final self = node.isStatic ? '' : _selfPointer;
    return '_get_$name($self).$getter';
  }

  String cSetter(Field node) {
    final name = node.finalName;
    final self = node.isStatic ? '' : '$_selfPointer, ';
    final toNativeSuffix = node.type.accept(const _ToNativeSuffix());
    return '_set_$name(${self}value$toNativeSuffix)';
  }

  void writeDartOnlyAccessor(Field node) {
    final name = node.finalName;
    final ifStatic = node.isStatic ? 'Static' : '';
    final descriptor = node.type.accept(const Descriptor());
    s.write('''
  static final _id_$name = 
      $_accessors.get${ifStatic}FieldIDOf(
        $_classRef, 
        r"${node.name}",
        r"$descriptor",
      );
''');
  }

  String dartOnlyGetter(Field node) {
    final name = node.finalName;
    final self = node.isStatic ? _classRef : _selfPointer;
    final ifStatic = node.isStatic ? 'Static' : '';
    final callType = node.type.accept(const _CallType());
    final resultGetter = node.type.accept(const _JniResultGetter());
    return '$_accessors.get${ifStatic}Field($self, _id_$name, $callType)'
        '.$resultGetter';
  }

  String dartOnlySetter(Field node) {
    final name = node.finalName;
    final self = node.isStatic ? _classRef : _selfPointer;
    final ifStatic = node.isStatic ? 'Static' : '';
    final fieldType = node.type.accept(const _TypeName()).capitalize();
    final toNativeSuffix = node.type.accept(const _ToNativeSuffix());
    return '$_env.Set$ifStatic${fieldType}Field($self, _id_$name, value$toNativeSuffix)';
  }

  void writeDocs(Field node, {required bool writeDeleteInstructions}) {
    final originalDecl = '${node.type.shorthand} ${node.name}';
    s.writeln('  /// from: ${node.modifiers.join(' ')} $originalDecl');
    if (node.type.kind != Kind.primitive && writeDeleteInstructions) {
      s.writeln(_deleteInstruction);
    }
    node.javadoc?.accept(_DocGenerator(s, depth: 1));
  }

  @override
  void visit(Field node) {
    final isCBased = config.outputConfig.bindingsType == BindingsType.cBased;

    // Check if it should be a `static const` getter.
    if (node.isFinal && node.isStatic && node.defaultValue != null) {
      final name = node.finalName;
      final value = node.defaultValue!;
      // TODO(#31): Should we leave String as a normal getter instead?
      if (value is String || value is num || value is bool) {
        writeDocs(node, writeDeleteInstructions: false);
        s.write('  static const $name = ');
        if (value is String) {
          s.write('r"""$value"""');
        } else {
          s.write(value);
        }
        s.writeln(';\n');
        return;
      }
    }

    // Accessors
    (isCBased ? writeCAccessor : writeDartOnlyAccessor)(node);

    // Getter docs
    writeDocs(node, writeDeleteInstructions: true);

    final name = node.finalName;
    final ifStatic = node.isStatic ? 'static ' : '';
    final type = node.type.accept(_TypeGenerator(resolver));
    s.write('$ifStatic$type get $name => ');
    s.write(node.type.accept(
      _FromNative(resolver, (isCBased ? cGetter : dartOnlyGetter)(node)),
    ));
    s.writeln(';\n');
    if (!node.isFinal) {
      // Setter docs
      writeDocs(node, writeDeleteInstructions: true);

      s.write('${ifStatic}set $name($type value) => ');
      s.write((isCBased ? cSetter : dartOnlySetter)(node));
      s.writeln(';\n');
    }
  }
}

class _MethodTypeSig extends Visitor<Method, String> {
  const _MethodTypeSig({required this.isFfi});

  final bool isFfi;

  @override
  String visit(Method node) {
    final args = [
      if (!node.isCtor && !node.isStatic) _voidPointer,
      ...node.params.map((param) => param.type).accept(
            _TypeSig(isFfi: isFfi),
          )
    ].join(', ');
    return '$_jResult Function($args)';
  }
}

/// Generates Dart bindings for Java methods.
class _MethodGenerator extends Visitor<Method, void> {
  const _MethodGenerator(this.config, this.resolver, this.s);

  final Config config;
  final Resolver? resolver;
  final StringSink s;

  void writeCAccessor(Method node) {
    final name = node.finalName;
    final cName = node.accept(const CMethodName());
    final ffiSig = node.accept(const _MethodTypeSig(isFfi: true));
    final dartSig = node.accept(const _MethodTypeSig(isFfi: false));
    s.write('''
  static final _$name =
          $_lookup<$_ffi.NativeFunction<$ffiSig>>("$cName")
      .asFunction<$dartSig>();

''');
  }

  void writeDartOnlyAccessor(Method node) {
    final name = node.finalName;
    final ifStatic = node.isStatic ? 'Static' : '';
    final signature = node.accept(const MethodSignature());
    s.write('''
  static final _id_$name = $_accessors.get${ifStatic}MethodIDOf(
          $_classRef, r"${node.name}", r"$signature");

''');
  }

  bool isSuspendFun(Method node) {
    return node.asyncReturnType != null;
  }

  String cCtor(Method node) {
    final name = node.finalName;
    final params =
        node.params.accept(const _ParamCall(isCBased: true)).join(', ');
    return '_$name($params)';
  }

  String dartOnlyCtor(Method node) {
    final name = node.finalName;
    final params =
        node.params.accept(const _ParamCall(isCBased: false)).join(', ');
    return '$_accessors.newObjectWithArgs($_classRef, _id_$name, [$params])';
  }

  String cMethodCall(Method node) {
    final name = node.finalName;
    final params = [
      if (!node.isStatic) _selfPointer,
      ...node.params.accept(const _ParamCall(isCBased: true)),
    ].join(', ');
    final resultGetter = node.returnType.accept(const _JniResultGetter());
    return '_$name($params).$resultGetter';
  }

  String dartOnlyMethodCall(Method node) {
    final name = node.finalName;
    final ifStatic = node.isStatic ? 'Static' : '';
    final self = node.isStatic ? _classRef : _selfPointer;
    final callType = node.returnType.accept(const _CallType());
    final params =
        node.params.accept(const _ParamCall(isCBased: false)).join(', ');
    final resultGetter = node.returnType.accept(const _JniResultGetter());
    return '$_accessors.call${ifStatic}MethodWithArgs'
        '($self, _id_$name, $callType, [$params]).$resultGetter';
  }

  @override
  void visit(Method node) {
    final isCBased = config.outputConfig.bindingsType == BindingsType.cBased;

    // Accessors
    (isCBased ? writeCAccessor : writeDartOnlyAccessor)(node);

    // Docs
    s.write('  /// from: ');
    s.writeAll(node.modifiers.map((m) => '$m '));
    s.write('${node.returnType.shorthand} ${node.name}(');
    s.writeAll(node.params.map((p) => '${p.type.shorthand} ${p.name}'), ', ');
    s.writeln(')');
    if (node.returnType.kind != Kind.primitive || node.isCtor) {
      s.writeln(_deleteInstruction);
    }
    node.javadoc?.accept(_DocGenerator(s, depth: 1));

    if (node.isCtor) {
      final className = node.classDecl.finalName;
      final name = node.finalName;
      final ctorName = name == 'ctor' ? className : '$className.$name';
      final paramsDef = node.params.accept(_ParamDef(resolver)).delimited(', ');
      final typeClassDef = _encloseIfNotEmpty(
        '{',
        node.classDecl.allTypeParams
            .accept(const _CtorTypeClassDef())
            .delimited(', '),
        '}',
      );
      final superClass = (node.classDecl.superclass!.type as DeclaredType);
      final superTypeClassesCall = superClass.classDecl == ClassDecl.object
          ? ''
          : superClass.params
              .accept(_TypeClassGenerator(resolver))
              .map((typeClass) => '${typeClass.name},')
              .join(_newLine(depth: 2));
      final ctorExpr = (isCBased ? cCtor : dartOnlyCtor)(node);
      s.write('''
  $ctorName($paramsDef$typeClassDef) : super.fromRef(
    $superTypeClassesCall
    $ctorExpr.object
  );

''');
      return;
    }

    final name = node.finalName;
    final returnType = isSuspendFun(node)
        ? 'Future<${node.asyncReturnType!.accept(_TypeGenerator(resolver))}>'
        : node.returnType.accept(_TypeGenerator(resolver));
    final returnTypeClass = (node.asyncReturnType ?? node.returnType)
        .accept(_TypeClassGenerator(resolver))
        .name;
    final ifStatic = node.isStatic ? 'static ' : '';
    final defArgs = node.params.accept(_ParamDef(resolver)).toList();
    final typeClassDef = _encloseIfNotEmpty(
      '{',
      node.typeParams.accept(const _MethodTypeClassDef()).delimited(', '),
      '}',
    );
    final typeParamsDef = _encloseIfNotEmpty(
      '<',
      node.typeParams
          .accept(const _TypeParamGenerator(withExtends: true))
          .join(', '),
      '>',
    );
    if (isSuspendFun(node)) {
      defArgs.removeLast();
    }
    final params = defArgs.delimited(', ');
    s.write('  $ifStatic$returnType $name$typeParamsDef($params$typeClassDef)');
    final callExpr = (isCBased ? cMethodCall : dartOnlyMethodCall)(node);
    if (isSuspendFun(node)) {
      final returning =
          node.asyncReturnType!.accept(_FromNative(resolver, '\$o'));
      s.write('''async {
    final \$p = ReceivePort();
    final \$c = $_jObject.fromRef($_jni.Jni.newPortContinuation(\$p));
    $callExpr;
    final \$o = $_jPointer.fromAddress(await \$p.first);
    final \$k = $returnTypeClass.getClass().reference;
    if ($_jni.Jni.env.IsInstanceOf(\$o, \$k) == 0) {
      throw "Failed";
    }
    return $returning;
  }

''');
    } else {
      final returning = node.returnType.accept(_FromNative(resolver, callExpr));
      s.writeln('=> $returning;\n');
    }
  }
}

/// Generates the method type param definition.
///
/// For example `required JObjType<T> $T` in:
/// ```dart
/// void bar(..., {required JObjType<T> $T}) => ...
/// ```
class _MethodTypeClassDef extends Visitor<TypeParam, String> {
  const _MethodTypeClassDef();

  @override
  String visit(TypeParam node) {
    return 'required $_jType<$_typeParamPrefix${node.name}> ${node.name}';
  }
}

/// Generates the class type param definition. Used only in constructors.
///
/// For example `required this.$T` in:
/// ```dart
/// class Foo {
///   final JObjType<T> $T;
///   Foo(..., {required this.$T}) => ...
/// }
/// ```
class _CtorTypeClassDef extends Visitor<TypeParam, String> {
  const _CtorTypeClassDef();

  @override
  String visit(TypeParam node) {
    return 'required this.${node.name}';
  }
}

/// Method parameter's definition.
///
/// For example `Foo foo` in:
/// ```dart
/// void bar(Foo foo) => ...
/// ```
class _ParamDef extends Visitor<Param, String> {
  const _ParamDef(this.resolver);

  final Resolver? resolver;

  @override
  String visit(Param node) {
    final type = node.type.accept(_TypeGenerator(resolver));
    return '$type ${node.finalName}';
  }
}

/// Method parameter used in calling the native method.
///
/// For example `foo.reference` in:
/// ```dart
/// void bar(Foo foo) => _bar(foo.reference);
/// ```
class _ParamCall extends Visitor<Param, String> {
  final bool isCBased;

  const _ParamCall({required this.isCBased});

  @override
  String visit(Param node) {
    final nativeSuffix = node.type.accept(const _ToNativeSuffix());
    final paramCall = '${node.finalName}$nativeSuffix';
    if (!isCBased) {
      // We need to wrap [paramCall] in the appropriate wrapper class.
      return node.type.accept(_JValueWrapper(paramCall));
    }
    return paramCall;
  }
}

/// Wraps the parameter in the appropriate JValue wrapper class.
///
/// For instance, `int` in Dart can be mapped to `long` or `int` or ... in Java.
/// The wrapper class is how we identify the type in pure dart bindings.
class _JValueWrapper extends TypeVisitor<String> {
  final String param;

  _JValueWrapper(this.param);

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return param;
  }

  @override
  String visitPrimitiveType(PrimitiveType node) {
    if (node.name == 'long' ||
        node.name == 'double' ||
        node.name == 'boolean') {
      return param;
    }
    return '$_jni.JValue${node.name.capitalize()}($param)';
  }
}
