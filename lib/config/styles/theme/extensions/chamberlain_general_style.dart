import 'package:flutter/material.dart';

class ChamberlainGeneralStyle extends ThemeExtension<ChamberlainGeneralStyle> {
  const ChamberlainGeneralStyle({
    required this.accentGradient,
    required this.gradientButtonTextStyle,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });

  final Gradient accentGradient;
  final TextStyle? gradientButtonTextStyle;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  @override
  ThemeExtension<ChamberlainGeneralStyle> copyWith({
    Gradient? accentGradient,
    TextStyle? gradientButtonTextStyle,
    Color? primaryTextColor,
    Color? secondaryTextColor,
  }) =>
      ChamberlainGeneralStyle(
        accentGradient: accentGradient ?? this.accentGradient,
        gradientButtonTextStyle: gradientButtonTextStyle ?? this.gradientButtonTextStyle,
        primaryTextColor: primaryTextColor ?? this.primaryTextColor,
        secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      );

  @override
  ThemeExtension<ChamberlainGeneralStyle> lerp(ThemeExtension<ChamberlainGeneralStyle>? other, double t) {
    if (other is! ChamberlainGeneralStyle) {
      return this;
    }

    return ChamberlainGeneralStyle(
      accentGradient: Gradient.lerp(accentGradient, other.accentGradient, t) ?? accentGradient,
      gradientButtonTextStyle:
          TextStyle.lerp(gradientButtonTextStyle, other.gradientButtonTextStyle, t) ?? gradientButtonTextStyle,
      primaryTextColor: Color.lerp(primaryTextColor, other.primaryTextColor, t) ?? primaryTextColor,
      secondaryTextColor: Color.lerp(secondaryTextColor, other.secondaryTextColor, t) ?? secondaryTextColor,
    );
  }
}
