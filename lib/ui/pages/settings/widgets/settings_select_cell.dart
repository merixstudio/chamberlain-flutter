import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/theme/extensions/settings_page_style.dart';
import 'package:flutter/material.dart';

class SettingsSelectCell extends StatelessWidget {
  const SettingsSelectCell({
    required this.title,
    this.value,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final String? value;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildTitle(context),
            ),
            _buildValue(context),
            const SizedBox(
              width: 12.0,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.orangeLight,
              size: 20.0,
            )
          ],
        ),
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
