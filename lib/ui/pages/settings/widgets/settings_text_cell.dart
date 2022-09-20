import 'package:chamberlain/config/styles/theme/extensions/settings_page_style.dart';
import 'package:flutter/material.dart';

class SettingsTextCell extends StatelessWidget {
  const SettingsTextCell({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  final String title;
  final String? value;

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
          _buildValue(context),
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

  Widget _buildValue(BuildContext context) {
    return Text(
      value ?? '-',
      style: Theme.of(context).extension<SettingsPageStyle>()?.cellTextValueTextStyle,
    );
  }
}
