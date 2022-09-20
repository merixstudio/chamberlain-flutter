import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_time_model.freezed.dart';
part 'event_time_model.g.dart';

@freezed
class EventTimeModel with _$EventTimeModel {
  const factory EventTimeModel({
    String? dateTime,
    String? timeZone,
  }) = _EventTimeModel;

  const EventTimeModel._();

  factory EventTimeModel.fromJson(Map<String, dynamic> json) => _$EventTimeModelFromJson(json);
}
