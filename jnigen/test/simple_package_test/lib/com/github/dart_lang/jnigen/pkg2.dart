// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: annotate_overrides
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: unused_element

import "dart:ffi" as ffi;
import "package:jni/jni.dart" as jni;

import "../../../../_init.dart" show jlookup;

/// from: com.github.dart_lang.jnigen.pkg2.C2
class C2 extends jni.JlObject {
  C2.fromRef(ffi.Pointer<ffi.Void> ref) : super.fromRef(ref);

  static final _get_CONSTANT =
      jlookup<ffi.NativeFunction<ffi.Int32 Function()>>(
              "get_com_github_dart_lang_jnigen_pkg2_C2_CONSTANT")
          .asFunction<int Function()>();

  /// from: static public int CONSTANT
  static int get CONSTANT => _get_CONSTANT();
  static final _set_CONSTANT =
      jlookup<ffi.NativeFunction<ffi.Void Function(ffi.Int32)>>(
              "set_com_github_dart_lang_jnigen_pkg2_C2_CONSTANT")
          .asFunction<void Function(int)>();

  /// from: static public int CONSTANT
  static set CONSTANT(int value) => _set_CONSTANT(value);

  static final _ctor =
      jlookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function()>>(
              "com_github_dart_lang_jnigen_pkg2_C2_ctor")
          .asFunction<ffi.Pointer<ffi.Void> Function()>();

  /// from: public void <init>()
  C2() : super.fromRef(_ctor());
}
