// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../config/config.dart';
import '../elements/elements.dart';
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
const _typeClassPrefix = '\$';
const _typeClassSuffix = 'Type';

// Dart only related
const _classRef = '_classRef';
const _env = 'jniEnv';
const _accessors = 'jniAccessors';

// Docs
const _deleteInstruction =
    '  /// The returned object must be deleted after use, '
    'by calling the `delete` method.';

const _lookup = 'jniLookup';
const _selfPointer = 'reference';

extension _StringX on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
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

// **Naming Convention**
//
// Let's take the following code as an example:
//
// ```dart
// Method definition
// void f<T extends num, U>(JType<T> $T, JType<U> $U, T t, U u) {
//   // ...
// }
// f<int, String>($T, $U, t, u); // Calling the Method
// ```
//
// Here `f` will be replaced according to the place of usage.
//
// * `fArgsDef` refers to `T t, U u` – the arguments in the method
//   definition.
// * `fArgsCall` refer to `t, u` – the arguments passed to call the method.
// * `fTypeParamsDef` refers to `<T extends num, U>` – the type parameters
//   of the method at the point of definition.
// * `fTypeParamsCall` refers to `<int, String>` – the type parameters when
//   calling, or whenever we don't want to have the `extends` keyword.
// * `fTypeClassesDef` refers to `JType<T> $T, JType<U> $U`.
// * `fTypeClassesCall` refers to `$T, $U` when calling the method.

class DartGenerator extends Visitor<Classes, void> {
  @override
  void visit(Classes node) {}
}

class _ClassGenerator extends Visitor<ClassDecl, void> {
  _ClassGenerator(this.config, this.s);

  final Config config;
  final StringBuffer s;

  static const staticTypeGetter = 'type';
  static const instanceTypeGetter = '\$$staticTypeGetter';

  static const arrayExtensionPrefix = '\$';
  static const arrayExtensionSuffix = 'Array';

  @override
  void visit(ClassDecl node) {
    final isDartOnly =
        config.outputConfig.bindingsType == BindingsType.dartOnly;

    // Docs
    s.write('/// from: ${node.binaryName}\n');
    node.javadoc?.accept(_DocGenerator(s, depth: 0));

    // Class definition
    final name = node.finalName;
    final superName = node.superclass!.accept(const _TypeGenerator());
    final typeParamsDef = _encloseIfNotEmpty(
      '<',
      node.allTypeParams
          .accept(const _TypeParamGenerator(withExtends: true))
          .join(', '),
      '>',
    );
    final typeParams = node.allTypeParams
        .accept(const _TypeParamGenerator(withExtends: false));
    final typeParamsCall = _encloseIfNotEmpty('<', typeParams.join(', '), '>');
    final staticTypeGetterCallArgs = _encloseIfNotEmpty(
      '(',
      typeParams.map((typeParams) => '$_typeParamPrefix$typeParams').join(', '),
      ')',
    );
    final typeClassDefinitions = typeParams
        .map((typeParam) =>
            'final $_jType<$typeParam> $_typeParamPrefix$typeParam;')
        .join(_newLine(depth: 1));
    final ctorTypeClassesDef = typeParams
        .map((typeParam) => 'this.$_typeParamPrefix$typeParam,')
        .join(_newLine(depth: 2));
    final superTypeClassesCall = (node.superclass!.type as DeclaredType)
        .params
        .accept(const _TypeClassGenerator())
        .map((typeClass) => '$typeClass,')
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
    ref,
  );

''');

    if (isDartOnly) {
      final internalName = node.binaryName.replaceAll('.', '/');
      s.write('''
  static final $_classRef = $_accessors.getClassOf(r"$internalName");

''');
    }

    // Static TypeClass getter
    s.write(
        '  /// The type which includes information such as the signature of this class.');
    final typeClassName = '$_typeClassPrefix$name$_typeClassSuffix';
    if (typeParams.isEmpty) {
      s.write('static const $staticTypeGetter = $typeClassName();\n');
    } else {
      final staticTypeGetterTypeClassesDef = typeParams
          .map(
              (typeParam) => '$_jType<$typeParam> $_typeParamPrefix$typeParam,')
          .join(_newLine(depth: 2));
      final typeClassesCall = typeParams
          .map((typeParam) => '$_typeParamPrefix$typeParam,')
          .join(_newLine(depth: 3));
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
    final fieldGenerator = _FieldGenerator(config, s);
    for (final field in node.fields) {
      field.accept(fieldGenerator);
    }
    final methodGenerator = _MethodGenerator(s);
    for (final method in node.methods) {
      method.accept(methodGenerator);
    }

    // End of Class definition
    s.write('}');

    // TypeClass definition
    final typeClassesCall = typeParams
        .map((typeParam) => '$_typeParamPrefix$typeParam,')
        .join(_newLine(depth: 2));
    final signature = node.signature;
    s.write('''
class $typeClassName$typeParamsDef extends $_jType<$name$typeParamsCall> {
  $typeClassDefinitions

  const $typeClassName(
    $ctorTypeClassesDef
  );

  @override
  String get signature => r"$signature";

  @override
  $name$typeParams fromRef($_jPointer ref) => $name.fromRef(
    $typeClassesCall
    ref
  );
}

''');

    // Array extension
    s.write('''
extension $arrayExtensionPrefix$name$arrayExtensionSuffix on $_jArray<$name$typeParamsCall> {
  $name$typeParamsCall operator [](int index) {
    return (elementType as $typeClassName$typeParamsCall);
  }

  void operator []=(int index, $name$typeParamsCall value) {
    (this as $_jArray<$_jObject>)[index] = value;
  }
}
''');
  }
}

class _DocGenerator extends Visitor<JavaDocComment, void> {
  const _DocGenerator(this.s, {required this.depth});

  final StringBuffer s;
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
        .join('\n$indent/// ');
    s.write('''
$indent///
$indent/// $comments
''');
  }
}

class _TypeGenerator extends TypeVisitor<String> {
  const _TypeGenerator();

  @override
  String visitArrayType(ArrayType node) {
    final innerType = node.type;
    if (innerType.kind == Kind.primitive) {
      return '$_jArray<${(innerType.type as PrimitiveType).jniType}>';
    }
    return '$_jArray<${innerType.accept(this)}>';
  }

  @override
  String visitDeclaredType(DeclaredType node) {
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
    return '${node.classDecl.finalName}$typeParams';
  }

  @override
  String visitPrimitiveType(PrimitiveType node) {
    return node.dartType;
  }

  @override
  String visitTypeVar(TypeVar node) {
    return node.name;
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

class _TypeClassGenerator extends TypeVisitor<_TypeClass> {
  final bool isConst;

  const _TypeClassGenerator({this.isConst = true});

  @override
  _TypeClass visitArrayType(ArrayType node) {
    final innerTypeClass =
        node.type.accept(const _TypeClassGenerator(isConst: false));
    final ifConst = innerTypeClass.canBeConst && isConst ? 'const ' : '';
    return _TypeClass(
      '$ifConst$_jArray$_typeClassSuffix<${innerTypeClass.name}>',
      innerTypeClass.canBeConst,
    );
  }

  @override
  _TypeClass visitDeclaredType(DeclaredType node) {
    final allTypeParams = node.classDecl.allTypeParams
        .accept(const _TypeParamGenerator(withExtends: false))
        .map((typeParam) => '$_typeParamPrefix$typeParam')
        .toList();

    // The ones that are declared.
    final definedTypeClasses =
        node.params.accept(const _TypeClassGenerator(isConst: false));

    // Can be const if all the type parameters are defined and each of them are
    // also const.
    final canBeConst = allTypeParams.length == definedTypeClasses.length &&
        definedTypeClasses.every((e) => e.canBeConst);

    // Adding const to `JObjectType`s if the entire expression is not const.
    final constJObject = canBeConst ? '' : 'const ';

    // Replacing the declared ones. They come at the end.
    // The rest will be `JObjectType`.
    if (allTypeParams.length >= node.params.length) {
      allTypeParams.replaceRange(
        0,
        allTypeParams.length - node.params.length,
        List.filled(
          allTypeParams.length - node.params.length,
          '$constJObject$_jObject$_typeClassSuffix()',
        ),
      );
      allTypeParams.replaceRange(
        allTypeParams.length - node.params.length,
        allTypeParams.length,
        definedTypeClasses.map((param) => param.name),
      );
    }

    final args = allTypeParams.join(', ');
    final ifConst = isConst && canBeConst ? 'const ' : '';
    return _TypeClass(
      '$ifConst$_typeClassPrefix${node.classDecl.finalName}$_typeClassSuffix($args)',
      canBeConst,
    );
  }

  @override
  _TypeClass visitPrimitiveType(PrimitiveType node) {
    final ifConst = isConst ? 'const ' : '';
    return _TypeClass('$ifConst${node.jniType}$_typeClassSuffix', true);
  }

  @override
  _TypeClass visitTypeVar(TypeVar node) {
    return _TypeClass('$_typeParamPrefix${node.name}', false);
  }

  @override
  _TypeClass visitWildcard(Wildcard node) {
    // TODO(#141): Support wildcards
    return super.visitWildcard(node);
  }

  @override
  _TypeClass visitNonPrimitiveType(ReferredType node) {
    return _TypeClass('$_jObject$_typeClassSuffix', true);
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
    return '${node.name} extends $_jObject';
  }
}

class _JniResultGetter extends TypeVisitor<String> {
  const _JniResultGetter();

  @override
  String visitPrimitiveType(PrimitiveType node) {
    if (node.name == 'void') return 'check()';
    if (node.name == 'double') return 'doubleFloat';
    return node.name;
  }

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return 'object';
  }
}

class _Descriptor extends TypeVisitor<String> {
  const _Descriptor();

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

class _FfiTypeSig extends TypeVisitor<String> {
  const _FfiTypeSig();

  @override
  String visitPrimitiveType(PrimitiveType node) {
    return '$_ffi${node.ffiType}';
  }

  @override
  String visitNonPrimitiveType(ReferredType node) {
    return _voidPointer;
  }
}

class _DartTypeSig extends TypeVisitor<String> {
  const _DartTypeSig();

  @override
  String visitPrimitiveType(PrimitiveType node) {
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
  final String value;

  const _FromNative(this.value);

  @override
  String visitPrimitiveType(PrimitiveType node) {
    return value;
  }

  @override
  String visitNonPrimitiveType(ReferredType node) {
    final typeClass = node.accept(const _TypeClassGenerator()).name;
    return '$typeClass.fromRef($value)';
  }
}

class _FieldGenerator extends Visitor<Field, void> {
  const _FieldGenerator(this.config, this.s);

  final Config config;
  final StringBuffer s;

  void writeCAccessor(Field node) {
    final name = '${node.classDecl.uniqueName}__${node.finalName}';
    final ifRef = node.isStatic ? '' : '$_voidPointer, ';

    s.write('''
  static final _get_$name =
      $_lookup<$_ffi.NativeFunction<$_jResult Function($ifRef)>>(
              "get_$name")
          .asFunction<$_jResult Function()>();

''');

    if (!node.isFinal) {
      final ffiSig = node.type.accept(const _FfiTypeSig());
      final dartSig = node.type.accept(const _DartTypeSig());
      s.write('''
  static final _set_$name =
      $_lookup<$_ffi.NativeFunction<$_jThrowable Function($ifRef$ffiSig)>>(
              "set_$name")
          .asFunction<$_jThrowable Function($ifRef$dartSig)>();

''');
    }
  }

  String cGetter(Field node) {
    final name = node.finalName;
    final getter = node.type.accept(_JniResultGetter());
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
    final descriptor = node.type.accept(const _Descriptor());
    s.write('''
  static final _id_$name = 
      $_accessors.get${ifStatic}FieldIDOf(
        $_classRef, 
        "${node.name}",
        "$descriptor",
      );
''');
  }

  String dartOnlyGetter(Field node) {
    final name = node.finalName;
    final self = node.isStatic ? _classRef : _selfPointer;
    final ifStatic = node.isStatic ? 'Static' : '';
    final callType = '$_jCallType.${node.type.accept(const _TypeName())}Type';
    final resultGetter = node.type.accept(const _JniResultGetter());
    return '$_accessors.get${ifStatic}Field($self, _id_$name, $callType)'
        '.$resultGetter;';
  }

  String dartOnlySetter(Field node) {
    final name = node.finalName;
    final self = node.isStatic ? _classRef : _selfPointer;
    final ifStatic = node.isStatic ? 'Static' : '';
    final fieldType = node.type.accept(const _TypeName()).capitalize();
    final toNativeSuffix = node.type.accept(const _ToNativeSuffix());
    return '$_env.Set$ifStatic${fieldType}Field($self, _id_$name, value$toNativeSuffix);';
  }

  void writeDocs(Field node) {
    final originalDecl = '${node.type.shorthand} ${node.name}';
    s.writeln('  /// from: ${node.modifiers.join(' ')} $originalDecl');
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
        writeDocs(node);
        s.write('  static const $name = ');
        if (value is String) {
          s.write('r"""$value"""');
        } else {
          s.write(value);
        }
        s.write(';\n');
        return;
      }
    }

    // Accessors
    (isCBased ? writeCAccessor : writeDartOnlyAccessor)(node);

    // Docs
    writeDocs(node);
    if (node.type.kind != Kind.primitive) {
      s.writeln(_deleteInstruction);
    }

    final name = node.finalName;
    final ifStatic = node.isStatic ? 'static ' : '';
    final type = node.type.accept(const _TypeGenerator());
    s.write('$ifStatic$type get $name => ');
    s.write(node.type.accept(
      _FromNative((isCBased ? cGetter : dartOnlyGetter)(node)),
    ));
    if (!node.isFinal) {
      s.write('${ifStatic}set $name($type value) => ');
      s.write(node.type.accept(
        _FromNative((isCBased ? cSetter : dartOnlySetter)(node)),
      ));
    }
  }
}

class _MethodGenerator extends Visitor<Method, void> {
  const _MethodGenerator(this.s);

  final StringBuffer s;

  @override
  void visit(Method node) {
    // TODO: implement visit
  }
}
