import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/theme/extensions/settings_page_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsSwitchCell extends StatelessWidget {
  const SettingsSwitchCell({
    required this.title,
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final String title;
  final bool value;
  final Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTitle(context),
          ),
          _buildSwitch(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).extension<SettingsPageStyle>()?.cellTitleTextStyle,
    );
  }

  Widget _buildSwitch(BuildContext context) {
    return CupertinoSwitch(
      activeColor: AppColors.orangeLight,
      value: value,
      onChanged: onChanged,
    );
  }
}
