// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:jni/src/accessors.dart';

import 'errors.dart';
import 'jni.dart';
import 'jreference.dart';
import 'lang/jstring.dart';
import 'jvalues.dart';
import 'third_party/generated_bindings.dart';
import 'types.dart';

// This typedef is needed because void is a keyword and cannot be used in
// type switch like a regular type.
typedef _VoidType = void;

final class JObjectType extends JObjType<JObject> {
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
    Jni.accessors.throwException(result.exception);
  }
  return result.value.cast<T>();
}

int _getCallType(int? callType, int defaultType, Set<int> allowed) {
  if (callType == null) return defaultType;
  if (allowed.contains(callType)) return callType;
  throw InvalidCallTypeError(callType, allowed);
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
      finalCallType = _getCallType(callType, JniCallType.longType, {
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
          ? (ref) => Jni.env.toDartString(ref, releaseOriginal: true)
          : (T == JObject ? JObject.fromRef : JString.fromRef);
      result = ctor(ref) as T;
      break;
    case const (Pointer<Void>): // JObjectPtr
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
  late final JObjType<JObject> $type = type;

  /// The type which includes information such as the signature of this class.
  static const JObjType<JObject> type = JObjectType();

  /// Construct a new [JObject] with [reference] as its underlying reference.
  JObject.fromRef(JObjectPtr reference) : super.fromRef(reference);

  JClass? _jClass;

  JClass get _class {
    return _jClass ??= getClass();
  }

  @override
  void release() {
    _jClass?.release();
    super.release();
  }

  /// Returns [JClass] corresponding to concrete class of this object.
  ///
  /// This may be a subclass of compile-time class.
  JClass getClass() {
    final classRef = Jni.env.GetObjectClass(reference);
    if (classRef == nullptr) {
      Jni.accessors.throwException(Jni.env.ExceptionOccurred());
    }
    return JClass.fromRef(classRef);
  }

  /// Get [JFieldIDPtr] of instance field identified by [fieldName] & [signature].
  JFieldIDPtr getFieldID(String fieldName, String signature) {
    return _getID(
        Jni.accessors.getFieldID, _class.reference, fieldName, signature);
  }

  /// Get [JFieldIDPtr] of static field identified by [fieldName] & [signature].
  JFieldIDPtr getStaticFieldID(String fieldName, String signature) {
    return _getID<jfieldID_>(
        Jni.accessors.getStaticFieldID, _class.reference, fieldName, signature);
  }

  /// Get [JMethodIDPtr] of instance method [methodName] with [signature].
  JMethodIDPtr getMethodID(String methodName, String signature) {
    return _getID<jmethodID_>(
        Jni.accessors.getMethodID, _class.reference, methodName, signature);
  }

  /// Get [JMethodIDPtr] of static method [methodName] with [signature].
  JMethodIDPtr getStaticMethodID(String methodName, String signature) {
    return _getID<jmethodID_>(Jni.accessors.getStaticMethodID, _class.reference,
        methodName, signature);
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
    if (callType == JniCallType.voidType) {
      throw ArgumentError("void is not a valid field type.");
    }
    return _getField<T>(
        callType, (ct) => Jni.accessors.getField(reference, fieldID, ct));
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
    return _getField<T>(callType,
        (ct) => Jni.accessors.getStaticField(_class.reference, fieldID, ct));
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
    return _callMethod<T>(callType, args,
        (ct, jvs) => Jni.accessors.callMethod(reference, methodID, ct, jvs));
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
    return _callMethod<T>(
        callType,
        args,
        (ct, jvs) =>
            Jni.accessors.callStaticMethod(reference, methodID, ct, jvs));
  }

  /// Call static method identified by [name] and [signature].
  ///
  /// This implementation looks up the method and calls [callStaticMethod].
  T callStaticMethodByName<T>(String name, String signature, List<dynamic> args,
      [int? callType]) {
    final id = getStaticMethodID(name, signature);
    return callStaticMethod<T>(id, args, callType);
  }

  /// Casts this object to another [type].
  ///
  /// If [releaseOriginal] is `true`, the casted object will be released.
  T castTo<T extends JObject>(
    JObjType<T> type, {
    bool releaseOriginal = false,
  }) {
    if (releaseOriginal) {
      _jClass?.release();
      final ret = type.fromRef(reference);
      setAsReleased();
      return ret;
    }
    final newRef = Jni.env.NewGlobalRef(reference);
    return type.fromRef(newRef);
  }

  static final _objectClass = Jni.findJClass('java/lang/Object');

  static final _hashCodeId =
      Jni.accessors.getMethodIDOf(_objectClass.reference, r"hashCode", r"()I");
  @override
  int get hashCode => Jni.accessors.callMethodWithArgs(
      reference, _hashCodeId, JniCallType.intType, []).integer;

  static final _equalsId = Jni.accessors.getMethodIDOf(
      _objectClass.reference, r"equals", r"(Ljava/lang/Object;)Z");
  @override
  bool operator ==(Object other) {
    if (other is! JObject) {
      return false;
    }
    return Jni.accessors.callMethodWithArgs(reference, _equalsId,
        JniCallType.booleanType, [other.reference]).boolean;
  }

  static final _toStringId = Jni.accessors.getMethodIDOf(
      _objectClass.reference, r"toString", r"()Ljava/lang/String;");
  @override
  String toString() {
    return JString.fromRef(Jni.accessors.callMethodWithArgs(
            reference, _toStringId, JniCallType.objectType, []).object)
        .toDartString(releaseOriginal: true);
  }
}

/// A high level wrapper over a JNI class reference.
class JClass extends JReference {
  /// Construct a new [JClass] with [reference] as its underlying reference.
  JClass.fromRef(JObjectPtr reference) : super.fromRef(reference);

  /// Get [JFieldIDPtr] of static field [fieldName] with [signature].
  JFieldIDPtr getStaticFieldID(String fieldName, String signature) {
    return _getID<jfieldID_>(
        Jni.accessors.getStaticFieldID, reference, fieldName, signature);
  }

  /// Get [JMethodIDPtr] of static method [methodName] with [signature].
  JMethodIDPtr getStaticMethodID(String methodName, String signature) {
    return _getID<jmethodID_>(
        Jni.accessors.getStaticMethodID, reference, methodName, signature);
  }

  /// Get [JFieldIDPtr] of field [fieldName] with [signature].
  JFieldIDPtr getFieldID(String fieldName, String signature) {
    return _getID<jfieldID_>(
        Jni.accessors.getFieldID, reference, fieldName, signature);
  }

  /// Get [JMethodIDPtr] of method [methodName] with [signature].
  JMethodIDPtr getMethodID(String methodName, String signature) {
    return _getID<jmethodID_>(
        Jni.accessors.getMethodID, reference, methodName, signature);
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
    return _getField<T>(
        callType, (ct) => Jni.accessors.getStaticField(reference, fieldID, ct));
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
    return _callMethod<T>(
        callType,
        args,
        (ct, jvs) =>
            Jni.accessors.callStaticMethod(reference, methodID, ct, jvs));
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
        final jArgs = JValueArgs(args, arena);
        final res =
            Jni.accessors.newObject(reference, ctor, jArgs.values).object;
        return JObject.fromRef(res);
      });
}
