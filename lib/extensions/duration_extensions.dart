import 'package:chamberlain/l10n/app_loc.dart';
import 'package:flutter/material.dart';

extension DurationExtensions on Duration {
  String readableFormat(BuildContext context) {
    if (inMinutes == 0 && inSeconds >= 0) {
      return AppLoc.of(context).durationLessThanMinute;
    } else if (inMinutes > 0 && inHours == 0) {
      return AppLoc.of(context).durationMinutes(inMinutes);
    }

    return '${inHours}h ${inMinutes.remainder(60)}min';
  }
}
