import 'package:chamberlain/config/styles/theme/extensions/chamberlain_general_style.dart';
import 'package:flutter/material.dart';

class GradientFloatingActionButton extends StatelessWidget {
  const GradientFloatingActionButton({
    required this.child,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Ink(
        height: 56.0,
        width: 56.0,
        decoration: BoxDecoration(
          gradient: Theme.of(context).extension<ChamberlainGeneralStyle>()?.accentGradient,
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
