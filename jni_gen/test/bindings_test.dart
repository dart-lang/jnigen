// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Tests on generated code.
//
// Both the simple java example & jackson core classes example have tests in
// same file, because the test runner will reuse the process, which leads to
// reuse of the old JVM with old classpath if we have separate tests with
// different classpaths.

import 'dart:io';

import 'package:jni/jni.dart';
import 'package:path/path.dart' hide equals;
import 'package:test/test.dart';

// ignore_for_file: avoid_relative_lib_imports
import 'simple_package_test/lib/dev/dart/simple_package.dart';
import 'simple_package_test/lib/dev/dart/pkg2.dart';
import 'jackson_core_test/lib/com/fasterxml/jackson/core.dart';

import 'test_util/test_util.dart';

final simplePackagePath = join('test', 'simple_package_test');
final jacksonCorePath = join('test', 'jackson_core_test');
final simplePackageJavaPath = join(simplePackagePath, 'java');

Future<void> setupDylibsAndClasses() async {
  await runCmd('dart', ['run', 'jni:setup']);
  await runCmd(
      'dart', ['run', 'jni:setup', '-S', join(simplePackagePath, 'src')]);
  await runCmd(
      'dart', ['run', 'jni:setup', '-S', join(jacksonCorePath, 'src')]);
  await runCmd('javac',
      ['dev/dart/simple_package/Example.java', 'dev/dart/pkg2/C2.java'],
      workingDirectory: simplePackageJavaPath);

  final jacksonJars = await getJarPaths('jackson_core_test');

  if (!Platform.isAndroid) {
    Jni.spawn(
        helperDir: 'build/jni_libs',
        classPath: [simplePackageJavaPath, ...jacksonJars]);
  }
}

void main() async {
  await setupDylibsAndClasses();

  test('static final fields', () {
    expect(Example.ON, equals(1));
    expect(Example.OFF, equals(0));
  });

  test('static & instance fields', () {
    expect(Example.num, equals(121));
    final aux = Example.aux;
    expect(aux.value, equals(true));
    aux.delete();
    expect(C2.CONSTANT, equals(12));
  });

  test('static methods', () {
    expect(Example.addInts(10, 15), equals(25));
  });

  test('instance methods', () {
    final ex = Example();
    expect(ex.getNum(), equals(Example.num));
    final aux = Example.getAux();
    expect(aux.getValue(), equals(true));
    aux.setValue(false);
    expect(aux.getValue(), equals(false));
    aux.delete();
    ex.delete();
  });
  test('simple json parsing test', () {
    final json = JlString.fromString('[1, true, false, 2, 4]');
    final factory = JsonFactory();
    final parser = factory.createParser6(json);
    final values = <bool>[];
    while (!parser.isClosed()) {
      final next = parser.nextToken();
      values.add(next.isNumeric());
      next.delete();
    }
    expect(
        values, equals([false, true, false, false, true, true, false, false]));
    parser.delete();
    factory.delete();
    json.delete();
  });
}
