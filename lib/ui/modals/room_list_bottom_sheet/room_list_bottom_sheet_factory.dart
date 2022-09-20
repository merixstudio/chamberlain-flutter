import 'package:chamberlain/config/styles/dimensions/app_dimensions.dart';
import 'package:chamberlain/ui/modals/room_list_bottom_sheet/room_list_bottom_sheet.dart';
import 'package:chamberlain/ui/models/room/room_view_model.dart';
import 'package:flutter/material.dart';

abstract class RoomListBottomSheetFactory {
  static void show(
    BuildContext context, {
    RoomViewModel? selectedRoom,
    Function(RoomViewModel room)? onRoomSelected,
    bool useRootNavigator = false,
  }) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radius.big),
        ),
      ),
      useRootNavigator: useRootNavigator,
      builder: (_) => RoomListBottomSheet(
        selectedRoom: selectedRoom,
        onRoomSelected: (room) {
          Navigator.of(context).pop();
          onRoomSelected?.call(room);
        },
      ),
    );
  }
}
