import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamberlain/cubits/current_time/current_time_cubit.dart';
import 'package:chamberlain/cubits/events/events_cubit.dart';
import 'package:chamberlain/ui/modals/new_event_dialog/event_period.dart';
import 'package:chamberlain/ui/models/event/event_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';

part 'events_status_state.dart';
part 'events_status_cubit.freezed.dart';

class EventsStatusCubit extends Cubit<EventsStatusState> {
  EventsStatusCubit({
    required CurrentTimeCubit currentTimeCubit,
    required EventsCubit eventsCubit,
  }) : super(
          const EventsStatusState.status(),
        ) {
    _currentTimeStreamSubscription = currentTimeCubit.stream.listen(
      (eventsState) => _calculateEventsStatus(
        events: eventsCubit.state.events,
      ),
    );
    _eventsStreamSubscription = eventsCubit.stream.listen(
      (eventsState) => eventsState.mapOrNull(
        success: (state) => _calculateEventsStatus(
          events: state.events,
        ),
      ),
    );

    _calculateEventsStatus(
      events: eventsCubit.state.events,
    );
  }

  StreamSubscription? _currentTimeStreamSubscription;
  StreamSubscription? _eventsStreamSubscription;

  @override
  Future<void> close() {
    _currentTimeStreamSubscription?.cancel();
    _eventsStreamSubscription?.cancel();
    return super.close();
  }

  Future<void> _calculateEventsStatus({
    required List<EventViewModel>? events,
  }) async {
    final EventViewModel? currentEvent = events?.firstWhereOrNull(
      (element) => element.onNow,
    );

    final List<EventViewModel>? nextEvents = events?.where(
      (element) {
        final DateTime currentDate = DateTime.now();
        return currentDate.isBefore(element.startTime);
      },
    ).toList();

    emit(
      EventsStatusState.status(
        currentEvent: currentEvent,
        freeIn: _calculateFreeIn(
          currentEvent: currentEvent,
          nextEvents: nextEvents,
        ),
        nextEvents: nextEvents,
        nextEventIn: _calculateNextEventIn(
          currentEvent: currentEvent,
          nextEvents: nextEvents,
        ),
      ),
    );
  }

  Duration? _calculateFreeIn({
    required EventViewModel? currentEvent,
    required List<EventViewModel>? nextEvents,
  }) {
    final EventViewModel? current = currentEvent;

    if (current != null) {
      DateTime sequenceEndTime = current.endTime;
      for (final EventViewModel nextEvent in nextEvents ?? []) {
        final bool nextEventStartsJustAfterPrevious =
            nextEvent.startTime.difference(sequenceEndTime).inMinutes < EventPeriod.minutes15().minutes;
        final bool nextEventStartsBeforePreviousEnds = nextEvent.startTime.isBefore(sequenceEndTime);
        if (nextEventStartsJustAfterPrevious || nextEventStartsBeforePreviousEnds) {
          sequenceEndTime = nextEvent.endTime;
        } else {
          break;
        }
      }

      return sequenceEndTime.difference(DateTime.now());
    } else {
      return Duration.zero;
    }
  }

  Duration? _calculateNextEventIn({
    required EventViewModel? currentEvent,
    required List<EventViewModel>? nextEvents,
  }) {
    final EventViewModel? current = currentEvent;
    final EventViewModel? next = nextEvents?.firstOrNull;
    if (next != null) {
      return next.startTime.difference(current?.endTime ?? DateTime.now());
    } else {
      return null;
    }
  }
}
