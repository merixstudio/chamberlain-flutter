import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chamberlain/data/errors/app_error.dart';
import 'package:chamberlain/ui/modals/alert_dialog/adaptive_alert_dialog.dart';
import 'package:chamberlain/ui/modals/alert_dialog/adaptive_alert_dialog_action.dart';
import 'package:chamberlain/utils/adaptive_widget_util.dart';

abstract class AdaptiveAlertDialogFactory {
  const AdaptiveAlertDialogFactory._();

  static void _showCupertinoDialog(
    BuildContext context, {
    required String title,
    required List<AdaptiveAlertDialogAction> actions,
    String? content,
    bool rootNavigator = true,
  }) {
    showCupertinoDialog(
      context: context,
      useRootNavigator: rootNavigator,
      builder: (_) => AdaptiveAlertDialog(
        actions: actions,
        content: content,
        title: title,
      ),
    );
  }

  static void _showDialog(
    BuildContext context, {
    required String title,
    required List<AdaptiveAlertDialogAction> actions,
    String? content,
    bool rootNavigator = false,
  }) {
    final AdaptiveWidgetType adaptiveWidgetType = AdaptiveWidgetUtil.getWidgetTypeOf(
      context,
      platform: Platform.adaptive,
    );
    switch (adaptiveWidgetType) {
      case AdaptiveWidgetType.cupertino:
        return _showCupertinoDialog(
          context,
          actions: actions,
          content: content,
          rootNavigator: rootNavigator,
          title: title,
        );
      case AdaptiveWidgetType.material:
      default:
        return _showMaterialDialog(
          context,
          actions: actions,
          content: content,
          rootNavigator: rootNavigator,
          title: title,
        );
    }
  }

  static void _showMaterialDialog(
    BuildContext context, {
    required List<AdaptiveAlertDialogAction> actions,
    required String title,
    String? content,
    bool rootNavigator = true,
  }) {
    showDialog(
      context: context,
      useRootNavigator: rootNavigator,
      builder: (_) => AdaptiveAlertDialog(
        actions: actions,
        content: content,
        title: title,
      ),
    );
  }

  // Generic dialogs
  static void showOKAlert(
    BuildContext context, {
    required String title,
    String? content,
    VoidCallback? onPressed,
    bool rootNavigator = true,
  }) {
    _showDialog(
      context,
      actions: <AdaptiveAlertDialogAction>[
        AdaptiveAlertDialogAction.adaptive(
          title: '', // AppLoc.of(context).ok,
          onPressed: onPressed ??
              () => Navigator.of(
                    context,
                    rootNavigator: rootNavigator,
                  ).pop(),
        ),
      ],
      content: content,
      rootNavigator: rootNavigator,
      title: title,
    );
  }

  static void showContentUnavailable(
    BuildContext context, {
    VoidCallback? onPressed,
    bool rootNavigator = true,
  }) {
    showOKAlert(
      context,
      content: '', // AppLoc.of(context).contentUnavailableAlertContent,
      onPressed: onPressed,
      rootNavigator: rootNavigator,
      title: '', // AppLoc.of(context).contentUnavailableAlertTitle,
    );
  }

  static void showError(
    BuildContext context, {
    required AppError appError,
    VoidCallback? onPressed,
    bool rootNavigator = true,
  }) {
    showOKAlert(
      context,
      content: appError.localizedMessage(context),
      onPressed: onPressed,
      rootNavigator: rootNavigator,
      title: appError.localizedTitle(context),
    );
  }
}
