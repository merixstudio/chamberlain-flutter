import 'package:chamberlain/data/models/event/event_model.dart';
import 'package:chamberlain/data/models/event/event_source.dart';
import 'package:chamberlain/ui/modals/new_event_dialog/event_period.dart';
import 'package:chamberlain/ui/models/profile/profile_view_model.dart';
import 'package:chamberlain/utils/date_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'event_view_model.freezed.dart';

@freezed
class EventViewModel with _$EventViewModel {
  const factory EventViewModel({
    required String id,
    required String name,
    required DateTime startTime,
    required DateTime endTime,
    required List<ProfileViewModel> members,
    //Indicates if event is synchronized with online calendar
    required bool isSynchronized,
  }) = _EventViewModel;

  const EventViewModel._();

  Duration get duration => endTime.difference(startTime);

  bool get onNow {
    final DateTime currentDate = DateTime.now();
    return currentDate.isAfter(startTime) && currentDate.isBefore(endTime);
  }

  bool get is15MinsOrBelow => duration.inMinutes <= EventPeriod.minutes15().minutes;
  bool get is30MinsOrBelow => duration.inMinutes <= EventPeriod.minutes30().minutes;
  bool get is60MinsOrMore => duration.inMinutes >= EventPeriod.minutes60().minutes;

  String get fromToString =>
      '${DateFormat(DateFormat.HOUR24_MINUTE).format(startTime)} - ${DateFormat(DateFormat.HOUR24_MINUTE).format(endTime)}';

  static EventViewModel fromEventModel(EventModel eventModel) {
    return EventViewModel(
      id: eventModel.id ?? '',
      name: eventModel.name ?? '',
      startTime: DateUtils.parseDate(eventModel.start?.dateTime),
      endTime: DateUtils.parseDate(eventModel.end?.dateTime),
      members: ProfileViewModel.fromAttendeeModels(eventModel.attendees ?? []),
      isSynchronized: eventModel.source != EventSource.device,
    );
  }
}
