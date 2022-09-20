import 'package:auto_route/auto_route.dart';
import 'package:chamberlain/config/injector/di.dart';
import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/cubits/events/events_cubit.dart';
import 'package:chamberlain/cubits/events/status/events_status_cubit.dart';
import 'package:chamberlain/cubits/room/room_cubit.dart';
import 'package:chamberlain/cubits/events/create/create_event_cubit.dart';
import 'package:chamberlain/ui/modals/alert_bottom_sheet/alert_bottom_sheet_factory.dart';
import 'package:chamberlain/ui/modals/event_details_dialog/event_details_dialog_factory.dart';
import 'package:chamberlain/ui/modals/new_event_dialog/new_event_dialog_factory.dart';
import 'package:chamberlain/ui/pages/calendar/widgets/events_calendar.dart';
import 'package:chamberlain/ui/pages/settings/settings_page.dart';
import 'package:chamberlain/ui/widgets/gradient_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarPage extends StatefulWidget implements AutoRouteWrapper {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  static const String route = '/calendar';

  @override
  State<CalendarPage> createState() => _CalendarPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => DI.resolve<CreateEventCubit>(),
      child: this,
    );
  }
}

class _CalendarPageState extends State<CalendarPage> {
  final GlobalKey _currentTimeIndicatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final BuildContext? indicatorContext = _currentTimeIndicatorKey.currentContext;
      if (indicatorContext != null) {
        Scrollable.ensureVisible(
          indicatorContext,
          alignment: 0.5,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _RoomNameAppBar(
        onSettingsPressed: () => AutoRouter.of(context).pushNamed(SettingsPage.route),
      ),
      body: SafeArea(
        child: _buildEventsCalendar(context),
      ),
      floatingActionButton: const _AddEventFloatingButton(),
    );
  }

  Widget _buildEventsCalendar(BuildContext context) {
    return EventsCalendar(
      currentTimeKey: _currentTimeIndicatorKey,
      onEventPressed: (event) => EventDetailsDialogFactory.show(
        context,
        event: event,
        onCancelEvent: () => AlertBottomSheetFactory.showEventCancelEvent(
          context,
          onCancelEvent: () {
            //Close EventDetailsDialog
            Navigator.of(context).pop();
            context.read<EventsCubit>().cancelEvent(
                  event: event,
                );
          },
        ),
      ),
    );
  }
}

class _RoomNameAppBar extends StatelessWidget with PreferredSizeWidget {
  const _RoomNameAppBar({
    required this.onSettingsPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onSettingsPressed;

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    final String name = context.watch<RoomCubit>().state.room?.name ?? '';

    return GestureDetector(
      onDoubleTap: onSettingsPressed,
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          name,
        ),
      ),
    );
  }
}

class _AddEventFloatingButton extends StatelessWidget {
  const _AddEventFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsStatusCubit, EventsStatusState>(
      builder: (context, state) {
        if (state.canCreateNewEvent) {
          return GradientFloatingActionButton(
            onPressed: () => NewEventDialogFactory.show(
              context,
              eventsCubit: context.read<EventsCubit>(),
              onPeriodPressed: (period) => context.read<CreateEventCubit>().create(
                    eventPeriod: period,
                    location: context.read<RoomCubit>().state.room?.id,
                  ),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.white,
              size: 32.0,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
