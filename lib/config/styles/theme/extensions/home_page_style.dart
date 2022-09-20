import 'package:flutter/material.dart';

class HomePageStyle extends ThemeExtension<HomePageStyle> {
  const HomePageStyle({
    required this.currentTimeStyle,
    required this.roomNameStyle,
    required this.roomStatusStyle,
    required this.additionalInfoStyle,
    required this.additionalInfoTimeLeftStyle,
    required this.bottomButton,
    required this.bottomButtonStyle,
  });

  final TextStyle? currentTimeStyle;
  final TextStyle? roomNameStyle;
  final TextStyle? roomStatusStyle;
  final TextStyle? additionalInfoStyle;
  final TextStyle? additionalInfoTimeLeftStyle;
  final TextStyle? bottomButton;
  final ButtonStyle? bottomButtonStyle;

  @override
  ThemeExtension<HomePageStyle> copyWith({
    TextStyle? currentTimeStyle,
    TextStyle? roomNameStyle,
    TextStyle? roomStatusStyle,
    TextStyle? additionalInfoStyle,
    TextStyle? additionalInfoTimeLeftStyle,
    TextStyle? bookButton,
  }) =>
      HomePageStyle(
        currentTimeStyle: currentTimeStyle,
        roomNameStyle: roomNameStyle,
        roomStatusStyle: roomStatusStyle,
        additionalInfoStyle: additionalInfoStyle,
        additionalInfoTimeLeftStyle: additionalInfoTimeLeftStyle,
        bottomButton: bookButton,
        bottomButtonStyle: bottomButtonStyle,
      );

  @override
  ThemeExtension<HomePageStyle> lerp(ThemeExtension<HomePageStyle>? other, double t) {
    if (other is! HomePageStyle) {
      return this;
    }

    return HomePageStyle(
      currentTimeStyle: TextStyle.lerp(currentTimeStyle, other.currentTimeStyle, t),
      roomNameStyle: TextStyle.lerp(roomNameStyle, other.roomNameStyle, t),
      roomStatusStyle: TextStyle.lerp(roomStatusStyle, other.roomStatusStyle, t),
      additionalInfoStyle: TextStyle.lerp(additionalInfoStyle, other.additionalInfoStyle, t),
      additionalInfoTimeLeftStyle: TextStyle.lerp(additionalInfoTimeLeftStyle, other.additionalInfoTimeLeftStyle, t),
      bottomButton: TextStyle.lerp(bottomButton, other.bottomButton, t),
      bottomButtonStyle: ButtonStyle.lerp(bottomButtonStyle, other.bottomButtonStyle, t),
    );
  }
}
