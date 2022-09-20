import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  const Storage({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  Future<bool> putBool({
    required String key,
    required bool value,
  }) =>
      sharedPreferences.setBool(key, value);

  Future<bool?> getBool({
    required String key,
  }) async =>
      sharedPreferences.getBool(key);

  Future<bool> putString({
    required String key,
    required String value,
  }) =>
      sharedPreferences.setString(key, value);

  Future<String?> getString({
    required String key,
  }) async =>
      sharedPreferences.getString(key);

  Future<bool> putInt({
    required String key,
    required int value,
  }) =>
      sharedPreferences.setInt(key, value);

  Future<int?> getInt({
    required String key,
  }) async =>
      sharedPreferences.getInt(key);

  Future<bool> putDouble({
    required String key,
    required double value,
  }) =>
      sharedPreferences.setDouble(key, value);

  Future<double?> getDouble({
    required String key,
  }) async =>
      sharedPreferences.getDouble(key);

  Future<bool> remove({
    required String key,
  }) =>
      sharedPreferences.remove(key);
}
