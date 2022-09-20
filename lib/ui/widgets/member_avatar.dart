import 'package:cached_network_image/cached_network_image.dart';
import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/ui/models/profile/profile_view_model.dart';
import 'package:flutter/material.dart';

class MemberAvatar extends StatelessWidget {
  const MemberAvatar({
    required this.profile,
    Key? key,
  }) : super(key: key);

  final ProfileViewModel profile;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: profile.avatar.isNotEmpty ? CachedNetworkImageProvider(profile.avatar) : null,
      backgroundColor: AppColors.grey04,
      radius: 12.0,
      child: Center(
        child: Text(
          profile.initials,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
