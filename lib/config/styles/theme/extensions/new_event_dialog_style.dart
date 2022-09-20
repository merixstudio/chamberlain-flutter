import 'package:flutter/material.dart';

class NewEventDialogStyle extends ThemeExtension<NewEventDialogStyle> {
  const NewEventDialogStyle({
    required this.currentTimeLabelTextStyle,
    required this.timePeriodItemTextStyle,
    required this.selectedTimePeriodItemTextStyle,
  });

  final TextStyle? currentTimeLabelTextStyle;
  final TextStyle? timePeriodItemTextStyle;
  final TextStyle? selectedTimePeriodItemTextStyle;

  @override
  ThemeExtension<NewEventDialogStyle> copyWith({
    TextStyle? currentTimeLabelTextStyle,
    TextStyle? timePeriodItemTextStyle,
    TextStyle? selectedTimePeriodItemTextStyle,
    TextStyle? saveButtonLabelTextStyle,
  }) =>
      NewEventDialogStyle(
        currentTimeLabelTextStyle: currentTimeLabelTextStyle,
        timePeriodItemTextStyle: timePeriodItemTextStyle,
        selectedTimePeriodItemTextStyle: selectedTimePeriodItemTextStyle,
      );

  @override
  ThemeExtension<NewEventDialogStyle> lerp(ThemeExtension<NewEventDialogStyle>? other, double t) {
    if (other is! NewEventDialogStyle) {
      return this;
    }

    return NewEventDialogStyle(
      currentTimeLabelTextStyle: TextStyle.lerp(currentTimeLabelTextStyle, other.currentTimeLabelTextStyle, t),
      timePeriodItemTextStyle: TextStyle.lerp(timePeriodItemTextStyle, other.timePeriodItemTextStyle, t),
      selectedTimePeriodItemTextStyle:
          TextStyle.lerp(selectedTimePeriodItemTextStyle, other.selectedTimePeriodItemTextStyle, t),
    );
  }
}
