part of 'room_list_cubit.dart';

@freezed
class RoomListState with _$RoomListState {
  const factory RoomListState.initial() = _Initial;
  const factory RoomListState.loading() = _Loading;
  const factory RoomListState.loaded({
    required List<RoomViewModel> rooms,
  }) = _Loaded;
  const factory RoomListState.failure({
    required AppError error,
  }) = _Failure;
}
