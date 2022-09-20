import 'package:chamberlain/config/styles/theme/extensions/chamberlain_general_style.dart';
import 'package:chamberlain/l10n/app_loc.dart';
import 'package:chamberlain/ui/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class HomeBottomCancelButton extends StatelessWidget {
  const HomeBottomCancelButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(24.0),
      ),
      onPressed: onPressed,
      child: Text(
        AppLoc.of(context).homeCancelEventButton,
        style: Theme.of(context).extension<ChamberlainGeneralStyle>()?.gradientButtonTextStyle,
      ),
    );
  }
}
