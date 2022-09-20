import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/utils/adaptive_widget_util.dart';

class AdaptiveAlertDialogAction extends StatelessWidget {
  const AdaptiveAlertDialogAction.adaptive({
    required this.title,
    this.onPressed,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final String title;

  @override
  Widget build(BuildContext context) {
    final AdaptiveWidgetType adaptiveWidgetType = AdaptiveWidgetUtil.getWidgetTypeOf(
      context,
      platform: Platform.adaptive,
    );
    switch (adaptiveWidgetType) {
      case AdaptiveWidgetType.cupertino:
        return _buildCupertinoDialogAction();
      case AdaptiveWidgetType.material:
      default:
        return _buildMaterialDialogAction();
    }
  }

  Widget _buildMaterialDialogAction() {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          AppColors.orangeLight,
        ),
      ),
      child: Text(
        title,
        style: textStyle ?? _defaultActionTextStyle(),
      ),
    );
  }

  Widget _buildCupertinoDialogAction() {
    return CupertinoDialogAction(
      onPressed: onPressed,
      child: Text(
        title,
        style: textStyle ?? _defaultActionTextStyle(),
      ),
    );
  }

  TextStyle _defaultActionTextStyle() {
    return const TextStyle(
      color: AppColors.black,
    );
  }
}
