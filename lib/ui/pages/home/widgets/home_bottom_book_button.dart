import 'package:chamberlain/config/styles/theme/extensions/home_page_style.dart';
import 'package:chamberlain/l10n/app_loc.dart';
import 'package:flutter/material.dart';

class HomeBottomBookButton extends StatelessWidget {
  const HomeBottomBookButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final HomePageStyle? homePageStyle = Theme.of(context).extension<HomePageStyle>();
    return TextButton(
      style: homePageStyle?.bottomButtonStyle,
      onPressed: onPressed,
      child: Center(
        child: Text(
          AppLoc.of(context).homeBookEventButton,
          style: homePageStyle?.bottomButton,
        ),
      ),
    );
  }
}
