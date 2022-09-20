import 'package:chamberlain/data/storages/storage.dart';
import 'package:chamberlain/data/storages/storage_keys.dart';
import 'package:chamberlain/ui/models/room/room_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class RoomStorage {
  RoomStorage({
    required this.storage,
  });

  final Storage storage;

  Future<void> storeSelectedRoom(RoomViewModel room) async {
    await storage.putString(
      key: StorageKeys.selectedRoomId,
      value: room.id,
    );
  }

  Future<String?> get selectedRoomId => storage.getString(
        key: StorageKeys.selectedRoomId,
      );
}
