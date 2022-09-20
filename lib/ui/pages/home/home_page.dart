import 'package:auto_route/auto_route.dart';
import 'package:chamberlain/config/injector/di.dart';
import 'package:chamberlain/config/styles/theme/extensions/home_page_style.dart';
import 'package:chamberlain/cubits/events/events_cubit.dart';
import 'package:chamberlain/cubits/events/create/create_event_cubit.dart';
import 'package:chamberlain/cubits/current_time/current_time_cubit.dart';
import 'package:chamberlain/cubits/events/status/events_status_cubit.dart';
import 'package:chamberlain/cubits/room/room_cubit.dart';
import 'package:chamberlain/extensions/duration_extensions.dart';
import 'package:chamberlain/l10n/app_loc.dart';
import 'package:chamberlain/ui/modals/alert_bottom_sheet/alert_bottom_sheet_factory.dart';
import 'package:chamberlain/ui/modals/new_event_dialog/new_event_dialog_factory.dart';
import 'package:chamberlain/ui/models/room/room_status.dart';
import 'package:chamberlain/ui/models/room/room_view_model.dart';
import 'package:chamberlain/ui/pages/calendar/calendar_page.dart';
import 'package:chamberlain/ui/pages/home/widgets/home_bottom_book_button.dart';
import 'package:chamberlain/ui/pages/home/widgets/home_bottom_cancel_button.dart';
import 'package:chamberlain/ui/pages/home/widgets/home_room_status_indicator.dart';
import 'package:chamberlain/ui/pages/settings/settings_page.dart';
import 'package:chamberlain/ui/widgets/empty_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const String route = '/home';

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => DI.resolve<CreateEventCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomState>(
      builder: (context, state) {
        final bool isRoomSelected = state.room != null;
        return Scaffold(
          body: SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: isRoomSelected ? () => AutoRouter.of(context).pushNamed(CalendarPage.route) : null,
              child: _buildBody(
                context,
                state: state,
              ),
            ),
          ),
          bottomNavigationBar: _BottomActionButton(
            room: state.room,
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required RoomState state,
  }) {
    return state.map(
      initial: (_) => const SizedBox.shrink(),
      notSelected: (_) => Center(
        child: EmptyContainer(
          title: AppLoc.of(context).homeInvalidRoomContainerTitle,
          button: AppLoc.of(context).homeInvalidRoomContainerButton,
          onButtonPressed: () => AutoRouter.of(context).pushNamed(SettingsPage.route),
        ),
      ),
      changed: (state) => _buildHomeBody(
        context,
        room: state.room,
      ),
      loaded: (state) => _buildHomeBody(
        context,
        room: state.room,
      ),
    );
  }

  Widget _buildHomeBody(
    BuildContext context, {
    required RoomViewModel room,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        const _CurrentTimeHeader(),
        const Spacer(
          flex: 5,
        ),
        _buildRoomSection(
          context,
          room: room,
        ),
        const Spacer(
          flex: 3,
        ),
        HomeRoomStatusIndicator(
          status: room.status,
        ),
        const Spacer(
          flex: 3,
        ),
        _buildAdditionalInfoSection(
          context,
          room: room,
        ),
        const Spacer(
          flex: 6,
        ),
      ],
    );
  }

  Widget _buildRoomSection(
    BuildContext context, {
    required RoomViewModel room,
  }) {
    return Column(
      children: [
        Text(
          room.name,
          style: Theme.of(context).extension<HomePageStyle>()?.roomNameStyle,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          room.status.title(context),
          style: Theme.of(context).extension<HomePageStyle>()?.roomStatusStyle,
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoSection(
    BuildContext context, {
    required RoomViewModel room,
  }) {
    //Refreshes each minute, when currentTime changes
    return BlocBuilder<CurrentTimeCubit, CurrentTimeState>(
      builder: (context, state) {
        final Duration? freeIn = context.watch<EventsStatusCubit>().state.freeIn;
        final Duration? nextBookIn = context.watch<EventsStatusCubit>().state.nextEventIn;
        if (room.status == RoomStatus.busy && freeIn != null) {
          return _buildFreeInSection(
            context,
            freeIn: freeIn,
          );
        } else if (nextBookIn != null) {
          return _buildNextBookInSection(
            context,
            nextIn: nextBookIn,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildFreeInSection(
    BuildContext context, {
    required Duration freeIn,
  }) {
    return Column(
      children: [
        Text(
          AppLoc.of(context).homeAdditionaInfoFreeIn,
          style: Theme.of(context).extension<HomePageStyle>()?.additionalInfoStyle,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          freeIn.readableFormat(context),
          style: Theme.of(context).extension<HomePageStyle>()?.additionalInfoTimeLeftStyle,
        ),
      ],
    );
  }

  Widget _buildNextBookInSection(
    BuildContext context, {
    required Duration nextIn,
  }) {
    return Column(
      children: [
        Text(
          AppLoc.of(context).homeAdditionaInfoNextMeetingIn,
          style: Theme.of(context).extension<HomePageStyle>()?.additionalInfoStyle,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          nextIn.readableFormat(context),
          style: Theme.of(context).extension<HomePageStyle>()?.additionalInfoTimeLeftStyle,
        ),
      ],
    );
  }
}

class _CurrentTimeHeader extends StatelessWidget {
  const _CurrentTimeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<CurrentTimeCubit>().state.currentHourMinutes,
      style: Theme.of(context).extension<HomePageStyle>()?.currentTimeStyle,
      textAlign: TextAlign.center,
    );
  }
}

class _BottomActionButton extends StatelessWidget {
  const _BottomActionButton({
    required this.room,
    Key? key,
  }) : super(key: key);

  final RoomViewModel? room;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsStatusCubit, EventsStatusState>(
      builder: (context, state) {
        if (room != null) {
          return IntrinsicHeight(
            child: room!.isBusy
                ? HomeBottomCancelButton(
                    onPressed: () => AlertBottomSheetFactory.showEventCancelEvent(
                      context,
                      onCancelEvent: () => context.read<EventsCubit>().cancelEvent(
                            event: state.currentEvent,
                          ),
                    ),
                  )
                : state.canCreateNewEvent
                    ? HomeBottomBookButton(
                        onPressed: () => NewEventDialogFactory.show(
                          context,
                          eventsCubit: context.read<EventsCubit>(),
                          onPeriodPressed: (period) => context.read<CreateEventCubit>().create(
                                eventPeriod: period,
                                location: room!.id,
                              ),
                        ),
                      )
                    : const SizedBox.shrink(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
