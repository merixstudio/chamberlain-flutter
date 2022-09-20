import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamberlain/data/errors/app_error.dart';
import 'package:chamberlain/data/repositories/rooms_repository.dart';
import 'package:chamberlain/ui/models/room/room_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';

part 'room_list_state.dart';
part 'room_list_cubit.freezed.dart';

@injectable
class RoomListCubit extends Cubit<RoomListState> {
  RoomListCubit({
    required this.roomsRepository,
  }) : super(const RoomListState.initial());

  final RoomsRepository roomsRepository;

  StreamSubscription? _roomsWatchSubscription;

  @override
  Future<void> close() {
    _roomsWatchSubscription?.cancel();
    return super.close();
  }

  Future<void> load() async {
    emit(
      const RoomListState.loading(),
    );

    _roomsWatchSubscription = roomsRepository.watchRooms().listen(
          (response) => response.result(
            onSuccess: (rooms) => emit(
              RoomListState.loaded(
                rooms: rooms
                    .map(
                      (room) => RoomViewModel.fromRoomModel(room),
                    )
                    .toList()
                    .sorted(
                      (a, b) => a.name.compareTo(b.name),
                    ),
              ),
            ),
            onError: (error) => emit(
              RoomListState.failure(
                error: error,
              ),
            ),
          ),
        );
  }
}
