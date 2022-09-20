import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/l10n/app_loc.dart';
import 'package:flutter/material.dart';

enum RoomStatus { free, soon, busy, unknown }

extension RoomStatusExtension on RoomStatus {
  String title(BuildContext context) {
    switch (this) {
      case RoomStatus.free:
        return AppLoc.of(context).roomStatusFree;
      case RoomStatus.soon:
        return AppLoc.of(context).roomStatusSoon;
      case RoomStatus.busy:
        return AppLoc.of(context).roomStatusBusy;
      case RoomStatus.unknown:
        return '-';
    }
  }

  Color get color {
    switch (this) {
      case RoomStatus.free:
        return AppColors.success;
      case RoomStatus.soon:
        return AppColors.orangeLight;
      case RoomStatus.busy:
      case RoomStatus.unknown:
        return AppColors.darkRed;
    }
  }

  IconData get icon {
    switch (this) {
      case RoomStatus.free:
      case RoomStatus.soon:
        return Icons.check_rounded;
      case RoomStatus.busy:
        return Icons.close_rounded;
      case RoomStatus.unknown:
        return Icons.question_mark_rounded;
    }
  }
}
