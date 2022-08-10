// Autogenerated by jni_gen. DO NOT EDIT!

import "dart:ffi" as ffi;

import "package:jni/jni.dart" as jni;

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: annotate_overrides
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: unused_element

import "../../init.dart" show jlookup;

class Example extends jni.JlObject {
  Example.fromRef(ffi.Pointer<ffi.Void> ref) : super.fromRef(ref);

  /// from: static public final int ON
  static const ON = 1;

  /// from: static public final int OFF
  static const OFF = 0;

  /// from: static public dev.dart.jni_gen_test.Example.Aux aux
  static final _getaux =
      jlookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function()>>(
              "get_dev_dart_jni_gen_test_Example_aux")
          .asFunction<ffi.Pointer<ffi.Void> Function()>();
  static Example_Aux get aux => Example_Aux.fromRef(_getaux());
  static final _setaux =
      jlookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>(
              "set_dev_dart_jni_gen_test_Example_aux")
          .asFunction<void Function(ffi.Pointer<ffi.Void>)>();
  static set aux(Example_Aux value) => _setaux(value.reference);

  /// from: static public int num
  static final _getnum = jlookup<ffi.NativeFunction<ffi.Int32 Function()>>(
          "get_dev_dart_jni_gen_test_Example_num")
      .asFunction<int Function()>();
  static int get num => _getnum();
  static final _setnum =
      jlookup<ffi.NativeFunction<ffi.Void Function(ffi.Int32)>>(
              "set_dev_dart_jni_gen_test_Example_num")
          .asFunction<void Function(int)>();
  static set num(int value) => _setnum(value);

  static final _ctor =
      jlookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function()>>(
              "dev_dart_jni_gen_test_Example_new")
          .asFunction<ffi.Pointer<ffi.Void> Function()>();

  /// from: public void <init>()
  Example() : super.fromRef(_ctor());

  static final _getAux =
      jlookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function()>>(
              "dev_dart_jni_gen_test_Example_getAux")
          .asFunction<ffi.Pointer<ffi.Void> Function()>();

  /// from: static public dev.dart.jni_gen_test.Example.Aux getAux()
  static Example_Aux getAux() => Example_Aux.fromRef(_getAux());

  static final _addInts =
      jlookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Int32, ffi.Int32)>>(
              "dev_dart_jni_gen_test_Example_addInts")
          .asFunction<int Function(int, int)>();

  /// from: static public int addInts(int a, int b)
  static int addInts(int a, int b) => _addInts(a, b);

  static final _getSelf = jlookup<
              ffi.NativeFunction<
                  ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>>(
          "dev_dart_jni_gen_test_Example_getSelf")
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  /// from: public dev.dart.jni_gen_test.Example getSelf()
  Example getSelf() => Example.fromRef(_getSelf(reference));

  static final _getNum =
      jlookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
              "dev_dart_jni_gen_test_Example_getNum")
          .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  /// from: public int getNum()
  int getNum() => _getNum(reference);

  static final _setNum = jlookup<
          ffi.NativeFunction<
              ffi.Void Function(ffi.Pointer<ffi.Void>,
                  ffi.Int32)>>("dev_dart_jni_gen_test_Example_setNum")
      .asFunction<void Function(ffi.Pointer<ffi.Void>, int)>();

  /// from: public void setNum(int num)
  void setNum(int num) => _setNum(reference, num);
}

class Example_Aux extends jni.JlObject {
  Example_Aux.fromRef(ffi.Pointer<ffi.Void> ref) : super.fromRef(ref);

  /// from: public boolean value
  static final _getvalue = jlookup<
          ffi.NativeFunction<
              ffi.Uint8 Function(
    ffi.Pointer<ffi.Void>,
  )>>("get_dev_dart_jni_gen_test_Example__Aux_value")
      .asFunction<
          int Function(
    ffi.Pointer<ffi.Void>,
  )>();
  bool get value => _getvalue(reference) != 0;
  static final _setvalue = jlookup<
          ffi.NativeFunction<
              ffi.Void Function(ffi.Pointer<ffi.Void>,
                  ffi.Uint8)>>("set_dev_dart_jni_gen_test_Example__Aux_value")
      .asFunction<void Function(ffi.Pointer<ffi.Void>, int)>();
  set value(bool value) => _setvalue(reference, value ? 1 : 0);

  static final _ctor =
      jlookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function(ffi.Uint8)>>(
              "dev_dart_jni_gen_test_Example__Aux_new")
          .asFunction<ffi.Pointer<ffi.Void> Function(int)>();

  /// from: public void <init>(boolean value)
  Example_Aux(bool value) : super.fromRef(_ctor(value ? 1 : 0));

  static final _getValue =
      jlookup<ffi.NativeFunction<ffi.Uint8 Function(ffi.Pointer<ffi.Void>)>>(
              "dev_dart_jni_gen_test_Example__Aux_getValue")
          .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  /// from: public boolean getValue()
  bool getValue() => _getValue(reference) != 0;

  static final _setValue = jlookup<
          ffi.NativeFunction<
              ffi.Void Function(ffi.Pointer<ffi.Void>,
                  ffi.Uint8)>>("dev_dart_jni_gen_test_Example__Aux_setValue")
      .asFunction<void Function(ffi.Pointer<ffi.Void>, int)>();

  /// from: public void setValue(boolean value)
  void setValue(bool value) => _setValue(reference, value ? 1 : 0);
}
