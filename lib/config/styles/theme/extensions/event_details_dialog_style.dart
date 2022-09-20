import 'package:flutter/material.dart';

class EventDetailsDialogStyle extends ThemeExtension<EventDetailsDialogStyle> {
  const EventDetailsDialogStyle({
    required this.eventNameTextStyle,
    required this.eventDateTextStyle,
    required this.membersSectionTitleTextStyle,
    required this.memberCellFullNameTextStyle,
  });

  final TextStyle? eventNameTextStyle;
  final TextStyle? eventDateTextStyle;
  final TextStyle? membersSectionTitleTextStyle;
  final TextStyle? memberCellFullNameTextStyle;

  @override
  ThemeExtension<EventDetailsDialogStyle> copyWith({
    TextStyle? eventNameTextStyle,
    TextStyle? eventDateTextStyle,
    TextStyle? membersSectionTitleTextStyle,
    TextStyle? memberCellFullNameTextStyle,
  }) =>
      EventDetailsDialogStyle(
        eventNameTextStyle: eventNameTextStyle,
        eventDateTextStyle: eventDateTextStyle,
        membersSectionTitleTextStyle: membersSectionTitleTextStyle,
        memberCellFullNameTextStyle: memberCellFullNameTextStyle,
      );

  @override
  ThemeExtension<EventDetailsDialogStyle> lerp(ThemeExtension<EventDetailsDialogStyle>? other, double t) {
    if (other is! EventDetailsDialogStyle) {
      return this;
    }

    return EventDetailsDialogStyle(
      eventNameTextStyle: TextStyle.lerp(eventNameTextStyle, other.eventNameTextStyle, t),
      eventDateTextStyle: TextStyle.lerp(eventDateTextStyle, other.eventDateTextStyle, t),
      membersSectionTitleTextStyle: TextStyle.lerp(membersSectionTitleTextStyle, other.membersSectionTitleTextStyle, t),
      memberCellFullNameTextStyle: TextStyle.lerp(memberCellFullNameTextStyle, other.memberCellFullNameTextStyle, t),
    );
  }
}
