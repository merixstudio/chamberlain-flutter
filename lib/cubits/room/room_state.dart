part of 'room_cubit.dart';

@freezed
class RoomState with _$RoomState {
  const RoomState._();

  const factory RoomState.initial() = _Initial;
  const factory RoomState.notSelected() = _NotSelected;
  const factory RoomState.changed({
    required RoomViewModel room,
  }) = _Changed;
  const factory RoomState.loaded({
    required RoomViewModel room,
  }) = _Loaded;

  RoomViewModel? get room => mapOrNull(
        changed: (state) => state.room,
        loaded: (state) => state.room,
      );
}
