import 'package:chamberlain/config/styles/theme/extensions/settings_page_style.dart';
import 'package:flutter/material.dart';

class SettingsSectionHeader extends StatelessWidget {
  const SettingsSectionHeader({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).extension<SettingsPageStyle>()?.sectionHeaderTitleTextStyle,
    );
  }
}
