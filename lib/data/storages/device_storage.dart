import 'package:chamberlain/data/storages/storage.dart';
import 'package:chamberlain/data/storages/storage_keys.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeviceStorage {
  DeviceStorage({
    required this.storage,
  });

  final Storage storage;

  Future<void> storeDeviceId(String deviceId) async {
    await storage.putString(
      key: StorageKeys.deviceId,
      value: deviceId,
    );
  }

  Future<String?> get deviceId => storage.getString(
        key: StorageKeys.deviceId,
      );
}
