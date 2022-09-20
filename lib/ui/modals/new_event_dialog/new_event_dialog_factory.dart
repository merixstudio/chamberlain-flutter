import 'package:chamberlain/cubits/events/events_cubit.dart';
import 'package:chamberlain/ui/modals/new_event_dialog/new_event_dialog.dart';
import 'package:chamberlain/ui/modals/new_event_dialog/event_period.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NewEventDialogFactory {
  static void show(
    BuildContext context, {
    required Function(EventPeriod period) onPeriodPressed,
    required EventsCubit eventsCubit,
    bool useRootNavigator = false,
  }) {
    showDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      builder: (_) => BlocProvider(
        create: (context) => eventsCubit,
        child: NewEventDialog(
          onPeriodPressed: (period) {
            Navigator.of(context).pop();
            onPeriodPressed(period);
          },
        ),
      ),
    );
  }
}
