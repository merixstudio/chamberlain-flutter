import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chamberlain/ui/modals/alert_dialog/adaptive_alert_dialog_action.dart';
import 'package:chamberlain/utils/adaptive_widget_util.dart';

class AdaptiveAlertDialog extends StatelessWidget {
  const AdaptiveAlertDialog({
    required this.actions,
    required this.title,
    this.content,
    Key? key,
  }) : super(key: key);

  final List<AdaptiveAlertDialogAction> actions;
  final String? content;
  final String title;

  @override
  Widget build(BuildContext context) {
    final AdaptiveWidgetType adaptiveWidgetType = AdaptiveWidgetUtil.getWidgetTypeOf(
      context,
      platform: Platform.adaptive,
    );
    switch (adaptiveWidgetType) {
      case AdaptiveWidgetType.cupertino:
        return _buildCupertinoAlertDialog(context);
      case AdaptiveWidgetType.material:
      default:
        return _buildMaterialAlertDialog(context);
    }
  }

  Widget _buildCupertinoAlertDialog(
    BuildContext context,
  ) {
    return CupertinoAlertDialog(
      actions: actions,
      content: content?.isNotEmpty ?? false
          ? Padding(
              padding: const EdgeInsets.only(
                top: 2.0,
              ),
              child: Text(
                content!,
              ),
            )
          : null,
      title: Text(title),
    );
  }

  Widget _buildMaterialAlertDialog(BuildContext context) {
    return AlertDialog(
      actions: actions,
      content: content?.isNotEmpty ?? false
          ? Text(
              content!,
            )
          : null,
      title: Text(title),
    );
  }
}
