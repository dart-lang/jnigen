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
    ProtectedJniExtensions.initGeneratedLibrary("android_utils");

/// from: com.example.in_app_java.AndroidUtils
class AndroidUtils extends jni.JObject {
  AndroidUtils.fromRef(ffi.Pointer<ffi.Void> ref) : super.fromRef(ref);

  /// The type which includes information such as the signature of this class.
  static const jni.JObjType<AndroidUtils> type = _$AndroidUtilsType();

  static final _showToast = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>, ffi.Int32)>>("AndroidUtils__showToast")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>, int)>();

  /// from: static public void showToast(android.app.Activity mainActivity, java.lang.CharSequence text, int duration)
  static void showToast(
          jni.JObject mainActivity, jni.JObject text, int duration) =>
      _showToast(mainActivity.reference, text.reference, duration).check();
}

class _$AndroidUtilsType extends jni.JObjType<AndroidUtils> {
  const _$AndroidUtilsType();

  @override
  String get signature => r"Lcom/example/in_app_java/AndroidUtils;";

  @override
  AndroidUtils fromRef(jni.JObjectPtr ref) => AndroidUtils.fromRef(ref);
}

extension $AndroidUtilsArray on jni.JArray<AndroidUtils> {
  AndroidUtils operator [](int index) {
    return AndroidUtils.fromRef(
        elementAt(index, jni.JniCallType.objectType).object);
  }

  void operator []=(int index, AndroidUtils value) {
    (this as jni.JArray<jni.JObject>)[index] = value;
  }
}

/// from: android.os.Build
class Build extends jni.JObject {
  Build.fromRef(ffi.Pointer<ffi.Void> ref) : super.fromRef(ref);

  /// The type which includes information such as the signature of this class.
  static const jni.JObjType<Build> type = _$BuildType();

  static final _get_BOARD =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__BOARD")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String BOARD
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get BOARD => jni.JString.fromRef(_get_BOARD().object);

  static final _get_BOOTLOADER =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__BOOTLOADER")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String BOOTLOADER
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get BOOTLOADER =>
      jni.JString.fromRef(_get_BOOTLOADER().object);

  static final _get_BRAND =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__BRAND")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String BRAND
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get BRAND => jni.JString.fromRef(_get_BRAND().object);

  static final _get_CPU_ABI =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__CPU_ABI")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String CPU_ABI
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get CPU_ABI => jni.JString.fromRef(_get_CPU_ABI().object);

  static final _get_CPU_ABI2 =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__CPU_ABI2")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String CPU_ABI2
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get CPU_ABI2 =>
      jni.JString.fromRef(_get_CPU_ABI2().object);

  static final _get_DEVICE =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__DEVICE")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String DEVICE
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get DEVICE => jni.JString.fromRef(_get_DEVICE().object);

  static final _get_DISPLAY =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__DISPLAY")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String DISPLAY
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get DISPLAY => jni.JString.fromRef(_get_DISPLAY().object);

  static final _get_FINGERPRINT =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__FINGERPRINT")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String FINGERPRINT
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get FINGERPRINT =>
      jni.JString.fromRef(_get_FINGERPRINT().object);

  static final _get_HARDWARE =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__HARDWARE")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String HARDWARE
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get HARDWARE =>
      jni.JString.fromRef(_get_HARDWARE().object);

  static final _get_HOST =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>("get_Build__HOST")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String HOST
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get HOST => jni.JString.fromRef(_get_HOST().object);

  static final _get_ID =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>("get_Build__ID")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String ID
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get ID => jni.JString.fromRef(_get_ID().object);

  static final _get_MANUFACTURER =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__MANUFACTURER")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String MANUFACTURER
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get MANUFACTURER =>
      jni.JString.fromRef(_get_MANUFACTURER().object);

  static final _get_MODEL =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__MODEL")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String MODEL
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get MODEL => jni.JString.fromRef(_get_MODEL().object);

  static final _get_ODM_SKU =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__ODM_SKU")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String ODM_SKU
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get ODM_SKU => jni.JString.fromRef(_get_ODM_SKU().object);

  static final _get_PRODUCT =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__PRODUCT")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String PRODUCT
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get PRODUCT => jni.JString.fromRef(_get_PRODUCT().object);

  static final _get_RADIO =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__RADIO")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String RADIO
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get RADIO => jni.JString.fromRef(_get_RADIO().object);

  static final _get_SERIAL =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__SERIAL")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String SERIAL
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get SERIAL => jni.JString.fromRef(_get_SERIAL().object);

  static final _get_SKU =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>("get_Build__SKU")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String SKU
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get SKU => jni.JString.fromRef(_get_SKU().object);

  static final _get_SOC_MANUFACTURER =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__SOC_MANUFACTURER")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String SOC_MANUFACTURER
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get SOC_MANUFACTURER =>
      jni.JString.fromRef(_get_SOC_MANUFACTURER().object);

  static final _get_SOC_MODEL =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__SOC_MODEL")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String SOC_MODEL
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get SOC_MODEL =>
      jni.JString.fromRef(_get_SOC_MODEL().object);

  static final _get_SUPPORTED_32_BIT_ABIS =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__SUPPORTED_32_BIT_ABIS")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String[] SUPPORTED_32_BIT_ABIS
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JArray<jni.JString> get SUPPORTED_32_BIT_ABIS =>
      jni.JArray<jni.JString>.fromRef(_get_SUPPORTED_32_BIT_ABIS().object);

  static final _get_SUPPORTED_64_BIT_ABIS =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__SUPPORTED_64_BIT_ABIS")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String[] SUPPORTED_64_BIT_ABIS
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JArray<jni.JString> get SUPPORTED_64_BIT_ABIS =>
      jni.JArray<jni.JString>.fromRef(_get_SUPPORTED_64_BIT_ABIS().object);

  static final _get_SUPPORTED_ABIS =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "get_Build__SUPPORTED_ABIS")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String[] SUPPORTED_ABIS
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JArray<jni.JString> get SUPPORTED_ABIS =>
      jni.JArray<jni.JString>.fromRef(_get_SUPPORTED_ABIS().object);

  static final _get_TAGS =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>("get_Build__TAGS")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String TAGS
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get TAGS => jni.JString.fromRef(_get_TAGS().object);

  static final _get_TIME =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>("get_Build__TIME")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final long TIME
  static int get TIME => _get_TIME().long;

  static final _get_TYPE =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>("get_Build__TYPE")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String TYPE
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get TYPE => jni.JString.fromRef(_get_TYPE().object);

  /// from: static public final java.lang.String UNKNOWN
  static const UNKNOWN = "unknown";

  static final _get_USER =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>("get_Build__USER")
          .asFunction<jni.JniResult Function()>();

  /// from: static public final java.lang.String USER
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString get USER => jni.JString.fromRef(_get_USER().object);

  static final _ctor =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>("Build__ctor")
          .asFunction<jni.JniResult Function()>();

  /// from: public void <init>()
  Build() : super.fromRef(_ctor().object);

  static final _getSerial =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "Build__getSerial")
          .asFunction<jni.JniResult Function()>();

  /// from: static public java.lang.String getSerial()
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString getSerial() => jni.JString.fromRef(_getSerial().object);

  static final _getFingerprintedPartitions =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "Build__getFingerprintedPartitions")
          .asFunction<jni.JniResult Function()>();

  /// from: static public java.util.List getFingerprintedPartitions()
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JObject getFingerprintedPartitions() =>
      jni.JObject.fromRef(_getFingerprintedPartitions().object);

  static final _getRadioVersion =
      jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
              "Build__getRadioVersion")
          .asFunction<jni.JniResult Function()>();

  /// from: static public java.lang.String getRadioVersion()
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JString getRadioVersion() =>
      jni.JString.fromRef(_getRadioVersion().object);
}

class _$BuildType extends jni.JObjType<Build> {
  const _$BuildType();

  @override
  String get signature => r"Landroid/os/Build;";

  @override
  Build fromRef(jni.JObjectPtr ref) => Build.fromRef(ref);
}

extension $BuildArray on jni.JArray<Build> {
  Build operator [](int index) {
    return Build.fromRef(elementAt(index, jni.JniCallType.objectType).object);
  }

  void operator []=(int index, Build value) {
    (this as jni.JArray<jni.JObject>)[index] = value;
  }
}
