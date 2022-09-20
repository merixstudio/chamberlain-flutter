import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  const SecureStorage({
    required this.flutterSecureStorage,
  });

  final FlutterSecureStorage flutterSecureStorage;

  Future<void> putString({
    required String key,
    required String value,
  }) =>
      flutterSecureStorage.write(
        key: key,
        value: value,
      );

  Future<String?> getString({
    required String key,
  }) =>
      flutterSecureStorage.read(
        key: key,
      );

  Future<void> remove({
    required String key,
  }) =>
      flutterSecureStorage.delete(
        key: key,
      );

  Future<void> removeAll() => flutterSecureStorage.deleteAll();
}
