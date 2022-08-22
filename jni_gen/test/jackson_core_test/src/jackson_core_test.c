#include <stdint.h>
#include "jni.h"
#include "dartjni.h"

thread_local JNIEnv *jniEnv;
struct jni_context jni;

struct jni_context (*context_getter)(void);
JNIEnv *(*env_getter)(void);

void setJniGetters(struct jni_context (*cg)(void),
        JNIEnv *(*eg)(void)) {
    context_getter = cg;
    env_getter = eg;
}

// com.fasterxml.jackson.core.JsonFactory
jclass _c_com_fasterxml_jackson_core_JsonFactory = NULL;

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_ctor = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_ctor() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_ctor, "<init>", "()V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory, _m_com_fasterxml_jackson_core_JsonFactory_ctor);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_ctor1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_ctor1(jobject oc) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_ctor1, "<init>", "(Lcom/fasterxml/jackson/core/ObjectCodec;)V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory, _m_com_fasterxml_jackson_core_JsonFactory_ctor1, oc);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_ctor2 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_ctor2(jobject src, jobject codec) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_ctor2, "<init>", "(Lcom/fasterxml/jackson/core/JsonFactory;Lcom/fasterxml/jackson/core/ObjectCodec;)V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory, _m_com_fasterxml_jackson_core_JsonFactory_ctor2, src, codec);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_ctor3 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_ctor3(jobject b) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_ctor3, "<init>", "(Lcom/fasterxml/jackson/core/JsonFactoryBuilder;)V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory, _m_com_fasterxml_jackson_core_JsonFactory_ctor3, b);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_ctor4 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_ctor4(jobject b, uint8_t bogus) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_ctor4, "<init>", "(Lcom/fasterxml/jackson/core/TSFBuilder;Z)V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory, _m_com_fasterxml_jackson_core_JsonFactory_ctor4, b, bogus);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_rebuild = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_rebuild(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_rebuild, "rebuild", "()Lcom/fasterxml/jackson/core/TSFBuilder;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_rebuild);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_builder = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_builder() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_static_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_builder, "builder", "()Lcom/fasterxml/jackson/core/TSFBuilder;");
    jobject _result = (*jniEnv)->CallStaticObjectMethod(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory, _m_com_fasterxml_jackson_core_JsonFactory_builder);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_copy = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_copy(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_copy, "copy", "()Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_copy);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_readResolve = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_readResolve(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_readResolve, "readResolve", "()Ljava/lang/Object;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_readResolve);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_requiresPropertyOrdering = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory_requiresPropertyOrdering(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_requiresPropertyOrdering, "requiresPropertyOrdering", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_requiresPropertyOrdering);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_canHandleBinaryNatively = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory_canHandleBinaryNatively(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_canHandleBinaryNatively, "canHandleBinaryNatively", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_canHandleBinaryNatively);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_canUseCharArrays = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory_canUseCharArrays(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_canUseCharArrays, "canUseCharArrays", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_canUseCharArrays);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_canParseAsync = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory_canParseAsync(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_canParseAsync, "canParseAsync", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_canParseAsync);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getFormatReadFeatureType = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_getFormatReadFeatureType(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getFormatReadFeatureType, "getFormatReadFeatureType", "()Ljava/lang/Class;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getFormatReadFeatureType);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getFormatWriteFeatureType = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_getFormatWriteFeatureType(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getFormatWriteFeatureType, "getFormatWriteFeatureType", "()Ljava/lang/Class;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getFormatWriteFeatureType);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_canUseSchema = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory_canUseSchema(jobject self_, jobject schema) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_canUseSchema, "canUseSchema", "(Lcom/fasterxml/jackson/core/FormatSchema;)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_canUseSchema, schema);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getFormatName = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_getFormatName(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getFormatName, "getFormatName", "()Ljava/lang/String;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getFormatName);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_hasFormat = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_hasFormat(jobject self_, jobject acc) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_hasFormat, "hasFormat", "(Lcom/fasterxml/jackson/core/format/InputAccessor;)Lcom/fasterxml/jackson/core/format/MatchStrength;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_hasFormat, acc);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_requiresCustomCodec = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory_requiresCustomCodec(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_requiresCustomCodec, "requiresCustomCodec", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_requiresCustomCodec);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_hasJSONFormat = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_hasJSONFormat(jobject self_, jobject acc) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_hasJSONFormat, "hasJSONFormat", "(Lcom/fasterxml/jackson/core/format/InputAccessor;)Lcom/fasterxml/jackson/core/format/MatchStrength;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_hasJSONFormat, acc);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_version = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_version(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_version, "version", "()Lcom/fasterxml/jackson/core/Version;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_version);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_configure = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_configure(jobject self_, jobject f, uint8_t state) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_configure, "configure", "(Lcom/fasterxml/jackson/core/JsonFactory$Feature;Z)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_configure, f, state);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_enable = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_enable(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_enable, "enable", "(Lcom/fasterxml/jackson/core/JsonFactory$Feature;)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_enable, f);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_disable = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_disable(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_disable, "disable", "(Lcom/fasterxml/jackson/core/JsonFactory$Feature;)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_disable, f);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_isEnabled = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory_isEnabled(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_isEnabled, "isEnabled", "(Lcom/fasterxml/jackson/core/JsonFactory$Feature;)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_isEnabled, f);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getParserFeatures = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonFactory_getParserFeatures(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getParserFeatures, "getParserFeatures", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getParserFeatures);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getGeneratorFeatures = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonFactory_getGeneratorFeatures(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getGeneratorFeatures, "getGeneratorFeatures", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getGeneratorFeatures);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getFormatParserFeatures = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonFactory_getFormatParserFeatures(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getFormatParserFeatures, "getFormatParserFeatures", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getFormatParserFeatures);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getFormatGeneratorFeatures = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonFactory_getFormatGeneratorFeatures(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getFormatGeneratorFeatures, "getFormatGeneratorFeatures", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getFormatGeneratorFeatures);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_configure1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_configure1(jobject self_, jobject f, uint8_t state) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_configure1, "configure", "(Lcom/fasterxml/jackson/core/JsonParser$Feature;Z)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_configure1, f, state);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_enable1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_enable1(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_enable1, "enable", "(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_enable1, f);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_disable1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_disable1(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_disable1, "disable", "(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_disable1, f);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_isEnabled1 = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory_isEnabled1(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_isEnabled1, "isEnabled", "(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_isEnabled1, f);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_isEnabled2 = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory_isEnabled2(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_isEnabled2, "isEnabled", "(Lcom/fasterxml/jackson/core/StreamReadFeature;)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_isEnabled2, f);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getInputDecorator = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_getInputDecorator(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getInputDecorator, "getInputDecorator", "()Lcom/fasterxml/jackson/core/io/InputDecorator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getInputDecorator);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_setInputDecorator = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_setInputDecorator(jobject self_, jobject d) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_setInputDecorator, "setInputDecorator", "(Lcom/fasterxml/jackson/core/io/InputDecorator;)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_setInputDecorator, d);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_configure2 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_configure2(jobject self_, jobject f, uint8_t state) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_configure2, "configure", "(Lcom/fasterxml/jackson/core/JsonGenerator$Feature;Z)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_configure2, f, state);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_enable2 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_enable2(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_enable2, "enable", "(Lcom/fasterxml/jackson/core/JsonGenerator$Feature;)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_enable2, f);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_disable2 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_disable2(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_disable2, "disable", "(Lcom/fasterxml/jackson/core/JsonGenerator$Feature;)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_disable2, f);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_isEnabled3 = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory_isEnabled3(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_isEnabled3, "isEnabled", "(Lcom/fasterxml/jackson/core/JsonGenerator$Feature;)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_isEnabled3, f);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_isEnabled4 = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory_isEnabled4(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_isEnabled4, "isEnabled", "(Lcom/fasterxml/jackson/core/StreamWriteFeature;)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_isEnabled4, f);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getCharacterEscapes = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_getCharacterEscapes(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getCharacterEscapes, "getCharacterEscapes", "()Lcom/fasterxml/jackson/core/io/CharacterEscapes;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getCharacterEscapes);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_setCharacterEscapes = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_setCharacterEscapes(jobject self_, jobject esc) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_setCharacterEscapes, "setCharacterEscapes", "(Lcom/fasterxml/jackson/core/io/CharacterEscapes;)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_setCharacterEscapes, esc);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getOutputDecorator = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_getOutputDecorator(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getOutputDecorator, "getOutputDecorator", "()Lcom/fasterxml/jackson/core/io/OutputDecorator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getOutputDecorator);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_setOutputDecorator = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_setOutputDecorator(jobject self_, jobject d) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_setOutputDecorator, "setOutputDecorator", "(Lcom/fasterxml/jackson/core/io/OutputDecorator;)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_setOutputDecorator, d);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_setRootValueSeparator = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_setRootValueSeparator(jobject self_, jobject sep) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_setRootValueSeparator, "setRootValueSeparator", "(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_setRootValueSeparator, sep);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getRootValueSeparator = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_getRootValueSeparator(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getRootValueSeparator, "getRootValueSeparator", "()Ljava/lang/String;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getRootValueSeparator);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_setCodec = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_setCodec(jobject self_, jobject oc) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_setCodec, "setCodec", "(Lcom/fasterxml/jackson/core/ObjectCodec;)Lcom/fasterxml/jackson/core/JsonFactory;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_setCodec, oc);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_getCodec = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_getCodec(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_getCodec, "getCodec", "()Lcom/fasterxml/jackson/core/ObjectCodec;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_getCodec);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createParser = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createParser(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createParser, "createParser", "(Ljava/io/File;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createParser, f);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createParser1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createParser1(jobject self_, jobject url) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createParser1, "createParser", "(Ljava/net/URL;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createParser1, url);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createParser2 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createParser2(jobject self_, jobject in) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createParser2, "createParser", "(Ljava/io/InputStream;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createParser2, in);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createParser3 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createParser3(jobject self_, jobject r) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createParser3, "createParser", "(Ljava/io/Reader;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createParser3, r);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createParser4 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createParser4(jobject self_, jobject data) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createParser4, "createParser", "(L[B;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createParser4, data);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createParser5 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createParser5(jobject self_, jobject data, int32_t offset, int32_t len) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createParser5, "createParser", "(L[B;II)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createParser5, data, offset, len);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createParser6 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createParser6(jobject self_, jobject content) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createParser6, "createParser", "(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createParser6, content);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createParser7 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createParser7(jobject self_, jobject content) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createParser7, "createParser", "(L[C;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createParser7, content);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createParser8 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createParser8(jobject self_, jobject content, int32_t offset, int32_t len) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createParser8, "createParser", "(L[C;II)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createParser8, content, offset, len);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createParser9 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createParser9(jobject self_, jobject in) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createParser9, "createParser", "(Ljava/io/DataInput;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createParser9, in);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createNonBlockingByteArrayParser = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createNonBlockingByteArrayParser(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createNonBlockingByteArrayParser, "createNonBlockingByteArrayParser", "()Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createNonBlockingByteArrayParser);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createGenerator = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createGenerator(jobject self_, jobject out, jobject enc) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createGenerator, "createGenerator", "(Ljava/io/OutputStream;Lcom/fasterxml/jackson/core/JsonEncoding;)Lcom/fasterxml/jackson/core/JsonGenerator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createGenerator, out, enc);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createGenerator1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createGenerator1(jobject self_, jobject out) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createGenerator1, "createGenerator", "(Ljava/io/OutputStream;)Lcom/fasterxml/jackson/core/JsonGenerator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createGenerator1, out);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createGenerator2 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createGenerator2(jobject self_, jobject w) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createGenerator2, "createGenerator", "(Ljava/io/Writer;)Lcom/fasterxml/jackson/core/JsonGenerator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createGenerator2, w);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createGenerator3 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createGenerator3(jobject self_, jobject f, jobject enc) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createGenerator3, "createGenerator", "(Ljava/io/File;Lcom/fasterxml/jackson/core/JsonEncoding;)Lcom/fasterxml/jackson/core/JsonGenerator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createGenerator3, f, enc);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createGenerator4 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createGenerator4(jobject self_, jobject out, jobject enc) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createGenerator4, "createGenerator", "(Ljava/io/DataOutput;Lcom/fasterxml/jackson/core/JsonEncoding;)Lcom/fasterxml/jackson/core/JsonGenerator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createGenerator4, out, enc);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createGenerator5 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createGenerator5(jobject self_, jobject out) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createGenerator5, "createGenerator", "(Ljava/io/DataOutput;)Lcom/fasterxml/jackson/core/JsonGenerator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createGenerator5, out);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createJsonParser(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createJsonParser, "createJsonParser", "(Ljava/io/File;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser, f);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createJsonParser1(jobject self_, jobject url) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createJsonParser1, "createJsonParser", "(Ljava/net/URL;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser1, url);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser2 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createJsonParser2(jobject self_, jobject in) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createJsonParser2, "createJsonParser", "(Ljava/io/InputStream;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser2, in);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser3 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createJsonParser3(jobject self_, jobject r) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createJsonParser3, "createJsonParser", "(Ljava/io/Reader;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser3, r);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser4 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createJsonParser4(jobject self_, jobject data) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createJsonParser4, "createJsonParser", "(L[B;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser4, data);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser5 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createJsonParser5(jobject self_, jobject data, int32_t offset, int32_t len) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createJsonParser5, "createJsonParser", "(L[B;II)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser5, data, offset, len);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser6 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createJsonParser6(jobject self_, jobject content) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createJsonParser6, "createJsonParser", "(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createJsonParser6, content);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createJsonGenerator = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createJsonGenerator(jobject self_, jobject out, jobject enc) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createJsonGenerator, "createJsonGenerator", "(Ljava/io/OutputStream;Lcom/fasterxml/jackson/core/JsonEncoding;)Lcom/fasterxml/jackson/core/JsonGenerator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createJsonGenerator, out, enc);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createJsonGenerator1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createJsonGenerator1(jobject self_, jobject out) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createJsonGenerator1, "createJsonGenerator", "(Ljava/io/Writer;)Lcom/fasterxml/jackson/core/JsonGenerator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createJsonGenerator1, out);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory_createJsonGenerator2 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory_createJsonGenerator2(jobject self_, jobject out) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory, &_m_com_fasterxml_jackson_core_JsonFactory_createJsonGenerator2, "createJsonGenerator", "(Ljava/io/OutputStream;)Lcom/fasterxml/jackson/core/JsonGenerator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory_createJsonGenerator2, out);
    return to_global_ref(_result);
}

jfieldID _f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_FACTORY_FEATURE_FLAGS = NULL;
int32_t get_com_fasterxml_jackson_core_JsonFactory_DEFAULT_FACTORY_FEATURE_FLAGS() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_static_field(_c_com_fasterxml_jackson_core_JsonFactory, &_f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_FACTORY_FEATURE_FLAGS, "DEFAULT_FACTORY_FEATURE_FLAGS","I");
    return ((*jniEnv)->GetStaticIntField(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory, _f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_FACTORY_FEATURE_FLAGS));
}


jfieldID _f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_PARSER_FEATURE_FLAGS = NULL;
int32_t get_com_fasterxml_jackson_core_JsonFactory_DEFAULT_PARSER_FEATURE_FLAGS() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_static_field(_c_com_fasterxml_jackson_core_JsonFactory, &_f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_PARSER_FEATURE_FLAGS, "DEFAULT_PARSER_FEATURE_FLAGS","I");
    return ((*jniEnv)->GetStaticIntField(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory, _f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_PARSER_FEATURE_FLAGS));
}


jfieldID _f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_GENERATOR_FEATURE_FLAGS = NULL;
int32_t get_com_fasterxml_jackson_core_JsonFactory_DEFAULT_GENERATOR_FEATURE_FLAGS() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_static_field(_c_com_fasterxml_jackson_core_JsonFactory, &_f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_GENERATOR_FEATURE_FLAGS, "DEFAULT_GENERATOR_FEATURE_FLAGS","I");
    return ((*jniEnv)->GetStaticIntField(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory, _f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_GENERATOR_FEATURE_FLAGS));
}


jfieldID _f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_ROOT_VALUE_SEPARATOR = NULL;
jobject get_com_fasterxml_jackson_core_JsonFactory_DEFAULT_ROOT_VALUE_SEPARATOR() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory, "com/fasterxml/jackson/core/JsonFactory");
    load_static_field(_c_com_fasterxml_jackson_core_JsonFactory, &_f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_ROOT_VALUE_SEPARATOR, "DEFAULT_ROOT_VALUE_SEPARATOR","Lcom/fasterxml/jackson/core/SerializableString;");
    return to_global_ref((*jniEnv)->GetStaticObjectField(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory, _f_com_fasterxml_jackson_core_JsonFactory_DEFAULT_ROOT_VALUE_SEPARATOR));
}


// com.fasterxml.jackson.core.JsonFactory$Feature
jclass _c_com_fasterxml_jackson_core_JsonFactory__Feature = NULL;

jmethodID _m_com_fasterxml_jackson_core_JsonFactory__Feature_values = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory__Feature_values() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory__Feature, "com/fasterxml/jackson/core/JsonFactory$Feature");
    load_static_method(_c_com_fasterxml_jackson_core_JsonFactory__Feature, &_m_com_fasterxml_jackson_core_JsonFactory__Feature_values, "values", "()L[com/fasterxml/jackson/core/JsonFactory$Feature;");
    jobject _result = (*jniEnv)->CallStaticObjectMethod(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory__Feature, _m_com_fasterxml_jackson_core_JsonFactory__Feature_values);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory__Feature_valueOf = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory__Feature_valueOf(jobject name) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory__Feature, "com/fasterxml/jackson/core/JsonFactory$Feature");
    load_static_method(_c_com_fasterxml_jackson_core_JsonFactory__Feature, &_m_com_fasterxml_jackson_core_JsonFactory__Feature_valueOf, "valueOf", "(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonFactory$Feature;");
    jobject _result = (*jniEnv)->CallStaticObjectMethod(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory__Feature, _m_com_fasterxml_jackson_core_JsonFactory__Feature_valueOf, name);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory__Feature_collectDefaults = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonFactory__Feature_collectDefaults() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory__Feature, "com/fasterxml/jackson/core/JsonFactory$Feature");
    load_static_method(_c_com_fasterxml_jackson_core_JsonFactory__Feature, &_m_com_fasterxml_jackson_core_JsonFactory__Feature_collectDefaults, "collectDefaults", "()I");
    int32_t _result = (*jniEnv)->CallStaticIntMethod(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory__Feature, _m_com_fasterxml_jackson_core_JsonFactory__Feature_collectDefaults);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory__Feature_ctor = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonFactory__Feature_ctor(uint8_t defaultState) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory__Feature, "com/fasterxml/jackson/core/JsonFactory$Feature");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory__Feature, &_m_com_fasterxml_jackson_core_JsonFactory__Feature_ctor, "<init>", "(Z)V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_com_fasterxml_jackson_core_JsonFactory__Feature, _m_com_fasterxml_jackson_core_JsonFactory__Feature_ctor, defaultState);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory__Feature_enabledByDefault = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory__Feature_enabledByDefault(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory__Feature, "com/fasterxml/jackson/core/JsonFactory$Feature");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory__Feature, &_m_com_fasterxml_jackson_core_JsonFactory__Feature_enabledByDefault, "enabledByDefault", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory__Feature_enabledByDefault);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory__Feature_enabledIn = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonFactory__Feature_enabledIn(jobject self_, int32_t flags) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory__Feature, "com/fasterxml/jackson/core/JsonFactory$Feature");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory__Feature, &_m_com_fasterxml_jackson_core_JsonFactory__Feature_enabledIn, "enabledIn", "(I)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory__Feature_enabledIn, flags);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonFactory__Feature_getMask = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonFactory__Feature_getMask(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonFactory__Feature, "com/fasterxml/jackson/core/JsonFactory$Feature");
    load_method(_c_com_fasterxml_jackson_core_JsonFactory__Feature, &_m_com_fasterxml_jackson_core_JsonFactory__Feature_getMask, "getMask", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonFactory__Feature_getMask);
    return _result;
}

// com.fasterxml.jackson.core.JsonParser
jclass _c_com_fasterxml_jackson_core_JsonParser = NULL;

jmethodID _m_com_fasterxml_jackson_core_JsonParser_ctor = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_ctor() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_ctor, "<init>", "()V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_com_fasterxml_jackson_core_JsonParser, _m_com_fasterxml_jackson_core_JsonParser_ctor);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_ctor1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_ctor1(int32_t features) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_ctor1, "<init>", "(I)V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_com_fasterxml_jackson_core_JsonParser, _m_com_fasterxml_jackson_core_JsonParser_ctor1, features);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getCodec = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getCodec(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getCodec, "getCodec", "()Lcom/fasterxml/jackson/core/ObjectCodec;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getCodec);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_setCodec = NULL;
FFI_PLUGIN_EXPORT
void com_fasterxml_jackson_core_JsonParser_setCodec(jobject self_, jobject oc) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_setCodec, "setCodec", "(Lcom/fasterxml/jackson/core/ObjectCodec;)V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_setCodec, oc);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getInputSource = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getInputSource(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getInputSource, "getInputSource", "()Ljava/lang/Object;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getInputSource);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError = NULL;
FFI_PLUGIN_EXPORT
void com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError(jobject self_, jobject payload) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError, "setRequestPayloadOnError", "(Lcom/fasterxml/jackson/core/util/RequestPayload;)V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError, payload);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError1 = NULL;
FFI_PLUGIN_EXPORT
void com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError1(jobject self_, jobject payload, jobject charset) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError1, "setRequestPayloadOnError", "(L[B;Ljava/lang/String;)V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError1, payload, charset);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError2 = NULL;
FFI_PLUGIN_EXPORT
void com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError2(jobject self_, jobject payload) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError2, "setRequestPayloadOnError", "(Ljava/lang/String;)V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_setRequestPayloadOnError2, payload);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_setSchema = NULL;
FFI_PLUGIN_EXPORT
void com_fasterxml_jackson_core_JsonParser_setSchema(jobject self_, jobject schema) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_setSchema, "setSchema", "(Lcom/fasterxml/jackson/core/FormatSchema;)V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_setSchema, schema);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getSchema = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getSchema(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getSchema, "getSchema", "()Lcom/fasterxml/jackson/core/FormatSchema;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getSchema);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_canUseSchema = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_canUseSchema(jobject self_, jobject schema) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_canUseSchema, "canUseSchema", "(Lcom/fasterxml/jackson/core/FormatSchema;)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_canUseSchema, schema);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_requiresCustomCodec = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_requiresCustomCodec(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_requiresCustomCodec, "requiresCustomCodec", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_requiresCustomCodec);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_canParseAsync = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_canParseAsync(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_canParseAsync, "canParseAsync", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_canParseAsync);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getNonBlockingInputFeeder = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getNonBlockingInputFeeder(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getNonBlockingInputFeeder, "getNonBlockingInputFeeder", "()Lcom/fasterxml/jackson/core/async/NonBlockingInputFeeder;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getNonBlockingInputFeeder);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getReadCapabilities = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getReadCapabilities(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getReadCapabilities, "getReadCapabilities", "()Lcom/fasterxml/jackson/core/util/JacksonFeatureSet;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getReadCapabilities);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_version = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_version(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_version, "version", "()Lcom/fasterxml/jackson/core/Version;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_version);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_close = NULL;
FFI_PLUGIN_EXPORT
void com_fasterxml_jackson_core_JsonParser_close(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_close, "close", "()V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_close);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_isClosed = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_isClosed(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_isClosed, "isClosed", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_isClosed);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getParsingContext = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getParsingContext(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getParsingContext, "getParsingContext", "()Lcom/fasterxml/jackson/core/JsonStreamContext;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getParsingContext);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_currentLocation = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_currentLocation(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_currentLocation, "currentLocation", "()Lcom/fasterxml/jackson/core/JsonLocation;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_currentLocation);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_currentTokenLocation = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_currentTokenLocation(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_currentTokenLocation, "currentTokenLocation", "()Lcom/fasterxml/jackson/core/JsonLocation;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_currentTokenLocation);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getCurrentLocation = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getCurrentLocation(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getCurrentLocation, "getCurrentLocation", "()Lcom/fasterxml/jackson/core/JsonLocation;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getCurrentLocation);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getTokenLocation = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getTokenLocation(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getTokenLocation, "getTokenLocation", "()Lcom/fasterxml/jackson/core/JsonLocation;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getTokenLocation);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_currentValue = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_currentValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_currentValue, "currentValue", "()Ljava/lang/Object;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_currentValue);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_assignCurrentValue = NULL;
FFI_PLUGIN_EXPORT
void com_fasterxml_jackson_core_JsonParser_assignCurrentValue(jobject self_, jobject v) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_assignCurrentValue, "assignCurrentValue", "(Ljava/lang/Object;)V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_assignCurrentValue, v);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getCurrentValue = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getCurrentValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getCurrentValue, "getCurrentValue", "()Ljava/lang/Object;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getCurrentValue);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_setCurrentValue = NULL;
FFI_PLUGIN_EXPORT
void com_fasterxml_jackson_core_JsonParser_setCurrentValue(jobject self_, jobject v) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_setCurrentValue, "setCurrentValue", "(Ljava/lang/Object;)V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_setCurrentValue, v);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_releaseBuffered = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_releaseBuffered(jobject self_, jobject out) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_releaseBuffered, "releaseBuffered", "(Ljava/io/OutputStream;)I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_releaseBuffered, out);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_releaseBuffered1 = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_releaseBuffered1(jobject self_, jobject w) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_releaseBuffered1, "releaseBuffered", "(Ljava/io/Writer;)I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_releaseBuffered1, w);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_enable = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_enable(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_enable, "enable", "(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_enable, f);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_disable = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_disable(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_disable, "disable", "(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_disable, f);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_configure = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_configure(jobject self_, jobject f, uint8_t state) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_configure, "configure", "(Lcom/fasterxml/jackson/core/JsonParser$Feature;Z)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_configure, f, state);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_isEnabled = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_isEnabled(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_isEnabled, "isEnabled", "(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_isEnabled, f);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_isEnabled1 = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_isEnabled1(jobject self_, jobject f) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_isEnabled1, "isEnabled", "(Lcom/fasterxml/jackson/core/StreamReadFeature;)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_isEnabled1, f);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getFeatureMask = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_getFeatureMask(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getFeatureMask, "getFeatureMask", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getFeatureMask);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_setFeatureMask = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_setFeatureMask(jobject self_, int32_t mask) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_setFeatureMask, "setFeatureMask", "(I)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_setFeatureMask, mask);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_overrideStdFeatures = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_overrideStdFeatures(jobject self_, int32_t values, int32_t mask) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_overrideStdFeatures, "overrideStdFeatures", "(II)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_overrideStdFeatures, values, mask);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getFormatFeatures = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_getFormatFeatures(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getFormatFeatures, "getFormatFeatures", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getFormatFeatures);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_overrideFormatFeatures = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_overrideFormatFeatures(jobject self_, int32_t values, int32_t mask) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_overrideFormatFeatures, "overrideFormatFeatures", "(II)Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_overrideFormatFeatures, values, mask);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_nextToken = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_nextToken(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_nextToken, "nextToken", "()Lcom/fasterxml/jackson/core/JsonToken;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_nextToken);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_nextValue = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_nextValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_nextValue, "nextValue", "()Lcom/fasterxml/jackson/core/JsonToken;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_nextValue);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_nextFieldName = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_nextFieldName(jobject self_, jobject str) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_nextFieldName, "nextFieldName", "(Lcom/fasterxml/jackson/core/SerializableString;)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_nextFieldName, str);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_nextFieldName1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_nextFieldName1(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_nextFieldName1, "nextFieldName", "()Ljava/lang/String;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_nextFieldName1);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_nextTextValue = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_nextTextValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_nextTextValue, "nextTextValue", "()Ljava/lang/String;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_nextTextValue);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_nextIntValue = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_nextIntValue(jobject self_, int32_t defaultValue) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_nextIntValue, "nextIntValue", "(I)I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_nextIntValue, defaultValue);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_nextLongValue = NULL;
FFI_PLUGIN_EXPORT
int64_t com_fasterxml_jackson_core_JsonParser_nextLongValue(jobject self_, int64_t defaultValue) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_nextLongValue, "nextLongValue", "(J)J");
    int64_t _result = (*jniEnv)->CallLongMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_nextLongValue, defaultValue);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_nextBooleanValue = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_nextBooleanValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_nextBooleanValue, "nextBooleanValue", "()Ljava/lang/Boolean;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_nextBooleanValue);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_skipChildren = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_skipChildren(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_skipChildren, "skipChildren", "()Lcom/fasterxml/jackson/core/JsonParser;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_skipChildren);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_finishToken = NULL;
FFI_PLUGIN_EXPORT
void com_fasterxml_jackson_core_JsonParser_finishToken(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_finishToken, "finishToken", "()V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_finishToken);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_currentToken = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_currentToken(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_currentToken, "currentToken", "()Lcom/fasterxml/jackson/core/JsonToken;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_currentToken);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_currentTokenId = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_currentTokenId(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_currentTokenId, "currentTokenId", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_currentTokenId);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getCurrentToken = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getCurrentToken(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getCurrentToken, "getCurrentToken", "()Lcom/fasterxml/jackson/core/JsonToken;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getCurrentToken);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getCurrentTokenId = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_getCurrentTokenId(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getCurrentTokenId, "getCurrentTokenId", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getCurrentTokenId);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_hasCurrentToken = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_hasCurrentToken(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_hasCurrentToken, "hasCurrentToken", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_hasCurrentToken);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_hasTokenId = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_hasTokenId(jobject self_, int32_t id) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_hasTokenId, "hasTokenId", "(I)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_hasTokenId, id);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_hasToken = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_hasToken(jobject self_, jobject t) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_hasToken, "hasToken", "(Lcom/fasterxml/jackson/core/JsonToken;)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_hasToken, t);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_isExpectedStartArrayToken = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_isExpectedStartArrayToken(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_isExpectedStartArrayToken, "isExpectedStartArrayToken", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_isExpectedStartArrayToken);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_isExpectedStartObjectToken = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_isExpectedStartObjectToken(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_isExpectedStartObjectToken, "isExpectedStartObjectToken", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_isExpectedStartObjectToken);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_isExpectedNumberIntToken = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_isExpectedNumberIntToken(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_isExpectedNumberIntToken, "isExpectedNumberIntToken", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_isExpectedNumberIntToken);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_isNaN = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_isNaN(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_isNaN, "isNaN", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_isNaN);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_clearCurrentToken = NULL;
FFI_PLUGIN_EXPORT
void com_fasterxml_jackson_core_JsonParser_clearCurrentToken(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_clearCurrentToken, "clearCurrentToken", "()V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_clearCurrentToken);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getLastClearedToken = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getLastClearedToken(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getLastClearedToken, "getLastClearedToken", "()Lcom/fasterxml/jackson/core/JsonToken;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getLastClearedToken);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_overrideCurrentName = NULL;
FFI_PLUGIN_EXPORT
void com_fasterxml_jackson_core_JsonParser_overrideCurrentName(jobject self_, jobject name) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_overrideCurrentName, "overrideCurrentName", "(Ljava/lang/String;)V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_overrideCurrentName, name);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getCurrentName = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getCurrentName(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getCurrentName, "getCurrentName", "()Ljava/lang/String;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getCurrentName);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_currentName = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_currentName(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_currentName, "currentName", "()Ljava/lang/String;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_currentName);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getText = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getText(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getText, "getText", "()Ljava/lang/String;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getText);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getText1 = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_getText1(jobject self_, jobject writer) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getText1, "getText", "(Ljava/io/Writer;)I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getText1, writer);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getTextCharacters = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getTextCharacters(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getTextCharacters, "getTextCharacters", "()L[C;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getTextCharacters);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getTextLength = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_getTextLength(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getTextLength, "getTextLength", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getTextLength);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getTextOffset = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_getTextOffset(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getTextOffset, "getTextOffset", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getTextOffset);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_hasTextCharacters = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_hasTextCharacters(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_hasTextCharacters, "hasTextCharacters", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_hasTextCharacters);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getNumberValue = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getNumberValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getNumberValue, "getNumberValue", "()Ljava/lang/Number;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getNumberValue);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getNumberValueExact = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getNumberValueExact(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getNumberValueExact, "getNumberValueExact", "()Ljava/lang/Number;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getNumberValueExact);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getNumberType = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getNumberType(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getNumberType, "getNumberType", "()Lcom/fasterxml/jackson/core/JsonParser$NumberType;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getNumberType);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getByteValue = NULL;
FFI_PLUGIN_EXPORT
int8_t com_fasterxml_jackson_core_JsonParser_getByteValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getByteValue, "getByteValue", "()B");
    int8_t _result = (*jniEnv)->CallByteMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getByteValue);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getShortValue = NULL;
FFI_PLUGIN_EXPORT
int16_t com_fasterxml_jackson_core_JsonParser_getShortValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getShortValue, "getShortValue", "()S");
    int16_t _result = (*jniEnv)->CallShortMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getShortValue);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getIntValue = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_getIntValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getIntValue, "getIntValue", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getIntValue);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getLongValue = NULL;
FFI_PLUGIN_EXPORT
int64_t com_fasterxml_jackson_core_JsonParser_getLongValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getLongValue, "getLongValue", "()J");
    int64_t _result = (*jniEnv)->CallLongMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getLongValue);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getBigIntegerValue = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getBigIntegerValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getBigIntegerValue, "getBigIntegerValue", "()Ljava/math/BigInteger;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getBigIntegerValue);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getFloatValue = NULL;
FFI_PLUGIN_EXPORT
float com_fasterxml_jackson_core_JsonParser_getFloatValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getFloatValue, "getFloatValue", "()F");
    float _result = (*jniEnv)->CallFloatMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getFloatValue);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getDoubleValue = NULL;
FFI_PLUGIN_EXPORT
double com_fasterxml_jackson_core_JsonParser_getDoubleValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getDoubleValue, "getDoubleValue", "()D");
    double _result = (*jniEnv)->CallDoubleMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getDoubleValue);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getDecimalValue = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getDecimalValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getDecimalValue, "getDecimalValue", "()Ljava/math/BigDecimal;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getDecimalValue);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getBooleanValue = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_getBooleanValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getBooleanValue, "getBooleanValue", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getBooleanValue);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getEmbeddedObject = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getEmbeddedObject(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getEmbeddedObject, "getEmbeddedObject", "()Ljava/lang/Object;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getEmbeddedObject);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getBinaryValue = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getBinaryValue(jobject self_, jobject bv) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getBinaryValue, "getBinaryValue", "(Lcom/fasterxml/jackson/core/Base64Variant;)L[B;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getBinaryValue, bv);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getBinaryValue1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getBinaryValue1(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getBinaryValue1, "getBinaryValue", "()L[B;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getBinaryValue1);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_readBinaryValue = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_readBinaryValue(jobject self_, jobject out) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_readBinaryValue, "readBinaryValue", "(Ljava/io/OutputStream;)I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_readBinaryValue, out);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_readBinaryValue1 = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_readBinaryValue1(jobject self_, jobject bv, jobject out) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_readBinaryValue1, "readBinaryValue", "(Lcom/fasterxml/jackson/core/Base64Variant;Ljava/io/OutputStream;)I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_readBinaryValue1, bv, out);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getValueAsInt = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_getValueAsInt(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getValueAsInt, "getValueAsInt", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getValueAsInt);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getValueAsInt1 = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser_getValueAsInt1(jobject self_, int32_t def) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getValueAsInt1, "getValueAsInt", "(I)I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getValueAsInt1, def);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getValueAsLong = NULL;
FFI_PLUGIN_EXPORT
int64_t com_fasterxml_jackson_core_JsonParser_getValueAsLong(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getValueAsLong, "getValueAsLong", "()J");
    int64_t _result = (*jniEnv)->CallLongMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getValueAsLong);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getValueAsLong1 = NULL;
FFI_PLUGIN_EXPORT
int64_t com_fasterxml_jackson_core_JsonParser_getValueAsLong1(jobject self_, int64_t def) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getValueAsLong1, "getValueAsLong", "(J)J");
    int64_t _result = (*jniEnv)->CallLongMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getValueAsLong1, def);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getValueAsDouble = NULL;
FFI_PLUGIN_EXPORT
double com_fasterxml_jackson_core_JsonParser_getValueAsDouble(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getValueAsDouble, "getValueAsDouble", "()D");
    double _result = (*jniEnv)->CallDoubleMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getValueAsDouble);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getValueAsDouble1 = NULL;
FFI_PLUGIN_EXPORT
double com_fasterxml_jackson_core_JsonParser_getValueAsDouble1(jobject self_, double def) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getValueAsDouble1, "getValueAsDouble", "(D)D");
    double _result = (*jniEnv)->CallDoubleMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getValueAsDouble1, def);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getValueAsBoolean = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_getValueAsBoolean(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getValueAsBoolean, "getValueAsBoolean", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getValueAsBoolean);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getValueAsBoolean1 = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_getValueAsBoolean1(jobject self_, uint8_t def) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getValueAsBoolean1, "getValueAsBoolean", "(Z)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getValueAsBoolean1, def);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getValueAsString = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getValueAsString(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getValueAsString, "getValueAsString", "()Ljava/lang/String;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getValueAsString);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getValueAsString1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getValueAsString1(jobject self_, jobject def) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getValueAsString1, "getValueAsString", "(Ljava/lang/String;)Ljava/lang/String;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getValueAsString1, def);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_canReadObjectId = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_canReadObjectId(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_canReadObjectId, "canReadObjectId", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_canReadObjectId);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_canReadTypeId = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser_canReadTypeId(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_canReadTypeId, "canReadTypeId", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_canReadTypeId);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getObjectId = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getObjectId(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getObjectId, "getObjectId", "()Ljava/lang/Object;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getObjectId);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_getTypeId = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_getTypeId(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_getTypeId, "getTypeId", "()Ljava/lang/Object;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_getTypeId);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_readValueAs = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_readValueAs(jobject self_, jobject valueType) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_readValueAs, "readValueAs", "(Ljava/lang/Class;)Ljava/lang/Object;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_readValueAs, valueType);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_readValueAs1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_readValueAs1(jobject self_, jobject valueTypeRef) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_readValueAs1, "readValueAs", "(Lcom/fasterxml/jackson/core/type/TypeReference;)Ljava/lang/Object;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_readValueAs1, valueTypeRef);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_readValuesAs = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_readValuesAs(jobject self_, jobject valueType) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_readValuesAs, "readValuesAs", "(Ljava/lang/Class;)Ljava/util/Iterator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_readValuesAs, valueType);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_readValuesAs1 = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_readValuesAs1(jobject self_, jobject valueTypeRef) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_readValuesAs1, "readValuesAs", "(Lcom/fasterxml/jackson/core/type/TypeReference;)Ljava/util/Iterator;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_readValuesAs1, valueTypeRef);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser_readValueAsTree = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser_readValueAsTree(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_method(_c_com_fasterxml_jackson_core_JsonParser, &_m_com_fasterxml_jackson_core_JsonParser_readValueAsTree, "readValueAsTree", "()Ljava/lang/Object;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser_readValueAsTree);
    return to_global_ref(_result);
}

jfieldID _f_com_fasterxml_jackson_core_JsonParser_DEFAULT_READ_CAPABILITIES = NULL;
jobject get_com_fasterxml_jackson_core_JsonParser_DEFAULT_READ_CAPABILITIES() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser, "com/fasterxml/jackson/core/JsonParser");
    load_static_field(_c_com_fasterxml_jackson_core_JsonParser, &_f_com_fasterxml_jackson_core_JsonParser_DEFAULT_READ_CAPABILITIES, "DEFAULT_READ_CAPABILITIES","Lcom/fasterxml/jackson/core/util/JacksonFeatureSet;");
    return to_global_ref((*jniEnv)->GetStaticObjectField(jniEnv, _c_com_fasterxml_jackson_core_JsonParser, _f_com_fasterxml_jackson_core_JsonParser_DEFAULT_READ_CAPABILITIES));
}


// com.fasterxml.jackson.core.JsonParser$Feature
jclass _c_com_fasterxml_jackson_core_JsonParser__Feature = NULL;

jmethodID _m_com_fasterxml_jackson_core_JsonParser__Feature_values = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser__Feature_values() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser__Feature, "com/fasterxml/jackson/core/JsonParser$Feature");
    load_static_method(_c_com_fasterxml_jackson_core_JsonParser__Feature, &_m_com_fasterxml_jackson_core_JsonParser__Feature_values, "values", "()L[com/fasterxml/jackson/core/JsonParser$Feature;");
    jobject _result = (*jniEnv)->CallStaticObjectMethod(jniEnv, _c_com_fasterxml_jackson_core_JsonParser__Feature, _m_com_fasterxml_jackson_core_JsonParser__Feature_values);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser__Feature_valueOf = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser__Feature_valueOf(jobject name) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser__Feature, "com/fasterxml/jackson/core/JsonParser$Feature");
    load_static_method(_c_com_fasterxml_jackson_core_JsonParser__Feature, &_m_com_fasterxml_jackson_core_JsonParser__Feature_valueOf, "valueOf", "(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonParser$Feature;");
    jobject _result = (*jniEnv)->CallStaticObjectMethod(jniEnv, _c_com_fasterxml_jackson_core_JsonParser__Feature, _m_com_fasterxml_jackson_core_JsonParser__Feature_valueOf, name);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser__Feature_collectDefaults = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser__Feature_collectDefaults() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser__Feature, "com/fasterxml/jackson/core/JsonParser$Feature");
    load_static_method(_c_com_fasterxml_jackson_core_JsonParser__Feature, &_m_com_fasterxml_jackson_core_JsonParser__Feature_collectDefaults, "collectDefaults", "()I");
    int32_t _result = (*jniEnv)->CallStaticIntMethod(jniEnv, _c_com_fasterxml_jackson_core_JsonParser__Feature, _m_com_fasterxml_jackson_core_JsonParser__Feature_collectDefaults);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser__Feature_ctor = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser__Feature_ctor(uint8_t defaultState) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser__Feature, "com/fasterxml/jackson/core/JsonParser$Feature");
    load_method(_c_com_fasterxml_jackson_core_JsonParser__Feature, &_m_com_fasterxml_jackson_core_JsonParser__Feature_ctor, "<init>", "(Z)V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_com_fasterxml_jackson_core_JsonParser__Feature, _m_com_fasterxml_jackson_core_JsonParser__Feature_ctor, defaultState);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser__Feature_enabledByDefault = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser__Feature_enabledByDefault(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser__Feature, "com/fasterxml/jackson/core/JsonParser$Feature");
    load_method(_c_com_fasterxml_jackson_core_JsonParser__Feature, &_m_com_fasterxml_jackson_core_JsonParser__Feature_enabledByDefault, "enabledByDefault", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser__Feature_enabledByDefault);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser__Feature_enabledIn = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonParser__Feature_enabledIn(jobject self_, int32_t flags) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser__Feature, "com/fasterxml/jackson/core/JsonParser$Feature");
    load_method(_c_com_fasterxml_jackson_core_JsonParser__Feature, &_m_com_fasterxml_jackson_core_JsonParser__Feature_enabledIn, "enabledIn", "(I)Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser__Feature_enabledIn, flags);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser__Feature_getMask = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonParser__Feature_getMask(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser__Feature, "com/fasterxml/jackson/core/JsonParser$Feature");
    load_method(_c_com_fasterxml_jackson_core_JsonParser__Feature, &_m_com_fasterxml_jackson_core_JsonParser__Feature_getMask, "getMask", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonParser__Feature_getMask);
    return _result;
}

// com.fasterxml.jackson.core.JsonParser$NumberType
jclass _c_com_fasterxml_jackson_core_JsonParser__NumberType = NULL;

jmethodID _m_com_fasterxml_jackson_core_JsonParser__NumberType_values = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser__NumberType_values() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser__NumberType, "com/fasterxml/jackson/core/JsonParser$NumberType");
    load_static_method(_c_com_fasterxml_jackson_core_JsonParser__NumberType, &_m_com_fasterxml_jackson_core_JsonParser__NumberType_values, "values", "()L[com/fasterxml/jackson/core/JsonParser$NumberType;");
    jobject _result = (*jniEnv)->CallStaticObjectMethod(jniEnv, _c_com_fasterxml_jackson_core_JsonParser__NumberType, _m_com_fasterxml_jackson_core_JsonParser__NumberType_values);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser__NumberType_valueOf = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser__NumberType_valueOf(jobject name) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser__NumberType, "com/fasterxml/jackson/core/JsonParser$NumberType");
    load_static_method(_c_com_fasterxml_jackson_core_JsonParser__NumberType, &_m_com_fasterxml_jackson_core_JsonParser__NumberType_valueOf, "valueOf", "(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonParser$NumberType;");
    jobject _result = (*jniEnv)->CallStaticObjectMethod(jniEnv, _c_com_fasterxml_jackson_core_JsonParser__NumberType, _m_com_fasterxml_jackson_core_JsonParser__NumberType_valueOf, name);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonParser__NumberType_ctor = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonParser__NumberType_ctor() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonParser__NumberType, "com/fasterxml/jackson/core/JsonParser$NumberType");
    load_method(_c_com_fasterxml_jackson_core_JsonParser__NumberType, &_m_com_fasterxml_jackson_core_JsonParser__NumberType_ctor, "<init>", "()V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_com_fasterxml_jackson_core_JsonParser__NumberType, _m_com_fasterxml_jackson_core_JsonParser__NumberType_ctor);
    return to_global_ref(_result);
}

// com.fasterxml.jackson.core.JsonToken
jclass _c_com_fasterxml_jackson_core_JsonToken = NULL;

jmethodID _m_com_fasterxml_jackson_core_JsonToken_values = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonToken_values() {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_static_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_values, "values", "()L[com/fasterxml/jackson/core/JsonToken;");
    jobject _result = (*jniEnv)->CallStaticObjectMethod(jniEnv, _c_com_fasterxml_jackson_core_JsonToken, _m_com_fasterxml_jackson_core_JsonToken_values);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonToken_valueOf = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonToken_valueOf(jobject name) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_static_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_valueOf, "valueOf", "(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;");
    jobject _result = (*jniEnv)->CallStaticObjectMethod(jniEnv, _c_com_fasterxml_jackson_core_JsonToken, _m_com_fasterxml_jackson_core_JsonToken_valueOf, name);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonToken_ctor = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonToken_ctor(jobject token, int32_t id) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_ctor, "<init>", "(Ljava/lang/String;I)V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_com_fasterxml_jackson_core_JsonToken, _m_com_fasterxml_jackson_core_JsonToken_ctor, token, id);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonToken_id = NULL;
FFI_PLUGIN_EXPORT
int32_t com_fasterxml_jackson_core_JsonToken_id(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_id, "id", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonToken_id);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonToken_asString = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonToken_asString(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_asString, "asString", "()Ljava/lang/String;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonToken_asString);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonToken_asCharArray = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonToken_asCharArray(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_asCharArray, "asCharArray", "()L[C;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonToken_asCharArray);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonToken_asByteArray = NULL;
FFI_PLUGIN_EXPORT
jobject com_fasterxml_jackson_core_JsonToken_asByteArray(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_asByteArray, "asByteArray", "()L[B;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonToken_asByteArray);
    return to_global_ref(_result);
}

jmethodID _m_com_fasterxml_jackson_core_JsonToken_isNumeric = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonToken_isNumeric(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_isNumeric, "isNumeric", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonToken_isNumeric);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonToken_isStructStart = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonToken_isStructStart(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_isStructStart, "isStructStart", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonToken_isStructStart);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonToken_isStructEnd = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonToken_isStructEnd(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_isStructEnd, "isStructEnd", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonToken_isStructEnd);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonToken_isScalarValue = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonToken_isScalarValue(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_isScalarValue, "isScalarValue", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonToken_isScalarValue);
    return _result;
}

jmethodID _m_com_fasterxml_jackson_core_JsonToken_isBoolean = NULL;
FFI_PLUGIN_EXPORT
uint8_t com_fasterxml_jackson_core_JsonToken_isBoolean(jobject self_) {
    load_env();
    load_class_gr(&_c_com_fasterxml_jackson_core_JsonToken, "com/fasterxml/jackson/core/JsonToken");
    load_method(_c_com_fasterxml_jackson_core_JsonToken, &_m_com_fasterxml_jackson_core_JsonToken_isBoolean, "isBoolean", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_com_fasterxml_jackson_core_JsonToken_isBoolean);
    return _result;
}

