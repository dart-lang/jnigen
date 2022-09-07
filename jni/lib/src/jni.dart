import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart';

import 'third_party/jni_bindings_generated.dart';
import 'indir_extensions.dart';
import 'jvalues.dart';
import 'jni_exceptions.dart';
import 'jl_object.dart';

String _getLibraryFileName(String base) {
  if (Platform.isLinux || Platform.isAndroid) {
    return "lib$base.so";
  } else if (Platform.isWindows) {
    return "$base.dll";
  } else if (Platform.isMacOS) {
    return "$base.framework/$base";
  } else {
    throw UnsupportedError("cannot derive library name: unsupported platform");
  }
}

/// Load Dart-JNI Helper library.
///
/// If path is provided, it's used to load the library.
/// Else just the platform-specific filename is passed to DynamicLibrary.open
DynamicLibrary _loadDartJniLibrary({String? dir, String baseName = "dartjni"}) {
  final fileName = _getLibraryFileName(baseName);
  final libPath = (dir != null) ? join(dir, fileName) : fileName;
  try {
    final dylib = DynamicLibrary.open(libPath);
    return dylib;
  } on Error {
    throw HelperNotFoundException(libPath);
  }
}

/// Provides utilities to spawn and manage JNI.
abstract class Jni {
  static final DynamicLibrary _dylib = _loadDartJniLibrary(dir: _dylibDir);
  static final JniBindings _bindings = JniBindings(_dylib);
  static final _getJniEnvFn = _dylib.lookup<Void>('GetJniEnv');
  static final _getJniContextFn = _dylib.lookup<Void>('GetJniContext');

  // store dylibDir if any was used.
  static String? _dylibDir;

  /// Sets the directory where dynamic libraries are looked for.
  /// On dart standalone, call this in new isolate before doing
  /// any JNI operation.
  ///
  /// (The reason is that dylibs need to be loaded in every isolate.
  /// On flutter it's done by library. On dart standalone we don't
  /// know the library path.)
  static void setDylibDir({required String dylibDir}) {
    _dylibDir = dylibDir;
  }

  /// Spawn an instance of JVM using JNI. This method should be called at the
  /// beginning of the program with appropriate options, before other isolates
  /// are spawned.
  ///
  /// [dylibDir] is path of the directory where the wrapper library is found.
  /// This parameter needs to be passed manually on __Dart standalone target__,
  /// since we have no reliable way to bundle it with the package.
  ///
  /// [jvmOptions], [ignoreUnrecognized], & [jniVersion] are passed to the JVM.
  /// Strings in [classPath], if any, are used to construct an additional
  /// JVM option of the form "-Djava.class.path={paths}".
  static void spawn({
    String? dylibDir,
    List<String> jvmOptions = const [],
    List<String> classPath = const [],
    bool ignoreUnrecognized = false,
    int jniVersion = JNI_VERSION_1_6,
  }) {
    _dylibDir = dylibDir;
    final existVm = _bindings.GetJavaVM();
    if (existVm != nullptr) {
      throw JvmExistsException();
    }
    final jArgs = _createVMArgs(
      options: jvmOptions,
      classPath: classPath,
      version: jniVersion,
      ignoreUnrecognized: ignoreUnrecognized,
    );
    _bindings.SpawnJvm(jArgs);
    _freeVMArgs(jArgs);
  }

  /// Destroys the JVM associated with this process.
  static void destroyJvm() {
    final vm = _bindings.GetJavaVM();
    if (vm == nullptr) {
      throw StateError('No JVM exists to destroy');
    }
    final result = vm.DestroyJavaVM();
    if (result != JNI_OK) {
      throw StateError('DestroyJavaVM failed with error code $result');
    }
    // invalidate cached _indir.
    _indir = null;
  }

  static Pointer<JavaVMInitArgs> _createVMArgs({
    List<String> options = const [],
    List<String> classPath = const [],
    bool ignoreUnrecognized = false,
    int version = JNI_VERSION_1_6,
  }) {
    final args = calloc<JavaVMInitArgs>();
    if (options.isNotEmpty || classPath.isNotEmpty) {
      final count = options.length + (classPath.isNotEmpty ? 1 : 0);

      final optsPtr = (count != 0) ? calloc<JavaVMOption>(count) : nullptr;
      args.ref.options = optsPtr;
      for (int i = 0; i < options.length; i++) {
        optsPtr.elementAt(i).ref.optionString = options[i].toNativeChars();
      }
      if (classPath.isNotEmpty) {
        final classPathString = classPath.join(Platform.isWindows ? ';' : ":");
        optsPtr.elementAt(count - 1).ref.optionString =
            "-Djava.class.path=$classPathString".toNativeChars();
      }
      args.ref.nOptions = count;
    }
    args.ref.ignoreUnrecognized = ignoreUnrecognized ? 1 : 0;
    args.ref.version = version;
    return args;
  }

  static void _freeVMArgs(Pointer<JavaVMInitArgs> argPtr) {
    final nOptions = argPtr.ref.nOptions;
    final options = argPtr.ref.options;
    if (nOptions != 0) {
      for (var i = 0; i < nOptions; i++) {
        calloc.free(options.elementAt(i).ref.optionString);
      }
      calloc.free(argPtr.ref.options);
    }
    calloc.free(argPtr);
  }

  /// Returns pointer to current JNI JavaVM instance
  Pointer<JavaVM> getJavaVM() {
    return _bindings.GetJavaVM();
  }

  /// Returns the indirection instance, which is an abstraction over JNIEnv
  /// without the same-thread restriction.
  static Pointer<JniEnvIndir> _fetchIndir() {
    final indir = _bindings.GetIndir();
    if (indir == nullptr) {
      throw NoJvmInstanceException();
    }
    return indir;
  }

  static Pointer<JniEnvIndir>? _indir;

  /// Returns pointer to a process-wide shared instance of [Indir].
  ///
  /// [Indir] provides an indirection over [JniEnv] so that it can be used from
  /// any thread.
  static Pointer<JniEnvIndir> get indir {
    _indir ??= _fetchIndir();
    return _indir!;
  }

  /// Returns current application context on Android.
  static JObject getCachedApplicationContext() {
    return _bindings.GetApplicationContext();
  }

  /// Returns current activity
  static JObject getCurrentActivity() => _bindings.GetCurrentActivity();

  /// Get the initial classLoader of the application.
  ///
  /// This is especially useful on Android, where
  /// JNI threads cannot access application classes using
  /// the usual `JniEnv.FindClass` method.
  static JObject getApplicationClassLoader() => _bindings.GetClassLoader();

  /// Returns class reference found through system-specific mechanism
  static JClass findClass(String qualifiedName) {
    final nameChars = qualifiedName.toNativeChars();
    final cls = _bindings.LoadClass(nameChars);
    calloc.free(nameChars);
    if (cls == nullptr) {
      indir.checkException();
    }
    return cls;
  }

  /// Returns class for [qualifiedName] found by platform-specific mechanism,
  /// wrapped in a [JlClass].
  static JlClass findJlClass(String qualifiedName) =>
      JlClass.fromRef(findClass(qualifiedName));

  /// Constructs an instance of class with given args.
  ///
  /// Use it when you only need one instance, but not the actual class
  /// nor any constructor / static methods.
  static JlObject newInstance(
      String qualifiedName, String ctorSignature, List<dynamic> args) {
    final cls = findJlClass(qualifiedName);
    final ctor = cls.getCtorID(ctorSignature);
    final obj = cls.newObject(ctor, args);
    cls.delete();
    return obj;
  }

  /// Converts passed arguments to JValue array
  /// for use in methods that take arguments.
  ///
  /// int, bool, double and JObject types are converted out of the box.
  /// wrap values in types such as [JValueLong]
  /// to convert to other primitive types instead.
  static Pointer<JValue> jvalues(List<dynamic> args,
      {Allocator allocator = calloc}) {
    return toJValues(args, allocator: allocator);
  }

  static T retrieveStaticField<T>(
      String className, String fieldName, String signature,
      [int? callType]) {
    final cls = findJlClass(className);
    final result = cls.getStaticFieldByName<T>(fieldName, signature, callType);
    cls.delete();
    return result;
  }

  /// Calls static method identified by [methodName] and [signature]
  /// on [className] with [args] as and [callType].
  ///
  /// For more explanation on [args] and [callType], see [JlObject.getField]
  /// and [JlObject.callMethod] respectively.
  static T invokeStaticMethod<T>(
      String className, String methodName, String signature, List<dynamic> args,
      [int? callType]) {
    final cls = findJlClass(className);
    final result =
        cls.callStaticMethodByName<T>(methodName, signature, args, callType);
    cls.delete();
    return result;
  }

  /// Delete all references in [objects].
  static void deleteAll(List<JniReference> objects) {
    for (var object in objects) {
      object.delete();
    }
  }
}

typedef _SetJniGettersNativeType = Void Function(Pointer<Void>, Pointer<Void>);
typedef _SetJniGettersDartType = void Function(Pointer<Void>, Pointer<Void>);

/// Extensions for use by `jnigen` generated code.
extension ProtectedJniExtensions on Jni {
  static Pointer<T> Function<T extends NativeType>(String) initGeneratedLibrary(
      String name) {
    var path = _getLibraryFileName(name);
    if (Jni._dylibDir != null) {
      path = join(Jni._dylibDir!, path);
    }
    final dl = DynamicLibrary.open(path);
    final setJniGetters =
        dl.lookupFunction<_SetJniGettersNativeType, _SetJniGettersDartType>(
            'setJniGetters');
    setJniGetters(Jni._getJniContextFn, Jni._getJniEnvFn);
    final lookup = dl.lookup;
    return lookup;
  }

  /// Checks for and rethrows any pending exception in JNI as a [JniException].
  static void checkException() => Jni.indir.checkException();
}
