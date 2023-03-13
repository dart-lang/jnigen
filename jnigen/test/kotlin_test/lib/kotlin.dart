// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Autogenerated by jnigen. DO NOT EDIT!

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
// ignore_for_file: unused_import

import "dart:isolate" show ReceivePort;
import "dart:ffi" as ffi;
import "package:jni/internal_helpers_for_jnigen.dart";
import "package:jni/jni.dart" as jni;

// Auto-generated initialization code.

final ffi.Pointer<T> Function<T extends ffi.NativeType>(String sym) jniLookup =
    ProtectedJniExtensions.initGeneratedLibrary("kotlin");

/// from: com.github.dart_lang.jnigen.SuspendFun
class SuspendFun extends jni.JObject {
  late final jni.JObjType? _$type;
  @override
  jni.JObjType get $type => _$type ??= type;

  SuspendFun.fromRef(
    jni.JObjectPtr ref,
  ) : super.fromRef(ref);

  /// The type which includes information such as the signature of this class.
  static const type = $SuspendFunType();
  static final _ctor = jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
          "SuspendFun__ctor")
      .asFunction<jni.JniResult Function()>();

  /// from: public void <init>()
  /// The returned object must be deleted after use, by calling the `delete` method.
  SuspendFun() : super.fromRef(_ctor().object);

  static final _sayHello = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>)>>("SuspendFun__sayHello")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public final java.lang.Object sayHello(kotlin.coroutines.Continuation continuation)
  /// The returned object must be deleted after use, by calling the `delete` method.
  Future<jni.JString> sayHello() async {
    final $p = ReceivePort();
    final $c = jni.Jni.newPortContinuation($p);
    _sayHello(reference, $c).object;
    final $o = jni.JObjectPtr.fromAddress(await $p.first);
    final $k = const jni.JStringType().getClass().reference;
    if (jni.Jni.env.IsInstanceOf($o, $k) == 0) {
      throw "Failed";
    }
    return const jni.JStringType().fromRef($o);
  }

  static final _sayHello1 = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>)>>("SuspendFun__sayHello1")
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: public final java.lang.Object sayHello(java.lang.String string, kotlin.coroutines.Continuation continuation)
  /// The returned object must be deleted after use, by calling the `delete` method.
  Future<jni.JString> sayHello1(jni.JString string) async {
    final $p = ReceivePort();
    final $c = jni.Jni.newPortContinuation($p);
    _sayHello1(reference, string.reference, $c).object;
    final $o = jni.JObjectPtr.fromAddress(await $p.first);
    final $k = const jni.JStringType().getClass().reference;
    if (jni.Jni.env.IsInstanceOf($o, $k) == 0) {
      throw "Failed";
    }
    return const jni.JStringType().fromRef($o);
  }
}

class $SuspendFunType extends jni.JObjType<SuspendFun> {
  const $SuspendFunType();

  @override
  String get signature => r"Lcom/github/dart_lang/jnigen/SuspendFun;";

  @override
  SuspendFun fromRef(jni.JObjectPtr ref) => SuspendFun.fromRef(ref);
}

extension $SuspendFunArray on jni.JArray<SuspendFun> {
  SuspendFun operator [](int index) {
    return (elementType as $SuspendFunType)
        .fromRef(elementAt(index, jni.JniCallType.objectType).object);
  }

  void operator []=(int index, SuspendFun value) {
    (this as jni.JArray<jni.JObject>)[index] = value;
  }
}
