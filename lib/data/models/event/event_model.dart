import 'package:chamberlain/data/models/attendee/attendee_model.dart';
import 'package:chamberlain/data/models/event/event_source.dart';
import 'package:chamberlain/data/models/event_time/event_time_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    String? id,
    String? name,
    String? status,
    String? location,
    EventTimeModel? start,
    EventTimeModel? end,
    @JsonKey(unknownEnumValue: EventSource.calendar) EventSource? source,
    List<AttendeeModel>? attendees,
  }) = _EventModel;

  const EventModel._();

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);
}
