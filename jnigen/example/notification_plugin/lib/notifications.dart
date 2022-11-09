// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
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
// ignore_for_file: unnecessary_cast
// ignore_for_file: unused_element
// ignore_for_file: unused_import

import "dart:ffi" as ffi;
import "package:jni/internal_helpers_for_jnigen.dart";
import "package:jni/jni.dart" as jni;

// Auto-generated initialization code.

final ffi.Pointer<T> Function<T extends ffi.NativeType>(String sym) jniLookup =
    ProtectedJniExtensions.initGeneratedLibrary("notification_plugin");

/// from: com.example.notification_plugin.Notifications
class Notifications extends jni.JObject {
  Notifications.fromRef(ffi.Pointer<ffi.Void> ref) : super.fromRef(ref);

  /// The type which includes information such as the signature of this class.
  static const jni.JType<Notifications> type = _$NotificationsType();
  static final _ctor = jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
          "Notifications__ctor")
      .asFunction<jni.JniResult Function()>();

  /// from: public void <init>()
  Notifications() : super.fromRef(_ctor().object);

  static final _showNotification = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  ffi.Int32,
                  ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>)>>("Notifications__showNotification")
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, int,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: static public void showNotification(android.content.Context context, int notificationID, java.lang.String title, java.lang.String text)
  static void showNotification(jni.JObject context, int notificationID,
          jni.JniString title, jni.JniString text) =>
      _showNotification(context.reference, notificationID, title.reference,
              text.reference)
          .check();
}

class _$NotificationsType extends jni.JType<Notifications> {
  const _$NotificationsType();

  @override
  String get signature => r"Lcom/example/notification_plugin/Notifications;";
}

extension $NotificationsJniArray on jni.JArray<Notifications> {
  Notifications operator [](int index) {
    return Notifications.fromRef(
        elementAt(index, jni.JniCallType.objectType).object);
  }

  void operator []=(int index, Notifications value) {
    (this as jni.JArray<jni.JObject>)[index] = value;
  }
}
