import 'package:flutter/material.dart';

class RoomListBottomSheetStyle extends ThemeExtension<RoomListBottomSheetStyle> {
  const RoomListBottomSheetStyle({
    required this.roomCellNameTextStyle,
    required this.selectedRoomCellNameTextStyle,
    required this.roomCellButtonStyle,
    required this.selectedRoomCellButtonStyle,
  });

  final TextStyle? roomCellNameTextStyle;
  final TextStyle? selectedRoomCellNameTextStyle;
  final ButtonStyle? roomCellButtonStyle;
  final ButtonStyle? selectedRoomCellButtonStyle;

  @override
  ThemeExtension<RoomListBottomSheetStyle> copyWith({
    TextStyle? roomCellNameTextStyle,
    TextStyle? selectedRoomCellNameTextStyle,
    ButtonStyle? roomCellButtonStyle,
    ButtonStyle? selectedRoomCellButtonStyle,
  }) =>
      RoomListBottomSheetStyle(
        roomCellNameTextStyle: roomCellNameTextStyle,
        selectedRoomCellNameTextStyle: selectedRoomCellNameTextStyle,
        roomCellButtonStyle: roomCellButtonStyle,
        selectedRoomCellButtonStyle: selectedRoomCellButtonStyle,
      );

  @override
  ThemeExtension<RoomListBottomSheetStyle> lerp(ThemeExtension<RoomListBottomSheetStyle>? other, double t) {
    if (other is! RoomListBottomSheetStyle) {
      return this;
    }

    return RoomListBottomSheetStyle(
      roomCellNameTextStyle: TextStyle.lerp(roomCellNameTextStyle, other.roomCellNameTextStyle, t),
      selectedRoomCellNameTextStyle:
          TextStyle.lerp(selectedRoomCellNameTextStyle, other.selectedRoomCellNameTextStyle, t),
      roomCellButtonStyle: ButtonStyle.lerp(roomCellButtonStyle, other.roomCellButtonStyle, t),
      selectedRoomCellButtonStyle: ButtonStyle.lerp(selectedRoomCellButtonStyle, other.selectedRoomCellButtonStyle, t),
    );
  }
}
