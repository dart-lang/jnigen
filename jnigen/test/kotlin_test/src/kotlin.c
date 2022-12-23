// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Autogenerated by jnigen. DO NOT EDIT!

#include <stdint.h>
#include "dartjni.h"
#include "jni.h"

thread_local JNIEnv* jniEnv;
JniContext jni;

JniContext (*context_getter)(void);
JNIEnv* (*env_getter)(void);

void setJniGetters(JniContext (*cg)(void), JNIEnv* (*eg)(void)) {
  context_getter = cg;
  env_getter = eg;
}

// com.github.dart_lang.jnigen.SuspendFun
jclass _c_SuspendFun = NULL;

jmethodID _m_SuspendFun__ctor = NULL;
FFI_PLUGIN_EXPORT
JniResult SuspendFun__ctor() {
  load_env();
  load_class_gr(&_c_SuspendFun, "com/github/dart_lang/jnigen/SuspendFun");
  if (_c_SuspendFun == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  load_method(_c_SuspendFun, &_m_SuspendFun__ctor, "<init>", "()V");
  if (_m_SuspendFun__ctor == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  jobject _result =
      (*jniEnv)->NewObject(jniEnv, _c_SuspendFun, _m_SuspendFun__ctor);
  return (JniResult){.result = {.l = to_global_ref(_result)},
                     .exception = check_exception()};
}

jmethodID _m_SuspendFun__sayHello = NULL;
FFI_PLUGIN_EXPORT
JniResult SuspendFun__sayHello(jobject self_, jobject continuation) {
  load_env();
  load_class_gr(&_c_SuspendFun, "com/github/dart_lang/jnigen/SuspendFun");
  if (_c_SuspendFun == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  load_method(_c_SuspendFun, &_m_SuspendFun__sayHello, "sayHello",
              "(Lkotlin/coroutines/Continuation;)Ljava/lang/Object;");
  if (_m_SuspendFun__sayHello == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  jobject _result = (*jniEnv)->CallObjectMethod(
      jniEnv, self_, _m_SuspendFun__sayHello, continuation);
  return (JniResult){.result = {.l = to_global_ref(_result)},
                     .exception = check_exception()};
}

jmethodID _m_SuspendFun__sayHello1 = NULL;
FFI_PLUGIN_EXPORT
JniResult SuspendFun__sayHello1(jobject self_,
                                jobject string,
                                jobject continuation) {
  load_env();
  load_class_gr(&_c_SuspendFun, "com/github/dart_lang/jnigen/SuspendFun");
  if (_c_SuspendFun == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  load_method(
      _c_SuspendFun, &_m_SuspendFun__sayHello1, "sayHello",
      "(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;");
  if (_m_SuspendFun__sayHello1 == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  jobject _result = (*jniEnv)->CallObjectMethod(
      jniEnv, self_, _m_SuspendFun__sayHello1, string, continuation);
  return (JniResult){.result = {.l = to_global_ref(_result)},
                     .exception = check_exception()};
}

// com.github.dart_lang.jnigen.SuspendFun$sayHello$1
jclass _c_SuspendFun_sayHello_1 = NULL;

// com.github.dart_lang.jnigen.SuspendFun$sayHello$2
jclass _c_SuspendFun_sayHello_2 = NULL;

// com.github.dart_lang.jni.PortContinuation
jclass _c_PortContinuation = NULL;

jmethodID _m_PortContinuation__ctor = NULL;
FFI_PLUGIN_EXPORT
JniResult PortContinuation__ctor(int64_t j) {
  load_env();
  load_class_gr(&_c_PortContinuation,
                "com/github/dart_lang/jni/PortContinuation");
  if (_c_PortContinuation == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  load_method(_c_PortContinuation, &_m_PortContinuation__ctor, "<init>",
              "(J)V");
  if (_m_PortContinuation__ctor == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  jobject _result = (*jniEnv)->NewObject(jniEnv, _c_PortContinuation,
                                         _m_PortContinuation__ctor, j);
  return (JniResult){.result = {.l = to_global_ref(_result)},
                     .exception = check_exception()};
}

jmethodID _m_PortContinuation__getContext = NULL;
FFI_PLUGIN_EXPORT
JniResult PortContinuation__getContext(jobject self_) {
  load_env();
  load_class_gr(&_c_PortContinuation,
                "com/github/dart_lang/jni/PortContinuation");
  if (_c_PortContinuation == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  load_method(_c_PortContinuation, &_m_PortContinuation__getContext,
              "getContext", "()Lkotlin/coroutines/CoroutineContext;");
  if (_m_PortContinuation__getContext == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  jobject _result = (*jniEnv)->CallObjectMethod(
      jniEnv, self_, _m_PortContinuation__getContext);
  return (JniResult){.result = {.l = to_global_ref(_result)},
                     .exception = check_exception()};
}

jmethodID _m_PortContinuation__resumeWith = NULL;
FFI_PLUGIN_EXPORT
JniResult PortContinuation__resumeWith(jobject self_, jobject object) {
  load_env();
  load_class_gr(&_c_PortContinuation,
                "com/github/dart_lang/jni/PortContinuation");
  if (_c_PortContinuation == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  load_method(_c_PortContinuation, &_m_PortContinuation__resumeWith,
              "resumeWith", "(Ljava/lang/Object;)V");
  if (_m_PortContinuation__resumeWith == NULL)
    return (JniResult){.result = {.j = 0}, .exception = check_exception()};
  (*jniEnv)->CallVoidMethod(jniEnv, self_, _m_PortContinuation__resumeWith,
                            object);
  return (JniResult){.result = {.j = 0}, .exception = check_exception()};
}
