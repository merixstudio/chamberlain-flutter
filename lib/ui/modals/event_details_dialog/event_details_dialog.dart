import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/dimensions/app_dimensions.dart';
import 'package:chamberlain/config/styles/theme/extensions/chamberlain_general_style.dart';
import 'package:chamberlain/config/styles/theme/extensions/event_details_dialog_style.dart';
import 'package:chamberlain/l10n/app_loc.dart';
import 'package:chamberlain/ui/modals/event_details_dialog/widgets/event_details_member_row.dart';
import 'package:chamberlain/ui/models/event/event_view_model.dart';
import 'package:chamberlain/ui/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsDialog extends StatelessWidget {
  const EventDetailsDialog({
    required this.event,
    required this.onCancelEvent,
    Key? key,
  }) : super(key: key);

  final EventViewModel event;
  final VoidCallback onCancelEvent;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: const EdgeInsets.all(24.0),
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.radius.normalRadius(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8.0,
        ),
        _buildHeader(context),
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Divider(
            color: AppColors.grey01,
            height: 1.0,
          ),
        ),
        Flexible(
          child: _buildMembersSection(context),
        ),
        if (event.onNow) _buildCancelButton(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.name,
          style: Theme.of(context).extension<EventDetailsDialogStyle>()?.eventNameTextStyle,
        ),
        const SizedBox(
          height: 12.0,
        ),
        Text(
          AppLoc.of(context).eventDetailsDialogDate(
            DateFormat('EEEE, dd MMMM yyyy').format(event.startTime),
            DateFormat('HH:mm').format(event.startTime),
            DateFormat('HH:mm').format(event.endTime),
          ),
          style: Theme.of(context).extension<EventDetailsDialogStyle>()?.eventDateTextStyle,
        ),
      ],
    );
  }

  Widget _buildMembersSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLoc.of(context).eventDetailsDialogMembersSectionTitle(event.members.length),
          style: Theme.of(context).extension<EventDetailsDialogStyle>()?.membersSectionTitleTextStyle,
        ),
        const SizedBox(
          height: 8.0,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height / 3,
          ),
          child: Scrollbar(
            child: ListView.builder(
              itemCount: event.members.length,
              itemBuilder: (context, index) => EventDetailsMemberRow(
                profile: event.members[index],
              ),
              shrinkWrap: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: GradientButton(
        onPressed: onCancelEvent,
        child: Text(
          AppLoc.of(context).eventDetailsDialogCancelButton,
          style: Theme.of(context).extension<ChamberlainGeneralStyle>()?.gradientButtonTextStyle,
        ),
      ),
    );
  }
}
