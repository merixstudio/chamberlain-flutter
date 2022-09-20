import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/theme/extensions/chamberlain_general_style.dart';
import 'package:flutter/material.dart';

class PinNumberCell extends StatelessWidget {
  const PinNumberCell({
    required this.number,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final int number;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.orangeLight,
      ),
      child: Text(
        number.toString(),
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Theme.of(context)
                  .extension<ChamberlainGeneralStyle>()
                  ?.primaryTextColor,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
