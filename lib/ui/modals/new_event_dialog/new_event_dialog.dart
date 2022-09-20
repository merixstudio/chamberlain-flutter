import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/dimensions/app_dimensions.dart';
import 'package:chamberlain/config/styles/theme/extensions/chamberlain_general_style.dart';
import 'package:chamberlain/config/styles/theme/extensions/new_event_dialog_style.dart';
import 'package:chamberlain/cubits/current_time/current_time_cubit.dart';
import 'package:chamberlain/cubits/events/status/events_status_cubit.dart';
import 'package:chamberlain/l10n/app_loc.dart';
import 'package:chamberlain/ui/modals/new_event_dialog/event_period.dart';
import 'package:chamberlain/ui/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class NewEventDialog extends StatefulWidget {
  const NewEventDialog({
    required this.onPeriodPressed,
    Key? key,
  }) : super(key: key);

  final Function(EventPeriod period) onPeriodPressed;

  @override
  State<NewEventDialog> createState() => _NewEventDialogState();
}

class _NewEventDialogState extends State<NewEventDialog> {
  EventPeriod _selectedPeriod = EventPeriod.minutes15();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentTimeCubit, CurrentTimeState>(
      listener: (context, state) {
        //Checks if selected event is still in range of available periods, if not
        //selects largest available
        final List<EventPeriod> availablePeriods = context.read<EventsStatusCubit>().state.availablePeriods;
        if (!availablePeriods.contains(_selectedPeriod)) {
          setState(() {
            final EventPeriod? lastAvailablePeriod = availablePeriods.lastOrNull;
            if (lastAvailablePeriod != null) {
              _selectedPeriod = lastAvailablePeriod;
            }
          });
        }
      },
      child: Dialog(
        backgroundColor: AppColors.white,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.radius.normalRadius(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<EventsStatusCubit, EventsStatusState>(
            builder: (context, state) => _buildBody(
              context,
              availablePeriods: state.availablePeriods,
              nextEventIn: state.nextEventIn,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required List<EventPeriod> availablePeriods,
    required Duration? nextEventIn,
  }) {
    final bool isAnyPeriodAvailable = availablePeriods.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCurrentTime(
          context,
          isAnyPeriodAvailable: isAnyPeriodAvailable,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Divider(
            color: AppColors.grey01,
            height: 1.0,
          ),
        ),
        _buildTimeActions(
          context,
          availablePeriods: availablePeriods,
          nextEventIn: nextEventIn,
        ),
        const SizedBox(
          height: 24.0,
        ),
        _buildSaveButton(
          context,
          isEnabled: isAnyPeriodAvailable,
        ),
      ],
    );
  }

  Widget _buildCurrentTime(
    BuildContext context, {
    required bool isAnyPeriodAvailable,
  }) {
    final DateTime currentTime = context.watch<CurrentTimeCubit>().state.currentTime;
    String timeString = DateFormat(DateFormat.HOUR24_MINUTE).format(currentTime);
    if (isAnyPeriodAvailable) {
      final DateTime endTime = currentTime.add(
        Duration(
          minutes: _selectedPeriod.minutes,
        ),
      );
      timeString += ' - ${DateFormat(DateFormat.HOUR24_MINUTE).format(endTime)}';
    }

    return Text(
      timeString,
      style: Theme.of(context).extension<NewEventDialogStyle>()?.currentTimeLabelTextStyle,
    );
  }

  Widget _buildTimeActions(
    BuildContext context, {
    required List<EventPeriod> availablePeriods,
    required Duration? nextEventIn,
  }) {
    final Set<EventPeriod> periods = EventPeriod.defaultPeriods.toSet()..addAll(availablePeriods);
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24.0,
        mainAxisSpacing: 16.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: periods
          .sorted((a, b) => a.minutes.compareTo(b.minutes))
          .map(
            (period) => _buildTimePeriodItem(
              context,
              availablePeriods: availablePeriods,
              period: period,
            ),
          )
          .take(4)
          .toList(),
    );
  }

  Widget _buildTimePeriodItem(
    BuildContext context, {
    required EventPeriod period,
    required List<EventPeriod> availablePeriods,
  }) {
    final bool isAvailable = availablePeriods.contains(period);
    final bool isSelected = period == _selectedPeriod && isAvailable;
    return IgnorePointer(
      ignoring: !isAvailable,
      child: Opacity(
        opacity: isAvailable ? 1.0 : 0.2,
        child: InkWell(
          borderRadius: AppDimensions.radius.smallRadius(),
          onTap: () => setState(
            () => _selectedPeriod = period,
          ),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: AppDimensions.radius.smallRadius(),
              color: isSelected ? AppColors.orangeDark : AppColors.black.withOpacity(0.02),
            ),
            child: Center(
              child: Text(
                '${period.minutes} min',
                style: isSelected
                    ? Theme.of(context).extension<NewEventDialogStyle>()?.selectedTimePeriodItemTextStyle
                    : Theme.of(context).extension<NewEventDialogStyle>()?.timePeriodItemTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(
    BuildContext context, {
    required bool isEnabled,
  }) {
    return GradientButton(
      isEnabled: isEnabled,
      onPressed: () => widget.onPeriodPressed(_selectedPeriod),
      child: Text(
        AppLoc.of(context).newEventDialogSaveButton,
        style: Theme.of(context).extension<ChamberlainGeneralStyle>()?.gradientButtonTextStyle,
      ),
    );
  }
}
