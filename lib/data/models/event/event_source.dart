import 'package:json_annotation/json_annotation.dart';

enum EventSource {
  @JsonValue('device')
  device,
  @JsonValue('calendar')
  calendar,
}
