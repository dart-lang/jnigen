// Generated from jackson-core which is licensed under the Apache License 2.0.
// The following copyright from the original authors applies.
// See https://github.com/FasterXML/jackson-core/blob/2.14/LICENSE
//
// Copyright (c) 2007 - The Jackson Project Authors
// Licensed under the Apache License, Version 2.0 (the "License")
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: annotate_overrides, overridden_fields
// ignore_for_file: camel_case_extensions
// ignore_for_file: camel_case_types
// ignore_for_file: constant_identifier_names
// ignore_for_file: file_names
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_cast
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_shown_name

import "package:jni/jni.dart" as jni;

import "package:jni/internal_helpers_for_jnigen.dart";

import "../../../../_init.dart" show jniEnv, jniAccessors;

/// from: com.fasterxml.jackson.core.JsonToken
///
/// Enumeration for basic token types used for returning results
/// of parsing JSON content.
class JsonToken extends jni.JObject {
  late final jni.JObjType? _$type;
  @override
  jni.JObjType get $type => _$type ??= type;

  JsonToken.fromRef(
    jni.JObjectPtr ref,
  ) : super.fromRef(ref);

  static final _classRef =
      jniAccessors.getClassOf("com/fasterxml/jackson/core/JsonToken");

  /// The type which includes information such as the signature of this class.
  static const type = $JsonTokenType();

  static final _id_values = jniAccessors.getStaticMethodIDOf(
      _classRef, "values", "()[Lcom/fasterxml/jackson/core/JsonToken;");

  /// from: static public com.fasterxml.jackson.core.JsonToken[] values()
  /// The returned object must be deleted after use, by calling the `delete` method.
  static jni.JArray<JsonToken> values() =>
      const jni.JArrayType($JsonTokenType()).fromRef(jniAccessors
          .callStaticMethodWithArgs(
              _classRef, _id_values, jni.JniCallType.objectType, []).object);

  static final _id_valueOf = jniAccessors.getStaticMethodIDOf(_classRef,
      "valueOf", "(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;");

  /// from: static public com.fasterxml.jackson.core.JsonToken valueOf(java.lang.String name)
  /// The returned object must be deleted after use, by calling the `delete` method.
  static JsonToken valueOf(jni.JString name) =>
      const $JsonTokenType().fromRef(jniAccessors.callStaticMethodWithArgs(
          _classRef,
          _id_valueOf,
          jni.JniCallType.objectType,
          [name.reference]).object);

  static final _id_id = jniAccessors.getMethodIDOf(_classRef, "id", "()I");

  /// from: public final int id()
  int id() => jniAccessors.callMethodWithArgs(
      reference, _id_id, jni.JniCallType.intType, [reference]).integer;

  static final _id_asString =
      jniAccessors.getMethodIDOf(_classRef, "asString", "()Ljava/lang/String;");

  /// from: public final java.lang.String asString()
  /// The returned object must be deleted after use, by calling the `delete` method.
  jni.JString asString() =>
      const jni.JStringType().fromRef(jniAccessors.callMethodWithArgs(reference,
          _id_asString, jni.JniCallType.objectType, [reference]).object);

  static final _id_asCharArray =
      jniAccessors.getMethodIDOf(_classRef, "asCharArray", "()[C");

  /// from: public final char[] asCharArray()
  /// The returned object must be deleted after use, by calling the `delete` method.
  jni.JArray<jni.JChar> asCharArray() => const jni.JArrayType(jni.JCharType())
      .fromRef(jniAccessors.callMethodWithArgs(reference, _id_asCharArray,
          jni.JniCallType.objectType, [reference]).object);

  static final _id_asByteArray =
      jniAccessors.getMethodIDOf(_classRef, "asByteArray", "()[B");

  /// from: public final byte[] asByteArray()
  /// The returned object must be deleted after use, by calling the `delete` method.
  jni.JArray<jni.JByte> asByteArray() => const jni.JArrayType(jni.JByteType())
      .fromRef(jniAccessors.callMethodWithArgs(reference, _id_asByteArray,
          jni.JniCallType.objectType, [reference]).object);

  static final _id_isNumeric =
      jniAccessors.getMethodIDOf(_classRef, "isNumeric", "()Z");

  /// from: public final boolean isNumeric()
  ///
  /// @return {@code True} if this token is {@code VALUE_NUMBER_INT} or {@code VALUE_NUMBER_FLOAT},
  ///   {@code false} otherwise
  bool isNumeric() => jniAccessors.callMethodWithArgs(reference, _id_isNumeric,
      jni.JniCallType.booleanType, [reference]).boolean;

  static final _id_isStructStart =
      jniAccessors.getMethodIDOf(_classRef, "isStructStart", "()Z");

  /// from: public final boolean isStructStart()
  ///
  /// Accessor that is functionally equivalent to:
  /// <code>
  ///    this == JsonToken.START_OBJECT || this == JsonToken.START_ARRAY
  /// </code>
  ///@return {@code True} if this token is {@code START_OBJECT} or {@code START_ARRAY},
  ///   {@code false} otherwise
  ///@since 2.3
  bool isStructStart() => jniAccessors.callMethodWithArgs(reference,
      _id_isStructStart, jni.JniCallType.booleanType, [reference]).boolean;

  static final _id_isStructEnd =
      jniAccessors.getMethodIDOf(_classRef, "isStructEnd", "()Z");

  /// from: public final boolean isStructEnd()
  ///
  /// Accessor that is functionally equivalent to:
  /// <code>
  ///    this == JsonToken.END_OBJECT || this == JsonToken.END_ARRAY
  /// </code>
  ///@return {@code True} if this token is {@code END_OBJECT} or {@code END_ARRAY},
  ///   {@code false} otherwise
  ///@since 2.3
  bool isStructEnd() => jniAccessors.callMethodWithArgs(reference,
      _id_isStructEnd, jni.JniCallType.booleanType, [reference]).boolean;

  static final _id_isScalarValue =
      jniAccessors.getMethodIDOf(_classRef, "isScalarValue", "()Z");

  /// from: public final boolean isScalarValue()
  ///
  /// Method that can be used to check whether this token represents
  /// a valid non-structured value. This means all {@code VALUE_xxx} tokens;
  /// excluding {@code START_xxx} and {@code END_xxx} tokens as well
  /// {@code FIELD_NAME}.
  ///@return {@code True} if this token is a scalar value token (one of
  ///   {@code VALUE_xxx} tokens), {@code false} otherwise
  bool isScalarValue() => jniAccessors.callMethodWithArgs(reference,
      _id_isScalarValue, jni.JniCallType.booleanType, [reference]).boolean;

  static final _id_isBoolean =
      jniAccessors.getMethodIDOf(_classRef, "isBoolean", "()Z");

  /// from: public final boolean isBoolean()
  ///
  /// @return {@code True} if this token is {@code VALUE_TRUE} or {@code VALUE_FALSE},
  ///   {@code false} otherwise
  bool isBoolean() => jniAccessors.callMethodWithArgs(reference, _id_isBoolean,
      jni.JniCallType.booleanType, [reference]).boolean;
}

class $JsonTokenType extends jni.JObjType<JsonToken> {
  const $JsonTokenType();

  @override
  String get signature => r"Lcom/fasterxml/jackson/core/JsonToken;";

  @override
  JsonToken fromRef(jni.JObjectPtr ref) => JsonToken.fromRef(ref);
}

extension $JsonTokenArray on jni.JArray<JsonToken> {
  JsonToken operator [](int index) {
    return (elementType as $JsonTokenType)
        .fromRef(elementAt(index, jni.JniCallType.objectType).object);
  }

  void operator []=(int index, JsonToken value) {
    (this as jni.JArray<jni.JObject>)[index] = value;
  }
}
