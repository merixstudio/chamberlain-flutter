import 'package:chamberlain/ui/modals/event_details_dialog/event_details_dialog.dart';
import 'package:chamberlain/ui/models/event/event_view_model.dart';
import 'package:flutter/material.dart';

abstract class EventDetailsDialogFactory {
  static void show(
    BuildContext context, {
    required EventViewModel event,
    VoidCallback? onCancelEvent,
    bool useRootNavigator = false,
  }) {
    showDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      builder: (_) => EventDetailsDialog(
        event: event,
        onCancelEvent: () => onCancelEvent?.call(),
      ),
    );
  }
}
