import 'dart:math';

import 'package:chamberlain/config/constants/app_constants.dart';
import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/dimensions/app_dimensions.dart';
import 'package:chamberlain/config/styles/theme/extensions/day_calendar_style.dart';
import 'package:chamberlain/cubits/events/events_cubit.dart';
import 'package:chamberlain/cubits/current_time/current_time_cubit.dart';
import 'package:chamberlain/extensions/date_extensions.dart';
import 'package:chamberlain/extensions/list_extensions.dart';
import 'package:chamberlain/extensions/text_extensions.dart';
import 'package:chamberlain/ui/modals/new_event_dialog/event_period.dart';
import 'package:chamberlain/ui/models/event/event_view_model.dart';
import 'package:chamberlain/ui/widgets/members_avatar_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:collection/collection.dart';

part 'current_time_indicator.dart';
part 'event_cell.dart';
part 'hour_cell.dart';
part 'hours_list.dart';

class EventsCalendar extends StatefulWidget {
  const EventsCalendar({
    required this.currentTimeKey,
    this.onEventPressed,
    Key? key,
  }) : super(key: key);

  final GlobalKey currentTimeKey;
  final Function(EventViewModel event)? onEventPressed;

  static const double padding = 24.0;
  static const double eventsLeftPadding = 70.0;

  @override
  State<EventsCalendar> createState() => _EventsCalendarState();

  static double _getDistanceBetweenTopAndDate(DateTime dateTime) {
    const int numberOfMinsInHour = 60;
    const int numberOfHours = AppConstants.numberOfHoursInCalendar;
    const int numberOfHalfHourSeparators = numberOfHours;
    const double maxScrollHeight = (numberOfHours * _HourCell.height) + (numberOfHalfHourSeparators * 81.0);
    const double fullHourHeight = maxScrollHeight / numberOfHours;
    const double oneMinuteHeight = fullHourHeight / numberOfMinsInHour;
    const double offsetFromMinHour = AppConstants.minCalendarHour * fullHourHeight;
    const double offsetToHourCellDivider = (_HourCell.height / 2);
    final int minutesFromZeroToDateTimeStartingHour = (dateTime.hour * numberOfMinsInHour + dateTime.minute);

    return minutesFromZeroToDateTimeStartingHour * oneMinuteHeight + offsetToHourCellDivider - offsetFromMinHour;
  }
}

class _EventsCalendarState extends State<EventsCalendar> {
  @override
  Widget build(BuildContext context) {
    final List<EventViewModel>? events = context.watch<EventsCubit>().state.events;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: EventsCalendar.padding,
        top: EventsCalendar.padding,
        bottom: EventsCalendar.padding,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            const _HoursList(),
            if (events != null)
              ..._buildEventsList(
                events: events,
                maxWidth: constraints.maxWidth,
              ),
            _PositionedIndicator(
              key: widget.currentTimeKey,
            ),
          ],
        ),
      ),
    );
  }

  List<_PositionedEvent> _buildEventsList({
    required List<EventViewModel> events,
    required double maxWidth,
  }) {
    final Map<int, List<EventViewModel>> result = events.groupListsByCondition((previous, element) =>
        element.startTime.difference(previous?.startTime ?? element.startTime).inMinutes <=
        AppConstants.maxTimeDifferenceToGroupEvents);

    final double maxEventWidth = maxWidth - EventsCalendar.eventsLeftPadding - EventsCalendar.padding;

    final List<_PositionedEvent> eventsPositionedInGroups = result.entries
        .mapIndexed((index, entry) {
          final List<EventViewModel>? previousGroup = index > 0 ? result.values.elementAt(index - 1) : null;
          final DateTime? previousGroupEndTime = previousGroup?.last.endTime;
          final int eventsInGroup = entry.value.length;
          return entry.value
              .mapIndexed((index, event) => _PositionedEvent(
                    event: event,
                    additionalLeftPadding: index * (maxEventWidth / eventsInGroup),
                    onPressed: () => widget.onEventPressed?.call(event),
                    showBorder:
                        (eventsInGroup > 1 && index != 0) || (previousGroupEndTime?.isAfter(event.startTime) ?? false),
                  ))
              .toList();
        })
        .expand((element) => element)
        .toList();
    return eventsPositionedInGroups.map(
      (e) {
        final List<_PositionedEvent> eventsWithSameLeftPadding = eventsPositionedInGroups
            .where((element) => element.additionalLeftPadding == e.additionalLeftPadding)
            .where((element) => element.event.endTime.isAfter(e.event.startTime))
            .toList();

        return e.copyWith(
          margin: EdgeInsets.symmetric(
            horizontal: eventsWithSameLeftPadding.indexOf(e) * 4.0,
          ),
        );
      },
    ).toList();
  }
}

class _PositionedEvent extends StatelessWidget {
  const _PositionedEvent({
    required this.event,
    required this.onPressed,
    this.additionalLeftPadding = 0,
    this.margin,
    this.showBorder = false,
    Key? key,
  }) : super(key: key);

  final EventViewModel event;
  final double additionalLeftPadding;
  final EdgeInsets? margin;
  final VoidCallback onPressed;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final double height = EventsCalendar._getDistanceBetweenTopAndDate(event.endTime) -
        EventsCalendar._getDistanceBetweenTopAndDate(event.startTime);
    //Minimum height of event is same as 15 min event
    final double minHeight = EventsCalendar._getDistanceBetweenTopAndDate(
          event.endTime.add(EventPeriod.minutes15().duration),
        ) -
        EventsCalendar._getDistanceBetweenTopAndDate(event.endTime);
    return Positioned(
      top: EventsCalendar._getDistanceBetweenTopAndDate(event.startTime),
      left: EventsCalendar.eventsLeftPadding + additionalLeftPadding,
      right: EventsCalendar.padding,
      child: SizedBox(
        height: max(height, minHeight),
        child: _EventCell(
          event: event,
          margin: margin,
          onPressed: onPressed,
          showBorder: showBorder,
        ),
      ),
    );
  }

  _PositionedEvent copyWith({
    EdgeInsets? margin,
  }) {
    return _PositionedEvent(
      additionalLeftPadding: additionalLeftPadding,
      margin: margin ?? this.margin,
      event: event,
      onPressed: onPressed,
      showBorder: showBorder,
    );
  }
}

class _PositionedIndicator extends StatelessWidget {
  const _PositionedIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime currentTime = context.watch<CurrentTimeCubit>().state.currentTime;
    return Positioned(
      top: EventsCalendar._getDistanceBetweenTopAndDate(currentTime) - (_CurrentTimeIndicator.height / 2.0),
      left: 0.0,
      right: 10.0,
      child: const _CurrentTimeIndicator(),
    );
  }
}
