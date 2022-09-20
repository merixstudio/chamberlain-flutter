import 'package:flutter/material.dart';

class SettingsPageStyle extends ThemeExtension<SettingsPageStyle> {
  const SettingsPageStyle({
    required this.sectionHeaderTitleTextStyle,
    required this.cellTitleTextStyle,
    required this.cellTextValueTextStyle,
  });

  final TextStyle? sectionHeaderTitleTextStyle;
  final TextStyle? cellTitleTextStyle;
  final TextStyle? cellTextValueTextStyle;

  @override
  ThemeExtension<SettingsPageStyle> copyWith({
    TextStyle? sectionHeaderTitleTextStyle,
    TextStyle? cellTitleTextStyle,
    TextStyle? cellTextValueTextStyle,
  }) =>
      SettingsPageStyle(
        sectionHeaderTitleTextStyle: sectionHeaderTitleTextStyle,
        cellTitleTextStyle: cellTitleTextStyle,
        cellTextValueTextStyle: cellTextValueTextStyle,
      );

  @override
  ThemeExtension<SettingsPageStyle> lerp(ThemeExtension<SettingsPageStyle>? other, double t) {
    if (other is! SettingsPageStyle) {
      return this;
    }

    return SettingsPageStyle(
      sectionHeaderTitleTextStyle: TextStyle.lerp(sectionHeaderTitleTextStyle, other.sectionHeaderTitleTextStyle, t),
      cellTitleTextStyle: TextStyle.lerp(cellTitleTextStyle, other.cellTitleTextStyle, t),
      cellTextValueTextStyle: TextStyle.lerp(cellTextValueTextStyle, other.cellTextValueTextStyle, t),
    );
  }
}
