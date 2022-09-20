import 'package:chamberlain/cubits/current_time/current_time_cubit.dart';
import 'package:chamberlain/cubits/device_info/device_info_cubit.dart';
import 'package:chamberlain/cubits/events/events_cubit.dart';
import 'package:chamberlain/cubits/interaction/interaction_cubit.dart';
import 'package:chamberlain/cubits/room/room_cubit.dart';
import 'package:chamberlain/cubits/room_list/room_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:chamberlain/config/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//This class should add listeners to global cubits if
//there is need to use Global context (eg. show page after push notification)
class AppCoordinator extends StatelessWidget {
  const AppCoordinator({
    required this.appRouter,
    required this.child,
    Key? key,
  }) : super(key: key);

  final AppRouter appRouter;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        _noInteraction(),
        _currentTime(),
        _roomListListener(),
        _roomListener(),
      ],
      child: child,
    );
  }

  BlocListener _roomListListener() {
    return BlocListener<RoomListCubit, RoomListState>(
      listener: (context, state) => state.mapOrNull(
        // TODO: Handle Error
        loaded: (state) => context.read<RoomCubit>().load(
              rooms: state.rooms,
            ),
      ),
    );
  }

  BlocListener _roomListener() {
    return BlocListener<RoomCubit, RoomState>(
      listener: (context, state) => state.whenOrNull(
        changed: (room) => context
          ..read<EventsCubit>().load(
            location: room.id,
          )
          ..read<DeviceInfoCubit>().synchronizeDeviceInfo(),
      ),
    );
  }

  BlocListener _currentTime() {
    return BlocListener<CurrentTimeCubit, CurrentTimeState>(
      listener: (context, state) => state.mapOrNull(
        dayChanged: (_) => context.read<EventsCubit>().load(
              location: context.read<RoomCubit>().state.room?.id,
            ),
      ),
    );
  }

  BlocListener _noInteraction() {
    return BlocListener<InteractionCubit, InteractionState>(
      listener: (context, state) => state.whenOrNull(
        noInteraction: () => appRouter.popUntilRoot(),
      ),
    );
  }
}
