// Autogenerated by jni_gen. DO NOT EDIT!

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: annotate_overrides
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: unused_element

import "dart:ffi" as ffi;

import "package:jni/jni.dart" as jni;

import "../../init.dart" show jlookup;

/// from: dev.dart.pkg2.C2
class C2 extends jni.JlObject {
  C2.fromRef(ffi.Pointer<ffi.Void> ref) : super.fromRef(ref);

  static final _getCONSTANT = jlookup<ffi.NativeFunction<ffi.Int32 Function()>>(
          "get_dev_dart_pkg2_C2_CONSTANT")
      .asFunction<int Function()>();

  /// from: static public int CONSTANT
  static int get CONSTANT => _getCONSTANT();
  static final _setCONSTANT =
      jlookup<ffi.NativeFunction<ffi.Void Function(ffi.Int32)>>(
              "set_dev_dart_pkg2_C2_CONSTANT")
          .asFunction<void Function(int)>();

  /// from: static public int CONSTANT
  static set CONSTANT(int value) => _setCONSTANT(value);

  static final _ctor =
      jlookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function()>>(
              "dev_dart_pkg2_C2_ctor")
          .asFunction<ffi.Pointer<ffi.Void> Function()>();

  /// from: public void <init>()
  C2() : super.fromRef(_ctor());
}
