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

// dev.dart.simple_package.Example
jclass _c_dev_dart_simple_package_Example = NULL;

jmethodID _m_dev_dart_simple_package_Example_ctor = NULL;
FFI_PLUGIN_EXPORT
jobject dev_dart_simple_package_Example_ctor() {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example, "dev/dart/simple_package/Example");
    load_method(_c_dev_dart_simple_package_Example, &_m_dev_dart_simple_package_Example_ctor, "<init>", "()V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_dev_dart_simple_package_Example, _m_dev_dart_simple_package_Example_ctor);
    return to_global_ref(_result);
}

jmethodID _m_dev_dart_simple_package_Example_getAux = NULL;
FFI_PLUGIN_EXPORT
jobject dev_dart_simple_package_Example_getAux() {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example, "dev/dart/simple_package/Example");
    load_static_method(_c_dev_dart_simple_package_Example, &_m_dev_dart_simple_package_Example_getAux, "getAux", "()Ldev/dart/simple_package/Example$Aux;");
    jobject _result = (*jniEnv)->CallStaticObjectMethod(jniEnv, _c_dev_dart_simple_package_Example, _m_dev_dart_simple_package_Example_getAux);
    return to_global_ref(_result);
}

jmethodID _m_dev_dart_simple_package_Example_addInts = NULL;
FFI_PLUGIN_EXPORT
int32_t dev_dart_simple_package_Example_addInts(int32_t a, int32_t b) {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example, "dev/dart/simple_package/Example");
    load_static_method(_c_dev_dart_simple_package_Example, &_m_dev_dart_simple_package_Example_addInts, "addInts", "(II)I");
    int32_t _result = (*jniEnv)->CallStaticIntMethod(jniEnv, _c_dev_dart_simple_package_Example, _m_dev_dart_simple_package_Example_addInts, a, b);
    return _result;
}

jmethodID _m_dev_dart_simple_package_Example_getSelf = NULL;
FFI_PLUGIN_EXPORT
jobject dev_dart_simple_package_Example_getSelf(jobject self_) {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example, "dev/dart/simple_package/Example");
    load_method(_c_dev_dart_simple_package_Example, &_m_dev_dart_simple_package_Example_getSelf, "getSelf", "()Ldev/dart/simple_package/Example;");
    jobject _result = (*jniEnv)->CallObjectMethod(jniEnv, self_, _m_dev_dart_simple_package_Example_getSelf);
    return to_global_ref(_result);
}

jmethodID _m_dev_dart_simple_package_Example_getNum = NULL;
FFI_PLUGIN_EXPORT
int32_t dev_dart_simple_package_Example_getNum(jobject self_) {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example, "dev/dart/simple_package/Example");
    load_method(_c_dev_dart_simple_package_Example, &_m_dev_dart_simple_package_Example_getNum, "getNum", "()I");
    int32_t _result = (*jniEnv)->CallIntMethod(jniEnv, self_, _m_dev_dart_simple_package_Example_getNum);
    return _result;
}

jmethodID _m_dev_dart_simple_package_Example_setNum = NULL;
FFI_PLUGIN_EXPORT
void dev_dart_simple_package_Example_setNum(jobject self_, int32_t num) {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example, "dev/dart/simple_package/Example");
    load_method(_c_dev_dart_simple_package_Example, &_m_dev_dart_simple_package_Example_setNum, "setNum", "(I)V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_dev_dart_simple_package_Example_setNum, num);
}

jfieldID _f_dev_dart_simple_package_Example_aux = NULL;
jobject get_dev_dart_simple_package_Example_aux() {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example, "dev/dart/simple_package/Example");
    load_static_field(_c_dev_dart_simple_package_Example, &_f_dev_dart_simple_package_Example_aux, "aux","Ldev/dart/simple_package/Example$Aux;");
    return to_global_ref((*jniEnv)->GetStaticObjectField(jniEnv, _c_dev_dart_simple_package_Example, _f_dev_dart_simple_package_Example_aux));
}

void set_dev_dart_simple_package_Example_aux(jobject value) {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example, "dev/dart/simple_package/Example");
    load_static_field(_c_dev_dart_simple_package_Example, &_f_dev_dart_simple_package_Example_aux, "aux","Ldev/dart/simple_package/Example$Aux;");
    ((*jniEnv)->SetStaticObjectField(jniEnv, _c_dev_dart_simple_package_Example, _f_dev_dart_simple_package_Example_aux, value));
}


jfieldID _f_dev_dart_simple_package_Example_num = NULL;
int32_t get_dev_dart_simple_package_Example_num() {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example, "dev/dart/simple_package/Example");
    load_static_field(_c_dev_dart_simple_package_Example, &_f_dev_dart_simple_package_Example_num, "num","I");
    return ((*jniEnv)->GetStaticIntField(jniEnv, _c_dev_dart_simple_package_Example, _f_dev_dart_simple_package_Example_num));
}

void set_dev_dart_simple_package_Example_num(int32_t value) {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example, "dev/dart/simple_package/Example");
    load_static_field(_c_dev_dart_simple_package_Example, &_f_dev_dart_simple_package_Example_num, "num","I");
    ((*jniEnv)->SetStaticIntField(jniEnv, _c_dev_dart_simple_package_Example, _f_dev_dart_simple_package_Example_num, value));
}


// dev.dart.simple_package.Example$Aux
jclass _c_dev_dart_simple_package_Example__Aux = NULL;

jmethodID _m_dev_dart_simple_package_Example__Aux_ctor = NULL;
FFI_PLUGIN_EXPORT
jobject dev_dart_simple_package_Example__Aux_ctor(uint8_t value) {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example__Aux, "dev/dart/simple_package/Example$Aux");
    load_method(_c_dev_dart_simple_package_Example__Aux, &_m_dev_dart_simple_package_Example__Aux_ctor, "<init>", "(Z)V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_dev_dart_simple_package_Example__Aux, _m_dev_dart_simple_package_Example__Aux_ctor, value);
    return to_global_ref(_result);
}

jmethodID _m_dev_dart_simple_package_Example__Aux_getValue = NULL;
FFI_PLUGIN_EXPORT
uint8_t dev_dart_simple_package_Example__Aux_getValue(jobject self_) {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example__Aux, "dev/dart/simple_package/Example$Aux");
    load_method(_c_dev_dart_simple_package_Example__Aux, &_m_dev_dart_simple_package_Example__Aux_getValue, "getValue", "()Z");
    uint8_t _result = (*jniEnv)->CallBooleanMethod(jniEnv, self_, _m_dev_dart_simple_package_Example__Aux_getValue);
    return _result;
}

jmethodID _m_dev_dart_simple_package_Example__Aux_setValue = NULL;
FFI_PLUGIN_EXPORT
void dev_dart_simple_package_Example__Aux_setValue(jobject self_, uint8_t value) {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example__Aux, "dev/dart/simple_package/Example$Aux");
    load_method(_c_dev_dart_simple_package_Example__Aux, &_m_dev_dart_simple_package_Example__Aux_setValue, "setValue", "(Z)V");
    (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_dev_dart_simple_package_Example__Aux_setValue, value);
}

jfieldID _f_dev_dart_simple_package_Example__Aux_value = NULL;
uint8_t get_dev_dart_simple_package_Example__Aux_value(jobject self_) {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example__Aux, "dev/dart/simple_package/Example$Aux");
    load_field(_c_dev_dart_simple_package_Example__Aux, &_f_dev_dart_simple_package_Example__Aux_value, "value","Z");
    return ((*jniEnv)->GetBooleanField(jniEnv, self_, _f_dev_dart_simple_package_Example__Aux_value));
}

void set_dev_dart_simple_package_Example__Aux_value(jobject self_, uint8_t value) {
    load_env();
    load_class_gr(&_c_dev_dart_simple_package_Example__Aux, "dev/dart/simple_package/Example$Aux");
    load_field(_c_dev_dart_simple_package_Example__Aux, &_f_dev_dart_simple_package_Example__Aux_value, "value","Z");
    ((*jniEnv)->SetBooleanField(jniEnv, self_, _f_dev_dart_simple_package_Example__Aux_value, value));
}


// dev.dart.pkg2.C2
jclass _c_dev_dart_pkg2_C2 = NULL;

jmethodID _m_dev_dart_pkg2_C2_ctor = NULL;
FFI_PLUGIN_EXPORT
jobject dev_dart_pkg2_C2_ctor() {
    load_env();
    load_class_gr(&_c_dev_dart_pkg2_C2, "dev/dart/pkg2/C2");
    load_method(_c_dev_dart_pkg2_C2, &_m_dev_dart_pkg2_C2_ctor, "<init>", "()V");
    jobject _result = (*jniEnv)->NewObject(jniEnv, _c_dev_dart_pkg2_C2, _m_dev_dart_pkg2_C2_ctor);
    return to_global_ref(_result);
}

jfieldID _f_dev_dart_pkg2_C2_CONSTANT = NULL;
int32_t get_dev_dart_pkg2_C2_CONSTANT() {
    load_env();
    load_class_gr(&_c_dev_dart_pkg2_C2, "dev/dart/pkg2/C2");
    load_static_field(_c_dev_dart_pkg2_C2, &_f_dev_dart_pkg2_C2_CONSTANT, "CONSTANT","I");
    return ((*jniEnv)->GetStaticIntField(jniEnv, _c_dev_dart_pkg2_C2, _f_dev_dart_pkg2_C2_CONSTANT));
}

void set_dev_dart_pkg2_C2_CONSTANT(int32_t value) {
    load_env();
    load_class_gr(&_c_dev_dart_pkg2_C2, "dev/dart/pkg2/C2");
    load_static_field(_c_dev_dart_pkg2_C2, &_f_dev_dart_pkg2_C2_CONSTANT, "CONSTANT","I");
    ((*jniEnv)->SetStaticIntField(jniEnv, _c_dev_dart_pkg2_C2, _f_dev_dart_pkg2_C2_CONSTANT, value));
}


