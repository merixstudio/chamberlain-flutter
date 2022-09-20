part of 'events_status_cubit.dart';

@freezed
class EventsStatusState with _$EventsStatusState {
  const EventsStatusState._();

  const factory EventsStatusState.status({
    EventViewModel? currentEvent,
    Duration? freeIn,
    List<EventViewModel>? nextEvents,
    Duration? nextEventIn,
  }) = _Status;

  EventViewModel? get nextEvent => nextEvents?.firstOrNull;

  List<EventPeriod> get availablePeriods => EventPeriod.findPeriods(
        availableTime: nextEventIn,
        isEventInProgress: currentEvent != null,
      );

  bool get nextEventStartsAfterMinimumEventPeriod => availablePeriods.isNotEmpty;

  bool get canCreateNewEvent => nextEventStartsAfterMinimumEventPeriod && currentEvent == null;
}
