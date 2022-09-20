import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendee_model.freezed.dart';
part 'attendee_model.g.dart';

@freezed
class AttendeeModel with _$AttendeeModel {
  const factory AttendeeModel({
    String? email,
    String? responseStatus,
    bool? resource,
  }) = _AttendeeModel;

  const AttendeeModel._();

  factory AttendeeModel.fromJson(Map<String, dynamic> json) => _$AttendeeModelFromJson(json);
}
