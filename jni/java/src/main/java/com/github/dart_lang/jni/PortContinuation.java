// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.github.dart_lang.jni;

import kotlin.coroutines.Continuation;
import kotlin.coroutines.CoroutineContext;
import kotlinx.coroutines.Dispatchers;

/// An implementation of kotlin.coroutines.Continuation which sends the address
/// of the object to Dart through a native port.
///
/// This allows converting Kotlin coroutines to Dart async methods.
/// The implementation of native void _resumeWith is located in `dartjni.c`.
public class PortContinuation<T> implements Continuation<T> {
  static {
    System.loadLibrary("dartjni");
  }

  private final long port;

  public PortContinuation(long port) {
    this.port = port;
  }

  @Override
  public CoroutineContext getContext() {
    return (CoroutineContext) Dispatchers.getIO();
  }

  @Override
  public void resumeWith(Object o) {
    _resumeWith(port, o);
  }

  private native void _resumeWith(long port, Object result);
}
