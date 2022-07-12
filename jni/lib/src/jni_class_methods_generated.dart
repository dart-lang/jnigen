// Autogenerated; DO NOT EDIT
// Generated by running the script in tool/gen_aux_methods.dart
part of 'jni_class.dart';

extension JniClassCallMethods on JniClass {
  /// Calls method pointed to by [methodID] with [args] as arguments
  String callStaticStringMethod(JMethodID methodID, List<dynamic> args) {
    _checkDeleted();
    final jvArgs = JValueArgs(args, _env);
    final result = _env.CallStaticObjectMethodA(_cls, methodID, jvArgs.values);
    _env.checkException();
    jvArgs.disposeIn(_env);
    calloc.free(jvArgs.values);
    final str = _env.asDartString(result);
    _env.DeleteLocalRef(result);
    return str;
  }

  /// Looks up method with [name] and [signature], calls it with [args] as arguments.
  /// If calling the same method multiple times, consider using [getStaticMethodID]
  /// and [callStaticStringMethod].
  String callStaticStringMethodByName(
      String name, String signature, List<dynamic> args) {
    final mID = getStaticMethodID(name, signature);
    final result = callStaticStringMethod(mID, args);
    return result;
  }

  /// Retrieves the value of the field denoted by [fieldID]
  String getStaticStringField(JFieldID fieldID) {
    _checkDeleted();
    final result = _env.GetStaticObjectField(_cls, fieldID);
    _env.checkException();
    final str = _env.asDartString(result);
    _env.DeleteLocalRef(result);
    return str;
  }

  /// Retrieve field of given [name] and [signature]
  String getStaticStringFieldByName(String name, String signature) {
    final fID = getStaticFieldID(name, signature);
    final result = getStaticStringField(fID);
    return result;
  }

  /// Calls method pointed to by [methodID] with [args] as arguments
  JniObject callStaticObjectMethod(JMethodID methodID, List<dynamic> args) {
    _checkDeleted();
    final jvArgs = JValueArgs(args, _env);
    final result = _env.CallStaticObjectMethodA(_cls, methodID, jvArgs.values);
    _env.checkException();
    jvArgs.disposeIn(_env);
    calloc.free(jvArgs.values);
    return JniObject.of(_env, result, nullptr);
  }

  /// Looks up method with [name] and [signature], calls it with [args] as arguments.
  /// If calling the same method multiple times, consider using [getStaticMethodID]
  /// and [callStaticObjectMethod].
  JniObject callStaticObjectMethodByName(
      String name, String signature, List<dynamic> args) {
    final mID = getStaticMethodID(name, signature);
    final result = callStaticObjectMethod(mID, args);
    return result;
  }

  /// Retrieves the value of the field denoted by [fieldID]
  JniObject getStaticObjectField(JFieldID fieldID) {
    _checkDeleted();
    final result = _env.GetStaticObjectField(_cls, fieldID);
    _env.checkException();
    return JniObject.of(_env, result, nullptr);
  }

  /// Retrieve field of given [name] and [signature]
  JniObject getStaticObjectFieldByName(String name, String signature) {
    final fID = getStaticFieldID(name, signature);
    final result = getStaticObjectField(fID);
    return result;
  }

  /// Calls method pointed to by [methodID] with [args] as arguments
  bool callStaticBooleanMethod(JMethodID methodID, List<dynamic> args) {
    _checkDeleted();
    final jvArgs = JValueArgs(args, _env);
    final result = _env.CallStaticBooleanMethodA(_cls, methodID, jvArgs.values);
    _env.checkException();
    jvArgs.disposeIn(_env);
    calloc.free(jvArgs.values);
    return result != 0;
  }

  /// Looks up method with [name] and [signature], calls it with [args] as arguments.
  /// If calling the same method multiple times, consider using [getStaticMethodID]
  /// and [callStaticBooleanMethod].
  bool callStaticBooleanMethodByName(
      String name, String signature, List<dynamic> args) {
    final mID = getStaticMethodID(name, signature);
    final result = callStaticBooleanMethod(mID, args);
    return result;
  }

  /// Retrieves the value of the field denoted by [fieldID]
  bool getStaticBooleanField(JFieldID fieldID) {
    _checkDeleted();
    final result = _env.GetStaticBooleanField(_cls, fieldID);
    _env.checkException();
    return result != 0;
  }

  /// Retrieve field of given [name] and [signature]
  bool getStaticBooleanFieldByName(String name, String signature) {
    final fID = getStaticFieldID(name, signature);
    final result = getStaticBooleanField(fID);
    return result;
  }

  /// Calls method pointed to by [methodID] with [args] as arguments
  int callStaticByteMethod(JMethodID methodID, List<dynamic> args) {
    _checkDeleted();
    final jvArgs = JValueArgs(args, _env);
    final result = _env.CallStaticByteMethodA(_cls, methodID, jvArgs.values);
    _env.checkException();
    jvArgs.disposeIn(_env);
    calloc.free(jvArgs.values);
    return result;
  }

  /// Looks up method with [name] and [signature], calls it with [args] as arguments.
  /// If calling the same method multiple times, consider using [getStaticMethodID]
  /// and [callStaticByteMethod].
  int callStaticByteMethodByName(
      String name, String signature, List<dynamic> args) {
    final mID = getStaticMethodID(name, signature);
    final result = callStaticByteMethod(mID, args);
    return result;
  }

  /// Retrieves the value of the field denoted by [fieldID]
  int getStaticByteField(JFieldID fieldID) {
    _checkDeleted();
    final result = _env.GetStaticByteField(_cls, fieldID);
    _env.checkException();
    return result;
  }

  /// Retrieve field of given [name] and [signature]
  int getStaticByteFieldByName(String name, String signature) {
    final fID = getStaticFieldID(name, signature);
    final result = getStaticByteField(fID);
    return result;
  }

  /// Calls method pointed to by [methodID] with [args] as arguments
  int callStaticCharMethod(JMethodID methodID, List<dynamic> args) {
    _checkDeleted();
    final jvArgs = JValueArgs(args, _env);
    final result = _env.CallStaticCharMethodA(_cls, methodID, jvArgs.values);
    _env.checkException();
    jvArgs.disposeIn(_env);
    calloc.free(jvArgs.values);
    return result;
  }

  /// Looks up method with [name] and [signature], calls it with [args] as arguments.
  /// If calling the same method multiple times, consider using [getStaticMethodID]
  /// and [callStaticCharMethod].
  int callStaticCharMethodByName(
      String name, String signature, List<dynamic> args) {
    final mID = getStaticMethodID(name, signature);
    final result = callStaticCharMethod(mID, args);
    return result;
  }

  /// Retrieves the value of the field denoted by [fieldID]
  int getStaticCharField(JFieldID fieldID) {
    _checkDeleted();
    final result = _env.GetStaticCharField(_cls, fieldID);
    _env.checkException();
    return result;
  }

  /// Retrieve field of given [name] and [signature]
  int getStaticCharFieldByName(String name, String signature) {
    final fID = getStaticFieldID(name, signature);
    final result = getStaticCharField(fID);
    return result;
  }

  /// Calls method pointed to by [methodID] with [args] as arguments
  int callStaticShortMethod(JMethodID methodID, List<dynamic> args) {
    _checkDeleted();
    final jvArgs = JValueArgs(args, _env);
    final result = _env.CallStaticShortMethodA(_cls, methodID, jvArgs.values);
    _env.checkException();
    jvArgs.disposeIn(_env);
    calloc.free(jvArgs.values);
    return result;
  }

  /// Looks up method with [name] and [signature], calls it with [args] as arguments.
  /// If calling the same method multiple times, consider using [getStaticMethodID]
  /// and [callStaticShortMethod].
  int callStaticShortMethodByName(
      String name, String signature, List<dynamic> args) {
    final mID = getStaticMethodID(name, signature);
    final result = callStaticShortMethod(mID, args);
    return result;
  }

  /// Retrieves the value of the field denoted by [fieldID]
  int getStaticShortField(JFieldID fieldID) {
    _checkDeleted();
    final result = _env.GetStaticShortField(_cls, fieldID);
    _env.checkException();
    return result;
  }

  /// Retrieve field of given [name] and [signature]
  int getStaticShortFieldByName(String name, String signature) {
    final fID = getStaticFieldID(name, signature);
    final result = getStaticShortField(fID);
    return result;
  }

  /// Calls method pointed to by [methodID] with [args] as arguments
  int callStaticIntMethod(JMethodID methodID, List<dynamic> args) {
    _checkDeleted();
    final jvArgs = JValueArgs(args, _env);
    final result = _env.CallStaticIntMethodA(_cls, methodID, jvArgs.values);
    _env.checkException();
    jvArgs.disposeIn(_env);
    calloc.free(jvArgs.values);
    return result;
  }

  /// Looks up method with [name] and [signature], calls it with [args] as arguments.
  /// If calling the same method multiple times, consider using [getStaticMethodID]
  /// and [callStaticIntMethod].
  int callStaticIntMethodByName(
      String name, String signature, List<dynamic> args) {
    final mID = getStaticMethodID(name, signature);
    final result = callStaticIntMethod(mID, args);
    return result;
  }

  /// Retrieves the value of the field denoted by [fieldID]
  int getStaticIntField(JFieldID fieldID) {
    _checkDeleted();
    final result = _env.GetStaticIntField(_cls, fieldID);
    _env.checkException();
    return result;
  }

  /// Retrieve field of given [name] and [signature]
  int getStaticIntFieldByName(String name, String signature) {
    final fID = getStaticFieldID(name, signature);
    final result = getStaticIntField(fID);
    return result;
  }

  /// Calls method pointed to by [methodID] with [args] as arguments
  int callStaticLongMethod(JMethodID methodID, List<dynamic> args) {
    _checkDeleted();
    final jvArgs = JValueArgs(args, _env);
    final result = _env.CallStaticLongMethodA(_cls, methodID, jvArgs.values);
    _env.checkException();
    jvArgs.disposeIn(_env);
    calloc.free(jvArgs.values);
    return result;
  }

  /// Looks up method with [name] and [signature], calls it with [args] as arguments.
  /// If calling the same method multiple times, consider using [getStaticMethodID]
  /// and [callStaticLongMethod].
  int callStaticLongMethodByName(
      String name, String signature, List<dynamic> args) {
    final mID = getStaticMethodID(name, signature);
    final result = callStaticLongMethod(mID, args);
    return result;
  }

  /// Retrieves the value of the field denoted by [fieldID]
  int getStaticLongField(JFieldID fieldID) {
    _checkDeleted();
    final result = _env.GetStaticLongField(_cls, fieldID);
    _env.checkException();
    return result;
  }

  /// Retrieve field of given [name] and [signature]
  int getStaticLongFieldByName(String name, String signature) {
    final fID = getStaticFieldID(name, signature);
    final result = getStaticLongField(fID);
    return result;
  }

  /// Calls method pointed to by [methodID] with [args] as arguments
  double callStaticFloatMethod(JMethodID methodID, List<dynamic> args) {
    _checkDeleted();
    final jvArgs = JValueArgs(args, _env);
    final result = _env.CallStaticFloatMethodA(_cls, methodID, jvArgs.values);
    _env.checkException();
    jvArgs.disposeIn(_env);
    calloc.free(jvArgs.values);
    return result;
  }

  /// Looks up method with [name] and [signature], calls it with [args] as arguments.
  /// If calling the same method multiple times, consider using [getStaticMethodID]
  /// and [callStaticFloatMethod].
  double callStaticFloatMethodByName(
      String name, String signature, List<dynamic> args) {
    final mID = getStaticMethodID(name, signature);
    final result = callStaticFloatMethod(mID, args);
    return result;
  }

  /// Retrieves the value of the field denoted by [fieldID]
  double getStaticFloatField(JFieldID fieldID) {
    _checkDeleted();
    final result = _env.GetStaticFloatField(_cls, fieldID);
    _env.checkException();
    return result;
  }

  /// Retrieve field of given [name] and [signature]
  double getStaticFloatFieldByName(String name, String signature) {
    final fID = getStaticFieldID(name, signature);
    final result = getStaticFloatField(fID);
    return result;
  }

  /// Calls method pointed to by [methodID] with [args] as arguments
  double callStaticDoubleMethod(JMethodID methodID, List<dynamic> args) {
    _checkDeleted();
    final jvArgs = JValueArgs(args, _env);
    final result = _env.CallStaticDoubleMethodA(_cls, methodID, jvArgs.values);
    _env.checkException();
    jvArgs.disposeIn(_env);
    calloc.free(jvArgs.values);
    return result;
  }

  /// Looks up method with [name] and [signature], calls it with [args] as arguments.
  /// If calling the same method multiple times, consider using [getStaticMethodID]
  /// and [callStaticDoubleMethod].
  double callStaticDoubleMethodByName(
      String name, String signature, List<dynamic> args) {
    final mID = getStaticMethodID(name, signature);
    final result = callStaticDoubleMethod(mID, args);
    return result;
  }

  /// Retrieves the value of the field denoted by [fieldID]
  double getStaticDoubleField(JFieldID fieldID) {
    _checkDeleted();
    final result = _env.GetStaticDoubleField(_cls, fieldID);
    _env.checkException();
    return result;
  }

  /// Retrieve field of given [name] and [signature]
  double getStaticDoubleFieldByName(String name, String signature) {
    final fID = getStaticFieldID(name, signature);
    final result = getStaticDoubleField(fID);
    return result;
  }

  /// Calls method pointed to by [methodID] with [args] as arguments
  void callStaticVoidMethod(JMethodID methodID, List<dynamic> args) {
    _checkDeleted();
    final jvArgs = JValueArgs(args, _env);
    final result = _env.CallStaticVoidMethodA(_cls, methodID, jvArgs.values);
    _env.checkException();
    jvArgs.disposeIn(_env);
    calloc.free(jvArgs.values);
    return result;
  }

  /// Looks up method with [name] and [signature], calls it with [args] as arguments.
  /// If calling the same method multiple times, consider using [getStaticMethodID]
  /// and [callStaticVoidMethod].
  void callStaticVoidMethodByName(
      String name, String signature, List<dynamic> args) {
    final mID = getStaticMethodID(name, signature);
    final result = callStaticVoidMethod(mID, args);
    return result;
  }
}
