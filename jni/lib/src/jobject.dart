// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'types.dart';

class JObjectType extends JObjType<JObject> {
  const JObjectType();

  @override
  String get signature => "Ljava/lang/Object;";

  @override
  JObject fromRef(Pointer<Void> ref) => JObject.fromRef(ref);

  @override
  JObjType get superType => const JObjectType();

  // TODO(#70): Once interface implementation lands, other than [superType],
  // we should have a list of implemented interfaces.

  @override
  final int superCount = 0;

  @override
  int get hashCode => (JObjectType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == JObjectType && other is JObjectType;
  }
}

Pointer<T> _getID<T extends NativeType>(
  JniPointerResult Function(
          Pointer<Void> ptr, Pointer<Char> name, Pointer<Char> sig)
      f,
  Pointer<Void> ptr,
  String name,
  String sig,
) {
  final result = using(
      (arena) => f(ptr, name.toNativeChars(arena), sig.toNativeChars(arena)));
  if (result.exception != nullptr) {
    _accessors.throwException(result.exception);
  }
  return result.value.cast<T>();
}

int _getCallType(int? callType, int defaultType, Set<int> allowed) {
  if (callType == null) return defaultType;
  if (allowed.contains(callType)) return callType;
  throw InvalidCallTypeException(callType, allowed);
}

T _callOrGet<T>(int? callType, JniResult Function(int) function) {
  final int finalCallType;
  late T result;
  switch (T) {
    case bool:
      finalCallType = _getCallType(
          callType, JniCallType.booleanType, {JniCallType.booleanType});
      result = function(finalCallType).boolean as T;
      break;
    case int:
      finalCallType = _getCallType(callType, JniCallType.intType, {
        JniCallType.byteType,
        JniCallType.charType,
        JniCallType.shortType,
        JniCallType.intType,
        JniCallType.longType,
      });
      final jniResult = function(finalCallType);
      switch (finalCallType) {
        case JniCallType.byteType:
          result = jniResult.byte as T;
          break;
        case JniCallType.shortType:
          result = jniResult.short as T;
          break;
        case JniCallType.charType:
          result = jniResult.char as T;
          break;
        case JniCallType.intType:
          result = jniResult.integer as T;
          break;
        case JniCallType.longType:
          result = jniResult.long as T;
          break;
      }
      break;
    case double:
      finalCallType = _getCallType(callType, JniCallType.doubleType,
          {JniCallType.floatType, JniCallType.doubleType});
      final jniResult = function(finalCallType);
      switch (finalCallType) {
        case JniCallType.floatType:
          result = jniResult.float as T;
          break;
        case JniCallType.doubleType:
          result = jniResult.doubleFloat as T;
          break;
      }
      break;
    case String:
    case JObject:
    case JString:
      finalCallType = _getCallType(
          callType, JniCallType.objectType, {JniCallType.objectType});
      final ref = function(finalCallType).object;
      final ctor = T == String
          ? (ref) => _env.asDartString(ref, deleteOriginal: true)
          : (T == JObject ? JObject.fromRef : JString.fromRef);
      result = ctor(ref) as T;
      break;
    case Pointer<Void>: // JObjectPtr
      finalCallType = _getCallType(
          callType, JniCallType.objectType, {JniCallType.objectType});
      result = function(finalCallType).object as T;
      break;
    case _VoidType:
      finalCallType =
          _getCallType(callType, JniCallType.voidType, {JniCallType.voidType});
      function(finalCallType).check();
      result = null as T;
      break;
    case dynamic:
      throw UnsupportedError("Return type not specified for JNI call");
    default:
      throw UnsupportedError('Unknown type $T');
  }
  return result;
}

T _callMethod<T>(int? callType, List<dynamic> args,
        JniResult Function(int, Pointer<JValue>) f) =>
    using((arena) {
      final jArgs = JValueArgs(args, arena);
      return _callOrGet<T>(callType, (ct) => f(ct, jArgs.values));
    });

T _getField<T>(int? callType, JniResult Function(int) f) {
  final result = _callOrGet<T>(callType, f);
  return result;
}

/// A high-level wrapper for JNI global object reference.
///
/// This is the base class for classes generated by `jnigen`.
class JObject extends JReference {
  JObjType<JObject>? _$type;
  JObjType<JObject> get $type => _$type ??= type;

  /// The type which includes information such as the signature of this class.
  static const JObjType<JObject> type = JObjectType();

  /// Construct a new [JObject] with [reference] as its underlying reference.
  JObject.fromRef(JObjectPtr reference) : super.fromRef(reference);

  JniClass? _jniClass;

  JniClass get _class {
    return _jniClass ??= getClass();
  }

  /// Deletes the JNI reference and marks this object as deleted. Any further
  /// uses will throw [UseAfterFreeException].
  @override
  void delete() {
    _jniClass?.delete();
    super.delete();
  }

  /// Returns [JniClass] corresponding to concrete class of this object.
  ///
  /// This may be a subclass of compile-time class.
  JniClass getClass() {
    _ensureNotDeleted();
    final classRef = _env.GetObjectClass(reference);
    if (classRef == nullptr) {
      _accessors.throwException(_env.ExceptionOccurred());
    }
    return JniClass.fromRef(classRef);
  }

  /// Get [JFieldIDPtr] of instance field identified by [fieldName] & [signature].
  JFieldIDPtr getFieldID(String fieldName, String signature) {
    _ensureNotDeleted();
    return _getID(
        _accessors.getFieldID, _class.reference, fieldName, signature);
  }

  /// Get [JFieldIDPtr] of static field identified by [fieldName] & [signature].
  JFieldIDPtr getStaticFieldID(String fieldName, String signature) {
    _ensureNotDeleted();
    return _getID<jfieldID_>(
        _accessors.getStaticFieldID, _class.reference, fieldName, signature);
  }

  /// Get [JMethodIDPtr] of instance method [methodName] with [signature].
  JMethodIDPtr getMethodID(String methodName, String signature) {
    _ensureNotDeleted();
    return _getID<jmethodID_>(
        _accessors.getMethodID, _class.reference, methodName, signature);
  }

  /// Get [JMethodIDPtr] of static method [methodName] with [signature].
  JMethodIDPtr getStaticMethodID(String methodName, String signature) {
    _ensureNotDeleted();
    return _getID<jmethodID_>(
        _accessors.getStaticMethodID, _class.reference, methodName, signature);
  }

  /// Retrieve the value of the field using [fieldID].
  ///
  /// [callType] determines the return type of the underlying JNI call made.
  /// If the Java field is of `long` type, this must be [JniCallType.longType] and
  /// so on. Default is chosen based on return type [T], which maps int -> int,
  /// double -> double, void -> void, and JObject types to `Object`.
  ///
  /// If [T] is String or [JObject], required conversions are performed and
  /// final value is returned.
  T getField<T>(JFieldIDPtr fieldID, [int? callType]) {
    _ensureNotDeleted();
    if (callType == JniCallType.voidType) {
      throw ArgumentError("void is not a valid field type.");
    }
    return _getField<T>(
        callType, (ct) => _accessors.getField(reference, fieldID, ct));
  }

  /// Get value of the field identified by [name] and [signature].
  ///
  /// See [getField] for an explanation about [callType] parameter.
  T getFieldByName<T>(String name, String signature, [int? callType]) {
    final id = getFieldID(name, signature);
    return getField<T>(id, callType);
  }

  /// Get value of the static field using [fieldID].
  ///
  /// See [getField] for an explanation about [callType] parameter.
  T getStaticField<T>(JFieldIDPtr fieldID, [int? callType]) {
    if (callType == JniCallType.voidType) {
      throw ArgumentError("void is not a valid field type.");
    }
    _ensureNotDeleted();
    return _getField<T>(callType,
        (ct) => _accessors.getStaticField(_class.reference, fieldID, ct));
  }

  /// Get value of the static field identified by [name] and [signature].
  ///
  /// See [getField] for an explanation about [callType] parameter.
  T getStaticFieldByName<T>(String name, String signature, [int? callType]) {
    final id = getStaticFieldID(name, signature);
    return getStaticField<T>(id, callType);
  }

  /// Call the method using [methodID],
  ///
  /// [args] can consist of primitive types, JNI primitive wrappers such as
  /// [JValueLong], strings, and subclasses of [JObject].
  ///
  /// See [getField] for an explanation about [callType] and return type [T].
  T callMethod<T>(JMethodIDPtr methodID, List<dynamic> args, [int? callType]) {
    _ensureNotDeleted();
    return _callMethod<T>(callType, args,
        (ct, jvs) => _accessors.callMethod(reference, methodID, ct, jvs));
  }

  /// Call instance method identified by [name] and [signature].
  ///
  /// This implementation looks up the method and calls it using [callMethod].
  T callMethodByName<T>(String name, String signature, List<dynamic> args,
      [int? callType]) {
    final id = getMethodID(name, signature);
    return callMethod<T>(id, args, callType);
  }

  /// Call static method using [methodID]. See [callMethod] and [getField] for
  /// more details about [args] and [callType].
  T callStaticMethod<T>(JMethodIDPtr methodID, List<dynamic> args,
      [int? callType]) {
    _ensureNotDeleted();
    return _callMethod<T>(callType, args,
        (ct, jvs) => _accessors.callStaticMethod(reference, methodID, ct, jvs));
  }

  /// Call static method identified by [name] and [signature].
  ///
  /// This implementation looks up the method and calls [callStaticMethod].
  T callStaticMethodByName<T>(String name, String signature, List<dynamic> args,
      [int? callType]) {
    final id = getStaticMethodID(name, signature);
    return callStaticMethod<T>(id, args, callType);
  }

  /// Casts this object to another type.
  T castTo<T extends JObject>(JObjType<T> type, {bool deleteOriginal = false}) {
    if (deleteOriginal) {
      _jniClass?.delete();
      _setAsDeleted();
      return type.fromRef(reference);
    }
    final newRef = _env.NewGlobalRef(reference);
    return type.fromRef(newRef);
  }
}

/// A high level wrapper over a JNI class reference.
class JniClass extends JReference {
  /// Construct a new [JniClass] with [reference] as its underlying reference.
  JniClass.fromRef(JObjectPtr reference) : super.fromRef(reference);

  /// Get [JFieldIDPtr] of static field [fieldName] with [signature].
  JFieldIDPtr getStaticFieldID(String fieldName, String signature) {
    _ensureNotDeleted();
    return _getID<jfieldID_>(
        _accessors.getStaticFieldID, reference, fieldName, signature);
  }

  /// Get [JMethodIDPtr] of static method [methodName] with [signature].
  JMethodIDPtr getStaticMethodID(String methodName, String signature) {
    _ensureNotDeleted();
    return _getID<jmethodID_>(
        _accessors.getStaticMethodID, reference, methodName, signature);
  }

  /// Get [JFieldIDPtr] of field [fieldName] with [signature].
  JFieldIDPtr getFieldID(String fieldName, String signature) {
    _ensureNotDeleted();
    return _getID<jfieldID_>(
        _accessors.getFieldID, reference, fieldName, signature);
  }

  /// Get [JMethodIDPtr] of method [methodName] with [signature].
  JMethodIDPtr getMethodID(String methodName, String signature) {
    _ensureNotDeleted();
    return _getID<jmethodID_>(
        _accessors.getMethodID, reference, methodName, signature);
  }

  /// Get [JMethodIDPtr] of constructor with [signature].
  JMethodIDPtr getCtorID(String signature) => getMethodID("<init>", signature);

  /// Get the value of static field using [fieldID].
  ///
  /// See [JObject.getField] for more explanation about [callType].
  T getStaticField<T>(JFieldIDPtr fieldID, [int? callType]) {
    if (callType == JniCallType.voidType) {
      throw ArgumentError("void is not a valid field type.");
    }
    _ensureNotDeleted();
    return _getField<T>(
        callType, (ct) => _accessors.getStaticField(reference, fieldID, ct));
  }

  /// Get the value of static field identified by [name] and [signature].
  ///
  /// This implementation looks up the field ID and calls [getStaticField].
  T getStaticFieldByName<T>(String name, String signature, [int? callType]) {
    final id = getStaticFieldID(name, signature);
    return getStaticField<T>(id, callType);
  }

  /// Call the static method using [methodID].
  ///
  /// See [JObject.callMethod] and [JObject.getField] for more explanation
  /// about [args] and [callType].
  T callStaticMethod<T>(JMethodIDPtr methodID, List<dynamic> args,
      [int? callType]) {
    _ensureNotDeleted();
    return _callMethod<T>(callType, args,
        (ct, jvs) => _accessors.callStaticMethod(reference, methodID, ct, jvs));
  }

  /// Call the static method identified by [name] and [signature].
  ///
  /// This implementation looks up the method ID and calls [callStaticMethod].
  T callStaticMethodByName<T>(String name, String signature, List<dynamic> args,
      [int? callType]) {
    final id = getStaticMethodID(name, signature);
    return callStaticMethod<T>(id, args, callType);
  }

  /// Create a new instance of this class with [ctor] and [args].
  JObject newInstance(JMethodIDPtr ctor, List<dynamic> args) => using((arena) {
        _ensureNotDeleted();
        final jArgs = JValueArgs(args, arena);
        final res = _accessors.newObject(reference, ctor, jArgs.values).object;
        return JObject.fromRef(res);
      });
}
