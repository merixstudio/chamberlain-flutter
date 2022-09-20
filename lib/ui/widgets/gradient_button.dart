import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/dimensions/app_dimensions.dart';
import 'package:chamberlain/config/styles/theme/extensions/chamberlain_general_style.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    required this.child,
    required this.onPressed,
    this.borderRadius,
    this.isEnabled = true,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final BorderRadius? borderRadius;
  final bool isEnabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius ?? AppDimensions.radius.bigRadius(),
      onTap: isEnabled ? onPressed : null,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? AppDimensions.radius.bigRadius(),
          color: isEnabled ? null : AppColors.grey01,
          gradient: isEnabled ? Theme.of(context).extension<ChamberlainGeneralStyle>()?.accentGradient : null,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
