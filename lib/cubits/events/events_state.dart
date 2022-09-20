part of 'events_cubit.dart';

@freezed
class EventsState with _$EventsState {
  const EventsState._();

  const factory EventsState.initial() = _Initial;
  const factory EventsState.loading() = _Loading;
  const factory EventsState.success({
    required List<EventViewModel> events,
  }) = _Success;
  const factory EventsState.failure({
    required AppError appError,
  }) = _Failure;

  List<EventViewModel>? get events => mapOrNull<List<EventViewModel>?>(
        success: (state) => state.events,
      );
}
