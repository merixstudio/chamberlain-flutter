import 'package:chamberlain/data/models/room/room_model.dart';
import 'package:chamberlain/ui/models/room/room_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_view_model.freezed.dart';

@freezed
class RoomViewModel with _$RoomViewModel {
  const factory RoomViewModel({
    required String name,
    required String id,
    required RoomStatus status,
  }) = _RoomViewModel;

  const RoomViewModel._();

  bool get isBusy => status == RoomStatus.busy;

  static RoomViewModel fromRoomModel(RoomModel roomModel) {
    return RoomViewModel(
      id: roomModel.id ?? '',
      name: roomModel.name ?? '',
      status: RoomStatus.unknown,
    );
  }
}
