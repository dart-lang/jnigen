import 'dart:io';

import 'package:path/path.dart';
import 'package:jni/jni.dart';
import 'dart:ffi';

import 'package:pdfbox_plugin/third_party/org/apache/pdfbox/pdmodel.dart';

void writeInfo(String file) {
  var jni = Jni.getInstance();

  var inputFile = jni
      .newInstance("java/io/FileInputStream", "(Ljava/lang/String;)V", [file]);
  var inputJl = JlObject.fromRef(inputFile.jobject);

  var pdDoc = PDDocument.load7(inputJl);
  int pages = pdDoc.getNumberOfPages();
  final info = pdDoc.getDocumentInformation();
  final title = info.getTitle();
  final subject = info.getSubject();
  final author = info.getAuthor();
  stderr.writeln('Number of pages: $pages');
  if (title.reference != nullptr) {
    stderr.writeln('Title: ${title.toDartString()}');
  }
  if (subject.reference != nullptr) {
    stderr.writeln('Subject: ${subject.toDartString()}');
  }
  if (author.reference != nullptr) {
    stderr.writeln('Author: ${author.toDartString()}');
  }
  stderr.writeln('PDF Version: ${pdDoc.getVersion()}');

  for (JlObject jr in [pdDoc, info, title, author, subject]) {
    jr.delete();
  }
  inputFile.delete();
}

final jniLibsDir = join('build', 'jni_libs');

const jarError =
'No JAR files were found.\n'
'Run `dart run jni_gen:download_maven_jars --config jnigen.yaml` '
'in plugin directory.\n'
'Alternatively, regenerate JNI bindings in plugin directory, which will '
'automatically download the JAR files.';

void main(List<String> arguments) {
  final jarDir = join('..', 'mvn_jar');
  List<String> jars;
  try {
    jars = Directory(jarDir)
        .listSync()
        .map((e) => e.path)
        .where((path) => path.endsWith('.jar'))
        .toList();
  } on OSError catch (_) {
    stderr.writeln(jarError);
    return;
  }
  if (jars.isEmpty) {
    stderr.writeln(jarError);
    return;
  }
  Jni.spawn(helperDir: jniLibsDir, classPath: jars);
  if (arguments.length != 1) {
    stderr.writeln('usage: dart run pdf_info:pdf_info <Path_to_PDF>');
    exitCode = 1;
    return;
  }
  writeInfo(arguments[0]);
}
