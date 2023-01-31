// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:jnigen/jnigen.dart';

const testName = 'kotlin_test';
const jarFile = '$testName.jar';

final testRoot = join('test', testName);
final kotlinPath = join(testRoot, 'kotlin');
final jarPath = join(kotlinPath, 'target', jarFile);

const preamble = '''
// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

''';

void compileKotlinSources(String workingDir) async {
  final procRes = Process.runSync(
    'mvn',
    ['package'],
    workingDirectory: workingDir,
  );
  if (procRes.exitCode != 0) {
    throw "mvn exited with ${procRes.exitCode}\n"
        "${procRes.stderr}";
  }
}

Config getConfig([BindingsType bindingsType = BindingsType.cBased]) {
  compileKotlinSources(kotlinPath);
  final cWrapperDir = Uri.directory(join(testRoot, "src"));
  final dartWrappersRoot = Uri.directory(join(testRoot, "lib"));
  final config = Config(
    classPath: [Uri.file(jarPath)],
    classes: [
      // Generating the entire library.
      //
      // This makes sure that no private class generated by Kotlin can make its
      // way to the generated code.
      'com.github.dart_lang.jnigen',
    ],
    suspendFunToAsync: true,
    logLevel: Level.ALL,
    outputConfig: OutputConfig(
      bindingsType: bindingsType,
      cConfig: CCodeOutputConfig(
        path: cWrapperDir,
        libraryName: 'kotlin',
      ),
      dartConfig: DartCodeOutputConfig(
        path: dartWrappersRoot.resolve('kotlin.dart'),
        structure: OutputStructure.singleFile,
      ),
    ),
    summarizerOptions: SummarizerOptions(backend: 'asm'),
    preamble: preamble,
  );
  return config;
}

void main() async => await generateJniBindings(getConfig());
