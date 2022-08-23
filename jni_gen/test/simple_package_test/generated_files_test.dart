// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'generate.dart';
import '../test_util/test_util.dart';

void main() async {
  await generateSources('test_lib', 'test_src');
  // test if generated file == expected file
  test('compare generated files', () {
    compareFiles(testName, 'lib');
    compareFiles(testName, 'src');
  });
}
