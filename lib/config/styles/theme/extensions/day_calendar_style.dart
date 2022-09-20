import 'package:flutter/material.dart';

class DayCalendarStyle extends ThemeExtension<DayCalendarStyle> {
  const DayCalendarStyle({
    required this.eventCellNameLabelTextStyle,
    required this.eventCellPeriodLabelTextStyle,
    required this.eventCellMembersReamingLabelTextStyle,
    required this.hourCellLabelTextStyle,
    required this.separatorLabelTextStyle,
  });

  final TextStyle? eventCellNameLabelTextStyle;
  final TextStyle? eventCellPeriodLabelTextStyle;
  final TextStyle? eventCellMembersReamingLabelTextStyle;
  final TextStyle? hourCellLabelTextStyle;
  final TextStyle? separatorLabelTextStyle;

  @override
  ThemeExtension<DayCalendarStyle> copyWith({
    TextStyle? eventCellNameLabelTextStyle,
    TextStyle? eventCellPeriodLabelTextStyle,
    TextStyle? eventCellMembersReamingLabelTextStyle,
    TextStyle? hourCellLabelTextStyle,
    TextStyle? separatorLabelTextStyle,
  }) =>
      DayCalendarStyle(
        eventCellNameLabelTextStyle: eventCellNameLabelTextStyle,
        eventCellPeriodLabelTextStyle: eventCellPeriodLabelTextStyle,
        eventCellMembersReamingLabelTextStyle: eventCellMembersReamingLabelTextStyle,
        hourCellLabelTextStyle: hourCellLabelTextStyle,
        separatorLabelTextStyle: separatorLabelTextStyle,
      );

  @override
  ThemeExtension<DayCalendarStyle> lerp(ThemeExtension<DayCalendarStyle>? other, double t) {
    if (other is! DayCalendarStyle) {
      return this;
    }

    return DayCalendarStyle(
      eventCellNameLabelTextStyle: TextStyle.lerp(eventCellNameLabelTextStyle, other.eventCellNameLabelTextStyle, t),
      eventCellPeriodLabelTextStyle:
          TextStyle.lerp(eventCellPeriodLabelTextStyle, other.eventCellPeriodLabelTextStyle, t),
      eventCellMembersReamingLabelTextStyle:
          TextStyle.lerp(eventCellMembersReamingLabelTextStyle, other.eventCellMembersReamingLabelTextStyle, t),
      hourCellLabelTextStyle: TextStyle.lerp(hourCellLabelTextStyle, other.hourCellLabelTextStyle, t),
      separatorLabelTextStyle: TextStyle.lerp(separatorLabelTextStyle, other.separatorLabelTextStyle, t),
    );
  }
}
