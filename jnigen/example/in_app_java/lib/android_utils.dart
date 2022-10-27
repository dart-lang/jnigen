// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: camel_case_types
// ignore_for_file: file_names
// ignore_for_file: unused_import
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: annotate_overrides
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: unused_element

import "dart:ffi" as ffi;
import "package:jni/internal_helpers_for_jnigen.dart";
import "package:jni/jni.dart" as jni;

// Auto-generated initialization code.

final ffi.Pointer<T> Function<T extends ffi.NativeType>(String sym) jniLookup =
    ProtectedJniExtensions.initGeneratedLibrary("android_utils");

/// from: com.example.in_app_java.AndroidUtils
class AndroidUtils extends jni.JniObject {
  AndroidUtils.fromRef(ffi.Pointer<ffi.Void> ref) : super.fromRef(ref);

  static final _ctor = jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
          "AndroidUtils__ctor")
      .asFunction<jni.JniResult Function()>();

  /// from: public void <init>()
  AndroidUtils() : super.fromRef(_ctor().object);

  static final _showToast = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>, ffi.Int32)>>("AndroidUtils__showToast")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>, int)>();

  /// from: static void showToast(android.app.Activity mainActivity, java.lang.CharSequence text, int duration)
  static void showToast(
          jni.JniObject mainActivity, jni.JniObject text, int duration) =>
      _showToast(mainActivity.reference, text.reference, duration).check();
}
