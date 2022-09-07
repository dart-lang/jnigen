// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: annotate_overrides
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: unused_element

import "dart:ffi" as ffi;
import "package:jni/jni.dart" as jni;

import "../../_init.dart" show jlookup;

/// from: com.example.in_app_java.AndroidUtils
class AndroidUtils extends jni.JlObject {
  AndroidUtils.fromRef(ffi.Pointer<ffi.Void> ref) : super.fromRef(ref);

  static final _ctor =
      jlookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function()>>(
              "com_example_in_app_java_AndroidUtils_ctor")
          .asFunction<ffi.Pointer<ffi.Void> Function()>();

  /// from: public void <init>()
  AndroidUtils() : super.fromRef(_ctor()) {
    jni.Jni.indir.checkException();
  }

  static final _showToast = jlookup<
          ffi.NativeFunction<
              ffi.Void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>,
                  ffi.Int32)>>("com_example_in_app_java_AndroidUtils_showToast")
      .asFunction<
          void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>, int)>();

  /// from: static void showToast(android.app.Activity mainActivity, java.lang.CharSequence text, int duration)
  static void showToast(
      jni.JlObject mainActivity, jni.JlObject text, int duration) {
    final result__ =
        _showToast(mainActivity.reference, text.reference, duration);
    jni.Jni.indir.checkException();
    return result__;
  }
}
