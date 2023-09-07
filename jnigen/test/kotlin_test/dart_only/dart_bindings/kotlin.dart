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
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: lines_longer_than_80_chars

import "dart:isolate" show ReceivePort;
import "dart:ffi" as ffi;
import "package:jni/internal_helpers_for_jnigen.dart";
import "package:jni/jni.dart" as jni;

/// from: com.github.dart_lang.jnigen.SuspendFun
class SuspendFun extends jni.JObject {
  @override
  late final jni.JObjType<SuspendFun> $type = type;

  SuspendFun.fromRef(
    jni.JObjectPtr ref,
  ) : super.fromRef(ref);

  static final _class =
      jni.Jni.findJClass(r"com/github/dart_lang/jnigen/SuspendFun");

  /// The type which includes information such as the signature of this class.
  static const type = $SuspendFunType();
  static final _id_new0 =
      jni.Jni.accessors.getMethodIDOf(_class.reference, r"<init>", r"()V");

  /// from: public void <init>()
  /// The returned object must be released after use, by calling the [release] method.
  factory SuspendFun() {
    return SuspendFun.fromRef(jni.Jni.accessors
        .newObjectWithArgs(_class.reference, _id_new0, []).object);
  }

  static final _id_sayHello = jni.Jni.accessors.getMethodIDOf(_class.reference,
      r"sayHello", r"(Lkotlin/coroutines/Continuation;)Ljava/lang/Object;");

  /// from: public final java.lang.Object sayHello(kotlin.coroutines.Continuation continuation)
  /// The returned object must be released after use, by calling the [release] method.
  Future<jni.JString> sayHello() async {
    final $p = ReceivePort();
    final $c =
        jni.JObject.fromRef(ProtectedJniExtensions.newPortContinuation($p));
    jni.Jni.accessors.callMethodWithArgs(reference, _id_sayHello,
        jni.JniCallType.objectType, [$c.reference]).object;
    final $o = jni.JObjectPtr.fromAddress(await $p.first);
    final $k = const jni.JStringType().getClass().reference;
    if (!jni.Jni.env.IsInstanceOf($o, $k)) {
      throw "Failed";
    }
    return const jni.JStringType().fromRef($o);
  }

  static final _id_sayHello1 = jni.Jni.accessors.getMethodIDOf(
      _class.reference,
      r"sayHello",
      r"(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;");

  /// from: public final java.lang.Object sayHello(java.lang.String string, kotlin.coroutines.Continuation continuation)
  /// The returned object must be released after use, by calling the [release] method.
  Future<jni.JString> sayHello1(
    jni.JString string,
  ) async {
    final $p = ReceivePort();
    final $c =
        jni.JObject.fromRef(ProtectedJniExtensions.newPortContinuation($p));
    jni.Jni.accessors.callMethodWithArgs(reference, _id_sayHello1,
        jni.JniCallType.objectType, [string.reference, $c.reference]).object;
    final $o = jni.JObjectPtr.fromAddress(await $p.first);
    final $k = const jni.JStringType().getClass().reference;
    if (!jni.Jni.env.IsInstanceOf($o, $k)) {
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

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($SuspendFunType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($SuspendFunType) && other is $SuspendFunType;
  }
}
