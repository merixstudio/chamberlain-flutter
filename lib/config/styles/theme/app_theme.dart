import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/dimensions/app_dimensions.dart';
import 'package:chamberlain/config/styles/theme/extensions/event_details_dialog_style.dart';
import 'package:chamberlain/config/styles/theme/extensions/new_event_dialog_style.dart';
import 'package:chamberlain/config/styles/theme/extensions/day_calendar_style.dart';
import 'package:chamberlain/config/styles/theme/extensions/home_page_style.dart';
import 'package:chamberlain/config/styles/theme/extensions/chamberlain_general_style.dart';
import 'package:chamberlain/config/styles/theme/extensions/room_list_bottom_sheet_style.dart';
import 'package:chamberlain/config/styles/theme/extensions/settings_page_style.dart';
import 'package:flutter/material.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

enum ThemeType { light, dark }

class AppTheme {
  const AppTheme._(this.type);

  factory AppTheme.fromType(ThemeType type) => AppTheme._(type);

  final ThemeType type;

  ThemeData get themeData {
    switch (type) {
      case ThemeType.dark:
        return darkTheme;
      case ThemeType.light:
      default:
        return lightTheme;
    }
  }
}
