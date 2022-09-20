import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/dimensions/app_dimensions.dart';
import 'package:chamberlain/ui/models/room/room_status.dart';
import 'package:flutter/material.dart';

class HomeRoomStatusIndicator extends StatelessWidget {
  const HomeRoomStatusIndicator({
    required this.status,
    Key? key,
  }) : super(key: key);

  final RoomStatus status;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.tight(
          const Size.square(148.0),
        ),
        decoration: BoxDecoration(
          borderRadius: AppDimensions.radius.normalRadius(),
          color: status.color,
        ),
        child: Icon(
          status.icon,
          color: AppColors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
