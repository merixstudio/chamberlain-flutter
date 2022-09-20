import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/dimensions/app_dimensions.dart';
import 'package:chamberlain/config/styles/theme/extensions/chamberlain_general_style.dart';
import 'package:chamberlain/l10n/app_loc.dart';
import 'package:chamberlain/ui/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class AlertBottomSheet extends StatelessWidget {
  const AlertBottomSheet({
    required this.title,
    this.secondaryButton,
    this.onSecondaryPressed,
    this.primaryButton,
    this.onPrimaryPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final String? secondaryButton;
  final VoidCallback? onSecondaryPressed;
  final String? primaryButton;
  final VoidCallback? onPrimaryPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(context),
          const SizedBox(
            height: 24.0,
          ),
          const Divider(
            color: AppColors.grey01,
            height: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: _buildActions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildSecondaryButton(context),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: _buildPrimaryButton(context),
        ),
      ],
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    final ChamberlainGeneralStyle? chamberlainGeneralStyle =
        Theme.of(context).extension();
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.radius.bigRadius(),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        foregroundColor: AppColors.orangeLight,
      ),
      child: Text(
        secondaryButton ??
            AppLoc.of(context).alertBottomSheetDefaultSecondaryButton,
        style: chamberlainGeneralStyle?.gradientButtonTextStyle?.copyWith(
          color: chamberlainGeneralStyle.secondaryTextColor,
        ),
      ),
      onPressed: () => onSecondaryPressed?.call(),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return GradientButton(
      child: Text(
        primaryButton ??
            AppLoc.of(context).alertBottomSheetDefaultPrimaryButton,
        style: Theme.of(context)
            .extension<ChamberlainGeneralStyle>()
            ?.gradientButtonTextStyle,
      ),
      onPressed: () => onPrimaryPressed?.call(),
    );
  }
}
