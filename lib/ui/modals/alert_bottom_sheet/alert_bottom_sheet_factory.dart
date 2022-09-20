import 'package:chamberlain/config/styles/dimensions/app_dimensions.dart';
import 'package:chamberlain/l10n/app_loc.dart';
import 'package:chamberlain/ui/modals/alert_bottom_sheet/alert_bottom_sheet.dart';
import 'package:flutter/material.dart';

abstract class AlertBottomSheetFactory {
  static void show(
    BuildContext context, {
    required String title,
    String? secondaryButton,
    VoidCallback? onSecondaryPressed,
    String? primaryButton,
    VoidCallback? onPrimaryPressed,
    bool useRootNavigator = false,
  }) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radius.big),
        ),
      ),
      useRootNavigator: useRootNavigator,
      builder: (context) => AlertBottomSheet(
        title: title,
        secondaryButton: secondaryButton,
        onSecondaryPressed: () {
          Navigator.of(context).pop();
          onSecondaryPressed?.call();
        },
        primaryButton: primaryButton,
        onPrimaryPressed: () {
          Navigator.of(context).pop();
          onPrimaryPressed?.call();
        },
      ),
    );
  }

  static void showEventCancelEvent(
    BuildContext context, {
    VoidCallback? onCancel,
    VoidCallback? onCancelEvent,
  }) {
    show(
      context,
      title: AppLoc.of(context).cancelEventAlertTitle,
      secondaryButton: AppLoc.of(context).cancelEventSecondaryButton,
      onSecondaryPressed: onCancel,
      primaryButton: AppLoc.of(context).cancelEventPrimaryButton,
      onPrimaryPressed: onCancelEvent,
    );
  }
}
