part of 'current_time_cubit.dart';

@freezed
class CurrentTimeState with _$CurrentTimeState {
  const CurrentTimeState._();

  const factory CurrentTimeState.time({
    required DateTime currentTime,
  }) = _Time;

  const factory CurrentTimeState.dayChanged({
    required DateTime currentTime,
  }) = _DayChanged;

  String get currentHourMinutes => DateFormat(DateFormat.HOUR24_MINUTE).format(currentTime);
}
