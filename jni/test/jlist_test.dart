// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:jni/jni.dart';
import 'package:test/test.dart';

import 'test_util/test_util.dart';

void main() {
  // Don't forget to initialize JNI.
  if (!Platform.isAndroid) {
    try {
      Jni.spawn(dylibDir: "build/jni_libs", jvmOptions: ["-Xmx128m"]);
    } on JvmExistsException catch (_) {
      // TODO(#51): Support destroying and reinstantiating JVM.
    }
  }
  run(testRunner: test);
}

void run({required TestRunnerCallback testRunner}) {
  JList<JString> newJList(Arena arena) {
    return [
      "1".toJString()..deletedIn(arena),
      "2".toJString()..deletedIn(arena),
      "3".toJString()..deletedIn(arena),
    ].toJList(JString.type)
      ..deletedIn(arena);
  }

  testRunner('length get', () {
    using((arena) {
      final list = newJList(arena);
      expect(list.length, 3);
    });
  });
  testRunner('length set', () {
    using((arena) {
      final list = newJList(arena);
      list.length = 2;
      expect(list.length, 2);
      list.length = 3;
      expect(list.length, 3);
      expect(list.last.isNull, true);
    });
  });
  testRunner('[]', () {
    using((arena) {
      final list = newJList(arena);
      expect(list[0].toDartString(deleteOriginal: true), "1");
      expect(list[1].toDartString(deleteOriginal: true), "2");
      expect(list[2].toDartString(deleteOriginal: true), "3");
    });
  });
  testRunner('[]=', () {
    using((arena) {
      final list = newJList(arena);
      expect(list[0].toDartString(deleteOriginal: true), "1");
      list[0] = "2".toJString()..deletedIn(arena);
      expect(list[0].toDartString(deleteOriginal: true), "2");
    });
  });
  testRunner('add', () {
    using((arena) {
      final list = newJList(arena);
      list.add("4".toJString()..deletedIn(arena));
      expect(list.length, 4);
      expect(list[3].toDartString(deleteOriginal: true), "4");
    });
  });
  testRunner('addAll', () {
    using((arena) {
      final list = newJList(arena);
      final toAppend = newJList(arena);
      list.addAll(toAppend);
      expect(list.length, 6);
      list.addAll(["4".toJString()..deletedIn(arena)]);
      expect(list.length, 7);
    });
  });
  testRunner('clear, isEmpty, isNotEmpty', () {
    using((arena) {
      final list = newJList(arena);
      expect(list.isNotEmpty, true);
      expect(list.isEmpty, false);
      list.clear();
      expect(list.isNotEmpty, false);
      expect(list.isEmpty, true);
    });
  });
  testRunner('contains', () {
    using((arena) {
      final list = newJList(arena);
      // ignore: iterable_contains_unrelated_type
      expect(list.contains("1"), false);
      expect(list.contains("1".toJString()..deletedIn(arena)), true);
      expect(list.contains("4".toJString()..deletedIn(arena)), false);
    });
  });
  testRunner('getRange', () {
    using((arena) {
      final list = newJList(arena);
      // ignore: iterable_contains_unrelated_type
      final range = list.getRange(1, 2)..deletedIn(arena);
      expect(range.length, 1);
      expect(range.first.toDartString(deleteOriginal: true), "2");
    });
  });
  testRunner('indexOf', () {
    using((arena) {
      final list = newJList(arena);
      expect(list.indexOf(1), -1);
      expect(list.indexOf("1".toJString()..toDartString()), 0);
      expect(list.indexOf("2".toJString()..toDartString()), 1);
      expect(list.indexOf("1".toJString()..toDartString(), 1), -1);
      expect(list.indexOf("1".toJString()..toDartString(), -1), 0);
    });
  });
  testRunner('insert', () {
    using((arena) {
      final list = newJList(arena);
      list.insert(1, "0".toJString()..deletedIn(arena));
      expect(list.length, 4);
      expect(list[1].toDartString(deleteOriginal: true), "0");
    });
  });
  testRunner('insertAll', () {
    using((arena) {
      final list = newJList(arena);
      final toInsert = newJList(arena);
      list.insertAll(1, toInsert);
      expect(list[1].toDartString(deleteOriginal: true), "1");
      expect(list.length, 6);
      list.insertAll(1, ["4".toJString()..deletedIn(arena)]);
      expect(list.length, 7);
      expect(list[1].toDartString(deleteOriginal: true), "4");
    });
  });
  testRunner('iterator', () {
    using((arena) {
      final list = newJList(arena);
      final it = list.iterator;
      expect(it.moveNext(), true);
      expect(it.current.toDartString(deleteOriginal: true), "1");
      expect(it.moveNext(), true);
      expect(it.current.toDartString(deleteOriginal: true), "2");
      expect(it.moveNext(), true);
      expect(it.current.toDartString(deleteOriginal: true), "3");
      expect(it.moveNext(), false);
    });
  });
  testRunner('remove', () {
    using((arena) {
      final list = newJList(arena);
      expect(list.remove("3".toJString()..deletedIn(arena)), true);
      expect(list.length, 2);
      expect(list.remove("4".toJString()..deletedIn(arena)), false);
      // ignore: list_remove_unrelated_type
      expect(list.remove(1), false);
    });
  });
  testRunner('removeAt', () {
    using((arena) {
      final list = newJList(arena);
      expect(list.removeAt(0).toDartString(deleteOriginal: true), "1");
      expect(list.removeAt(1).toDartString(deleteOriginal: true), "3");
    });
  });
  testRunner('removeRange', () {
    using((arena) {
      final list = newJList(arena);
      list.removeRange(0, 2);
      expect(list.single.toDartString(deleteOriginal: true), "3");
    });
  });
  testRunner('==, hashCode', () {
    using((arena) {
      final a = newJList(arena);
      final b = newJList(arena);
      expect(a.hashCode, b.hashCode);
      expect(a, b);
      b.add("4".toJString()..deletedIn(arena));
      expect(a.hashCode, isNot(b.hashCode));
      expect(a, isNot(b));
    });
  });
  testRunner('toSet', () {
    using((arena) {
      final list = newJList(arena);
      final set = list.toSet()..deletedIn(arena);
      expect(set.length, 3);
    });
  });
}
