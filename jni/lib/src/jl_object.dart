// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'third_party/jni_bindings_generated.dart';
import 'jni_exceptions.dart';
import 'jni.dart';
import 'indir_extensions.dart';
import 'jvalues.dart';

// This typedef is needed because void is a keyword and cannot be used in
// type switch like a regular type.
typedef _VoidType = void;

/// A class which holds one or more JNI references, and has a `delete` operation
/// which disposes the reference(s).
abstract class JniReference {
  void _assertNotDeleted();
  bool get isDeleted;
  void delete();

  /// Registers this object to be deleted at the end of [arena]'s lifetime.
  void deletedIn(Arena arena) => arena.onReleaseAll(delete);
}

extension JniReferenceUseExtension<T extends JniReference> on T {
  /// Applies [callback] on [this] object and then delete the underlying JNI
  /// reference, returning the result of [callback].
  R use<R>(R Function(T) callback) {
    _assertNotDeleted();
    try {
      final result = callback(this);
      delete();
      return result;
    } catch (e) {
      delete();
      rethrow;
    }
  }
}

class _CallGetMethods {
  _CallGetMethods(this.getField, this.getStaticField, this.callMethod,
      this.callStaticMethod);
  Function(JObject, JFieldID) getField;
  Function(JClass, JFieldID) getStaticField;
  Function(JObject, JMethodID, Pointer<JValue>) callMethod;
  Function(JClass, JMethodID, Pointer<JValue>) callStaticMethod;
}

final Pointer<JniEnvIndir> _indir = Jni.indir;

final Map<int, _CallGetMethods> _accessors = {
  JniType.boolType: _CallGetMethods(
    _indir.GetBooleanField,
    _indir.GetStaticBooleanField,
    _indir.CallBooleanMethodA,
    _indir.CallStaticBooleanMethodA,
  ),
  JniType.byteType: _CallGetMethods(
    _indir.GetByteField,
    _indir.GetStaticByteField,
    _indir.CallByteMethodA,
    _indir.CallStaticByteMethodA,
  ),
  JniType.shortType: _CallGetMethods(
    _indir.GetShortField,
    _indir.GetStaticShortField,
    _indir.CallShortMethodA,
    _indir.CallStaticShortMethodA,
  ),
  JniType.charType: _CallGetMethods(
    _indir.GetCharField,
    _indir.GetStaticCharField,
    _indir.CallCharMethodA,
    _indir.CallStaticCharMethodA,
  ),
  JniType.intType: _CallGetMethods(
    _indir.GetIntField,
    _indir.GetStaticIntField,
    _indir.CallIntMethodA,
    _indir.CallStaticIntMethodA,
  ),
  JniType.longType: _CallGetMethods(
    _indir.GetLongField,
    _indir.GetStaticLongField,
    _indir.CallLongMethodA,
    _indir.CallStaticLongMethodA,
  ),
  JniType.floatType: _CallGetMethods(
    _indir.GetFloatField,
    _indir.GetStaticFloatField,
    _indir.CallFloatMethodA,
    _indir.CallStaticFloatMethodA,
  ),
  JniType.doubleType: _CallGetMethods(
    _indir.GetDoubleField,
    _indir.GetStaticDoubleField,
    _indir.CallDoubleMethodA,
    _indir.CallStaticDoubleMethodA,
  ),
  JniType.objectType: _CallGetMethods(
    _indir.GetObjectField,
    _indir.GetStaticObjectField,
    _indir.CallObjectMethodA,
    _indir.CallStaticObjectMethodA,
  ),
  JniType.voidType: _CallGetMethods(
    (x, y) => throw ArgumentError('void passed as field type'),
    (x, y) => throw ArgumentError('void passed as static field type'),
    _indir.CallVoidMethodA,
    _indir.CallStaticVoidMethodA,
  ),
};

T _getID<T>(
    T Function(Pointer<Void> ptr, Pointer<Char> name, Pointer<Char> sig) f,
    Pointer<Void> ptr,
    String name,
    String sig) {
  final result = using(
      (arena) => f(ptr, name.toNativeChars(arena), sig.toNativeChars(arena)));
  _indir.checkException();
  return result;
}

int _getCallType(int? callType, int defaultType, Set<int> allowed) {
  if (callType == null) return defaultType;
  if (allowed.contains(callType)) return callType;
  throw InvalidCallTypeException(callType, allowed);
}

T _callOrGet<T>(int? callType, Function(int) f) {
  final int finalCallType;
  T result;
  switch (T) {
    case bool:
      finalCallType =
          _getCallType(callType, JniType.boolType, {JniType.boolType});
      result = (f(finalCallType) as int != 0) as T;
      break;
    case int:
      finalCallType = _getCallType(callType, JniType.intType, {
        JniType.byteType,
        JniType.charType,
        JniType.shortType,
        JniType.intType,
        JniType.longType,
      });
      result = f(finalCallType) as T;
      break;
    case double:
      finalCallType = _getCallType(callType, JniType.doubleType,
          {JniType.floatType, JniType.doubleType});
      result = f(finalCallType) as T;
      break;
    case String:
    case JlObject:
    case JlString:
      finalCallType =
          _getCallType(callType, JniType.objectType, {JniType.objectType});
      final ref = f(finalCallType) as JObject;
      if (ref == nullptr) {
        _indir.checkException();
      }
      final ctor = T == String
          ? (ref) => _indir.asDartString(ref, deleteOriginal: true)
          : (T == JlObject ? JlObject.fromRef : JlString.fromRef);
      result = ctor(ref) as T;
      break;
    case _VoidType:
      finalCallType =
          _getCallType(callType, JniType.voidType, {JniType.voidType});
      f(finalCallType);
      result = null as T;
      break;
    case dynamic:
      result = f(callType ?? JniType.voidType) as T;
      break;
    default:
      throw UnsupportedError('Unknown type $T');
  }
  return result;
}

T _callMethod<T>(
    int? callType, List<dynamic> args, Function(int, Pointer<JValue>) f) {
  final jArgs = JValueArgs(args);
  final result = _callOrGet<T>(callType, (ct) => f(ct, jArgs.values));
  calloc.free(jArgs.values);
  jArgs.dispose();
  if (result == 0 || result == 0.0 || result == null) {
    _indir.checkException();
  }
  return result;
}

T _getField<T>(int? callType, Function(int) f) {
  final result = _callOrGet<T>(callType, f);
  _indir.checkException();
  return result;
}

/// A high-level wrapper for JNI global object reference.
///
/// This is the base class for classes generated by `jnigen`.
class JlObject extends JniReference implements Finalizable {
  /// Finalizer for this class
  static final _finalizer = NativeFinalizer(_indir.ref.DeleteGlobalRef);

  /// Construct a new [JlObject] with [reference] as its underlying reference.
  JlObject.fromRef(this.reference) {
    _finalizer.attach(this, reference, detach: this);
  }

  /// Pass the underlying reference into [function] and return the result.
  ///
  /// Result of [function] takes ownership of [reference], and this object is
  /// marked as deleted. [function] can be constructor of a subclass of JlClass,
  /// in which case this function will be useful to cast an expression.
  T into<T extends JlObject>(T Function(JObject) function) {
    _assertNotDeleted();
    _finalizer.detach(this);
    _deleted = true;
    return function(reference);
  }

  /// Returns whether this object is deleted.
  @override
  bool get isDeleted => _deleted;

  /// Check whether the underlying JNI reference is `null`.
  bool get isNull => reference == nullptr;

  /// The underlying JNI global reference of this object.
  final JObject reference;

  static final _indir = Jni.indir;

  bool _deleted = false;

  /// Reference to class of the reference obtained using `GetObjectClass`. It's
  /// populated only if any methods called on this object require it.
  ///
  /// This is nullable field instead of a late field, because we need to check
  /// if it's populated and delete if so.
  JObject? _classRef;

  JObject get _class {
    _classRef ??= _indir.GetObjectClass(reference);
    _finalizer.attach(this, _classRef!, detach: this);
    return _classRef!;
  }

  @override
  void _assertNotDeleted() {
    if (_deleted) {
      throw UseAfterFreeException(this, reference);
    }
  }

  /// Deletes the JNI reference and marks this object as deleted. Any further
  /// uses will throw [UseAfterFreeException].
  @override
  void delete() {
    if (_deleted) {
      throw DoubleFreeException(this, reference);
    }
    _deleted = true;
    _finalizer.detach(this);
    _indir.DeleteGlobalRef(reference);
    if (_classRef != null) {
      _indir.DeleteGlobalRef(_classRef!);
    }
  }

  /// Returns [JlClass] corresponding to concrete class of this object.
  ///
  /// This may be a subclass of compile-time class.
  JlClass getClass() {
    _assertNotDeleted();
    return JlClass.fromRef(_indir.GetObjectClass(reference));
  }

  /// Get [JFieldID] of instance field identified by [fieldName] & [signature].
  JFieldID getFieldID(String fieldName, String signature) {
    _assertNotDeleted();
    return _getID(_indir.GetFieldID, _class, fieldName, signature);
  }

  /// Get [JFieldID] of static field identified by [fieldName] & [signature].
  JFieldID getStaticFieldID(String fieldName, String signature) {
    _assertNotDeleted();
    return _getID(_indir.GetStaticFieldID, _class, fieldName, signature);
  }

  /// Get [JMethodID] of instance method [methodName] with [signature].
  JMethodID getMethodID(String methodName, String signature) {
    _assertNotDeleted();
    return _getID(_indir.GetMethodID, _class, methodName, signature);
  }

  /// Get [JMethodID] of static method [methodName] with [signature].
  JMethodID getStaticMethodID(String methodName, String signature) {
    _assertNotDeleted();
    return _getID(_indir.GetStaticMethodID, _class, methodName, signature);
  }

  /// Retrieve the value of the field using [fieldID].
  ///
  /// [callType] determines the return type of the underlying JNI call made.
  /// If the Java field is of `long` type, this must be [JniType.longType] and
  /// so on. Default is chosen based on return type [T], which maps int -> int,
  /// double -> double, void -> void, and JlObject types to `Object`.
  ///
  /// If [T] is String or [JlObject], required conversions are performed and
  /// final value is returned.
  T getField<T>(JFieldID fieldID, [int? callType]) {
    _assertNotDeleted();
    return _getField<T>(
        callType, (ct) => _accessors[ct]!.getField(reference, fieldID));
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
  T getStaticField<T>(JFieldID fieldID, [int? callType]) {
    _assertNotDeleted();
    return _getField<T>(
        callType, (ct) => _accessors[ct]!.getStaticField(_class, fieldID));
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
  /// [JValueLong], strings, and subclasses of [JlObject].
  ///
  /// See [getField] for an explanation about [callType] and return type [T].
  T callMethod<T>(JMethodID methodID, List<dynamic> args, [int? callType]) {
    _assertNotDeleted();
    return _callMethod<T>(callType, args,
        (ct, jvs) => _accessors[ct]!.callMethod(reference, methodID, jvs));
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
  T callStaticMethod<T>(JMethodID methodID, List<dynamic> args,
      [int? callType]) {
    _assertNotDeleted();
    return _callMethod<T>(
        callType,
        args,
        (ct, jvs) =>
            _accessors[ct]!.callStaticMethod(reference, methodID, jvs));
  }

  /// Call static method identified by [name] and [signature].
  ///
  /// This implementation looks up the method and calls [callStaticMethod].
  T callStaticMethodByName<T>(String name, String signature, List<dynamic> args,
      [int? callType]) {
    final id = getStaticMethodID(name, signature);
    return callStaticMethod<T>(id, args, callType);
  }
}

/// A high level wrapper over a JNI class reference.
class JlClass extends JniReference implements Finalizable {
  /// Construct a new [JlClass] with [reference] as its underlying reference.
  JlClass.fromRef(this.reference) {
    _finalizer.attach(this, reference, detach: this);
  }

  /// The underlying JNI class reference.
  final JClass reference;
  bool _deleted = false;

  static final _finalizer = NativeFinalizer(_indir.ref.DeleteGlobalRef);

  @override
  void _assertNotDeleted() {
    if (_deleted) {
      throw UseAfterFreeException(this, reference);
    }
  }

  /// Returns whether the underlying reference is deleted.
  @override
  bool get isDeleted => _deleted;

  /// Deletes this class reference and marks this object as deleted. Any
  /// further uses will throw [UseAfterFreeException].
  @override
  void delete() {
    if (_deleted) {
      throw DoubleFreeException(this, reference);
    }
    _deleted = true;
    _finalizer.detach(this);
    _indir.DeleteGlobalRef(reference);
  }

  /// Get [JFieldID] of static field [fieldName] with [signature].
  JFieldID getStaticFieldID(String fieldName, String signature) {
    _assertNotDeleted();
    return _getID(_indir.GetStaticFieldID, reference, fieldName, signature);
  }

  /// Get [JMethodID] of static method [methodName] with [signature].
  JMethodID getStaticMethodID(String methodName, String signature) {
    _assertNotDeleted();
    return _getID(_indir.GetStaticMethodID, reference, methodName, signature);
  }

  /// Get [JFieldID] of field [fieldName] with [signature].
  JFieldID getFieldID(String fieldName, String signature) {
    _assertNotDeleted();
    return _getID(_indir.GetFieldID, reference, fieldName, signature);
  }

  /// Get [JMethodID] of method [methodName] with [signature].
  JMethodID getMethodID(String methodName, String signature) {
    _assertNotDeleted();
    return _getID(_indir.GetMethodID, reference, methodName, signature);
  }

  /// Get [JMethodID] of constructor with [signature].
  JMethodID getCtorID(String signature) => getMethodID("<init>", signature);

  /// Get the value of static field using [fieldID].
  ///
  /// See [JlObject.getField] for more explanation about [callType].
  T getStaticField<T>(JFieldID fieldID, [int? callType]) {
    _assertNotDeleted();
    return _getField<T>(
        callType, (ct) => _accessors[ct]!.getStaticField(reference, fieldID));
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
  /// See [JlObject.callMethod] and [JlObject.getField] for more explanation
  /// about [args] and [callType].
  T callStaticMethod<T>(JMethodID methodID, List<dynamic> args,
      [int? callType]) {
    _assertNotDeleted();
    return _callMethod<T>(
        callType,
        args,
        (ct, jvs) =>
            _accessors[ct]!.callStaticMethod(reference, methodID, jvs));
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
  JlObject newObject(JMethodID ctor, List<dynamic> args) {
    _assertNotDeleted();
    final jArgs = JValueArgs(args);
    final res = _indir.NewObjectA(reference, ctor, jArgs.values);
    calloc.free(jArgs.values);
    jArgs.dispose();
    if (res == nullptr) {
      _indir.checkException();
    }
    return JlObject.fromRef(res);
  }
}

class JlString extends JlObject {
  /// Construct a new [JlString] with [reference] as its underlying reference.
  JlString.fromRef(JString reference) : super.fromRef(reference);

  static JString _toJavaString(String s) {
    final chars = s.toNativeUtf8().cast<Char>();
    final jstr = _indir.NewStringUTF(chars);
    malloc.free(chars);
    return jstr;
  }

  /// Construct a [JlString] from the contents of Dart string [s].
  JlString.fromString(String s) : super.fromRef(_toJavaString(s));

  /// Returns the contents as a Dart String.
  ///
  /// If [deleteOriginal] is true, the underlying reference is deleted
  /// after conversion and this object will be marked as deleted.
  String toDartString({bool deleteOriginal = false}) {
    _assertNotDeleted();
    if (reference == nullptr) {
      throw NullJlStringException();
    }
    final chars = _indir.GetStringUTFChars(reference, nullptr);
    final result = chars.cast<Utf8>().toDartString();
    _indir.ReleaseStringUTFChars(reference, chars);
    if (deleteOriginal) {
      delete();
    }
    return result;
  }
}

extension ToJlStringMethod on String {
  /// Returns a [JlString] with the contents of this String.
  JlString jlString() {
    return JlString.fromString(this);
  }
}
