import 'package:chamberlain/config/styles/theme/extensions/event_details_dialog_style.dart';
import 'package:chamberlain/ui/models/profile/profile_view_model.dart';
import 'package:chamberlain/ui/widgets/member_avatar.dart';
import 'package:flutter/material.dart';

class EventDetailsMemberRow extends StatelessWidget {
  const EventDetailsMemberRow({
    required this.profile,
    Key? key,
  }) : super(key: key);

  final ProfileViewModel profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: _buildFullNameLabel(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return MemberAvatar(
      profile: profile,
    );
  }

  Widget _buildFullNameLabel(BuildContext context) {
    return Text(
      profile.name,
      style: Theme.of(context).extension<EventDetailsDialogStyle>()?.memberCellFullNameTextStyle,
    );
  }
}
