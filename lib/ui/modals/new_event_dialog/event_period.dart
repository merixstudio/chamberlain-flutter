import 'package:chamberlain/config/constants/app_constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_period.freezed.dart';

@freezed
class EventPeriod with _$EventPeriod {
  const EventPeriod._();
  factory EventPeriod.minutes15() = _Minutes15;
  factory EventPeriod.minutes30() = _Minutes30;
  factory EventPeriod.minutes45() = _Minutes45;
  factory EventPeriod.minutes60() = _Minutes60;
  factory EventPeriod.custom({
    required int minutes,
  }) = _Custom;

  int get minutes => map(
        minutes15: (_) => 15,
        minutes30: (_) => 30,
        minutes45: (_) => 45,
        minutes60: (_) => 60,
        custom: (customPeriod) => customPeriod.minutes,
      );

  Duration get duration => Duration(
        minutes: minutes,
      );

  static List<EventPeriod> get defaultPeriods => [
        _Minutes15(),
        _Minutes30(),
        _Minutes45(),
        _Minutes60(),
      ];

  static List<EventPeriod> findPeriods({
    required bool isEventInProgress,
    required Duration? availableTime,
  }) {
    if (isEventInProgress) {
      return [];
    }
    if (availableTime == null) {
      return EventPeriod.defaultPeriods;
    }
    List<EventPeriod> periods = EventPeriod.defaultPeriods
        .where(
          (element) => element.minutes <= availableTime.inMinutes,
        )
        .toList();
    if (availableTime.inMinutes >= AppConstants.minNewEventPeriodInMinutes &&
        periods.length < EventPeriod.defaultPeriods.length &&
        periods.where((element) => element.minutes == availableTime.inMinutes).isEmpty) {
      periods
        ..add(
          EventPeriod.custom(
            minutes: availableTime.inMinutes,
          ),
        )
        ..sort(
          (a, b) => a.minutes.compareTo(b.minutes),
        );
    }
    return periods;
  }
}
