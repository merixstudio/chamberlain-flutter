import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamberlain/cubits/current_time/current_time_cubit.dart';
import 'package:chamberlain/cubits/events/status/events_status_cubit.dart';
import 'package:chamberlain/data/storages/room_storage.dart';
import 'package:chamberlain/ui/modals/new_event_dialog/event_period.dart';
import 'package:chamberlain/ui/models/event/event_view_model.dart';
import 'package:chamberlain/ui/models/room/room_status.dart';
import 'package:chamberlain/ui/models/room/room_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';

part 'room_state.dart';
part 'room_cubit.freezed.dart';

@injectable
class RoomCubit extends Cubit<RoomState> {
  RoomCubit({
    required CurrentTimeCubit currentTimeCubit,
    required EventsStatusCubit eventsStatusCubit,
    required this.roomStorage,
  }) : super(const RoomState.initial()) {
    _currentTimeStreamSubscription = currentTimeCubit.stream.listen(
      (currentTimeState) => currentTimeState.mapOrNull(
        time: (state) => changeRoomStatus(
          currentEvent: eventsStatusCubit.state.currentEvent,
          nextEvent: eventsStatusCubit.state.nextEvent,
        ),
      ),
    );
    _eventsStatusStreamSubscription = eventsStatusCubit.stream.listen(
      (statusState) => changeRoomStatus(
        currentEvent: statusState.currentEvent,
        nextEvent: statusState.nextEvent,
      ),
    );
  }
  final RoomStorage roomStorage;
  StreamSubscription? _currentTimeStreamSubscription;
  StreamSubscription? _eventsStatusStreamSubscription;

  @override
  Future<void> close() {
    _currentTimeStreamSubscription?.cancel();
    _eventsStatusStreamSubscription?.cancel();
    return super.close();
  }

  Future<void> load({
    required List<RoomViewModel> rooms,
  }) async {
    final String? selectedId = await roomStorage.selectedRoomId;
    final RoomViewModel? selectedRoom = rooms.firstWhereOrNull(
      (room) => room.id == selectedId,
    );

    if (selectedRoom != null) {
      await selectRoom(
        room: selectedRoom,
      );
    } else {
      emit(
        const RoomState.notSelected(),
      );
    }
  }

  Future<void> selectRoom({
    required RoomViewModel room,
  }) async {
    await roomStorage.storeSelectedRoom(room);
    emit(
      RoomState.changed(
        room: room,
      ),
    );
    emit(
      RoomState.loaded(
        room: room,
      ),
    );
  }

  Future<void> changeRoomStatus({
    required EventViewModel? currentEvent,
    required EventViewModel? nextEvent,
  }) async {
    final RoomViewModel? room = state.room;
    if (room == null) {
      return;
    }
    final DateTime currentTime = DateTime.now();
    if (currentEvent == null) {
      //Check if next event starts in less or equal to max event period value
      if (nextEvent != null &&
          nextEvent.startTime.difference(currentTime).inMinutes <= EventPeriod.minutes60().minutes) {
        return emit(
          RoomState.loaded(
            room: room.copyWith(
              status: RoomStatus.soon,
            ),
          ),
        );
      }
      return emit(
        RoomState.loaded(
          room: room.copyWith(
            status: RoomStatus.free,
          ),
        ),
      );
    }
    if (currentEvent.endTime.isAfter(currentTime)) {
      emit(
        RoomState.loaded(
          room: room.copyWith(
            status: RoomStatus.busy,
          ),
        ),
      );
    }
  }
}
