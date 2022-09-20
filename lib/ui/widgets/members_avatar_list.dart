import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/theme/extensions/day_calendar_style.dart';
import 'package:chamberlain/ui/models/profile/profile_view_model.dart';
import 'package:chamberlain/ui/widgets/member_avatar.dart';
import 'package:flutter/material.dart';

class MembersAvatarList extends StatelessWidget {
  const MembersAvatarList({
    required this.members,
    Key? key,
  }) : super(key: key);

  final List<ProfileViewModel> members;

  final int _maxMembersShow = 3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.0,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final Widget cell;
          if (index == 3) {
            cell = _buildReamingIndicator(context);
          } else {
            cell = MemberAvatar(
              profile: members[index],
            );
          }
          return Transform.translate(
            offset: Offset(-6.0 * index, 0),
            child: cell,
          );
        },
        itemCount: members.length.clamp(0, _maxMembersShow + 1),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
    );
  }

  Widget _buildReamingIndicator(BuildContext context) {
    final int reamingMembers = members.length - _maxMembersShow;
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      width: 24.0,
      child: Text(
        '+${reamingMembers > 100 ? 99 : reamingMembers}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).extension<DayCalendarStyle>()?.eventCellMembersReamingLabelTextStyle,
      ),
    );
  }
}
