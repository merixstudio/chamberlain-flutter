import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';

class PinIconCell extends StatelessWidget {
  const PinIconCell({
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.orangeLight,
      ),
      child: Icon(
        icon,
        color: AppColors.orangeDark,
      ),
    );
  }
}
