// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// These tests validate summary generation in various scenarios.
// Currently, no validation of the summary content itself is done.

@Tags(['summarizer_test'])

import 'dart:math';

import 'package:jnigen/src/config/config.dart';
import 'package:jnigen/src/elements/elements.dart';
import 'package:jnigen/src/summary/summary.dart';

import 'package:path/path.dart' hide equals;
import 'package:test/test.dart';

import 'test_util/summary_util.dart';
import 'test_util/test_util.dart';

const nestedClasses = [
  'com.github.dart_lang.jnigen.simple_package.Example\$Nested',
  'com.github.dart_lang.jnigen.simple_package.Example\$Nested\$NestedTwice',
  'com.github.dart_lang.jnigen.generics.GrandParent\$StaticParent',
  'com.github.dart_lang.jnigen.generics.GrandParent\$StaticParent\$Child',
  'com.github.dart_lang.jnigen.generics.GrandParent\$Parent',
  'com.github.dart_lang.jnigen.generics.GrandParent\$Parent\$Child',
];

void expectSummaryHasAllClasses(Classes? classes) {
  expect(classes, isNotNull);
  final decls = classes!.decls;
  expect(decls.entries.length, greaterThanOrEqualTo(javaFiles.length));
  final declNames = decls.keys.toSet();
  final expectedClasses =
      javaClasses.where((name) => !name.contains("annotations.")).toList();
  // Nested classes should be included automatically with parent class.
  // change this part if you change this behavior intentionally.
  expectedClasses.addAll(nestedClasses);
  expect(declNames, containsAll(expectedClasses));
}

/// Packs files indicated by [artifacts], each relative to [artifactDir] into
/// a JAR file at [jarPath].
Future<void> createJar({
  required String artifactDir,
  required List<String> artifacts,
  required String jarPath,
}) async {
  await runCommand(
    'jar',
    ['cf', relative(jarPath, from: artifactDir), ...artifacts],
    workingDirectory: artifactDir,
  );
}

final random = Random.secure();

void testSuccessCase(String description, Config config) {
  config.classes = summarizerClassesSpec;
  test(description, () async {
    final classes = await getSummary(config);
    expectSummaryHasAllClasses(classes);
  });
}

void testFailureCase(
    String description, Config config, String nonExistingClass) {
  test(description, () async {
    final insertPosition = random.nextInt(config.classes.length + 1);
    config.classes = summarizerClassesSpec.sublist(0, insertPosition) +
        [nonExistingClass] +
        summarizerClassesSpec.sublist(insertPosition);
    try {
      await getSummary(config);
    } on SummaryParseException catch (e) {
      expect(e.stderr, isNotNull);
      expect(e.stderr!, stringContainsInOrder(["Not found", nonExistingClass]));
      return;
    }
    throw AssertionError("No exception was caught");
  });
}

void testAllCases({
  List<String>? sourcePath,
  List<String>? classPath,
}) {
  testSuccessCase(
    '- valid config',
    getSummaryGenerationConfig(sourcePath: sourcePath, classPath: classPath),
  );
  testFailureCase(
    '- should fail with non-existing class',
    getSummaryGenerationConfig(sourcePath: sourcePath, classPath: classPath),
    'com.github.dart_lang.jnigen.DoesNotExist',
  );
  testFailureCase(
    '- should fail with non-existing package',
    getSummaryGenerationConfig(sourcePath: sourcePath, classPath: classPath),
    'com.github.dart_lang.notexist',
  );
}

void main() async {
  await checkLocallyBuiltDependencies();
  final tempDir = getTempDir("jnigen_summary_tests_");

  group('Test summary generation from compiled JAR', () {
    final targetDir = tempDir.createTempSync("compiled_jar_test_");
    final jarPath = join(targetDir.absolute.path, 'classes.jar');
    setUpAll(() async {
      await compileJavaFiles(simplePackageDir, targetDir);
      final classFiles = findFilesWithSuffix(targetDir, '.class');
      await createJar(
          artifactDir: targetDir.path, artifacts: classFiles, jarPath: jarPath);
    });
    testAllCases(classPath: [jarPath]);
  });

  group('Test summary generation from source JAR', () {
    final targetDir = tempDir.createTempSync("source_jar_test_");
    final jarPath = join(targetDir.path, 'sources.jar');
    setUpAll(() async {
      await createJar(
          artifactDir: simplePackageDir.path,
          artifacts: javaFiles,
          jarPath: jarPath);
    });
    testAllCases(sourcePath: [jarPath]);
  });

  group('Test summary generation from source folder', () {
    testAllCases(sourcePath: [simplePackagePath]);
  });

  group('Test summary generation from compiled classes in directory', () {
    final targetDir = tempDir.createTempSync("compiled_classes_test_");
    setUpAll(() => compileJavaFiles(simplePackageDir, targetDir));
    testAllCases(classPath: [targetDir.path]);
  });

  // Test summary generation from combination of a source and class path
  group('Test summary generation from combination', () {
    final targetDir = tempDir.createTempSync("combination_test_");
    final classesJarPath = join(targetDir.path, 'classes.jar');
    // remove a class from source files and create a source JAR
    final sourceFiles = javaFiles.toList();
    sourceFiles.removeLast();
    final sourceJarPath = join(targetDir.path, 'sources.jar');
    setUpAll(() async {
      await createJar(
        artifactDir: simplePackageDir.path,
        artifacts: sourceFiles,
        jarPath: sourceJarPath,
      );

      await compileJavaFiles(simplePackageDir, targetDir);
      final classFiles = findFilesWithSuffix(targetDir, '.class');
      await createJar(
        artifactDir: targetDir.path,
        artifacts: classFiles,
        jarPath: classesJarPath,
      );
    });
    testAllCases(
      classPath: [classesJarPath],
      sourcePath: [sourceJarPath],
    );
  });

  tearDownAll(() => deleteTempDirWithDelay(tempDir));
}
