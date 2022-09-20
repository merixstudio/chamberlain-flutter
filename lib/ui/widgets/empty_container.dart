import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/config/styles/theme/extensions/chamberlain_general_style.dart';
import 'package:chamberlain/ui/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({
    required this.title,
    this.button,
    this.onButtonPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final String? button;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(context),
          if (button != null) ...[
            const SizedBox(
              height: 32.0,
            ),
            _buildButton(
              context,
              title: button!,
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.white,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String title,
  }) {
    return GradientButton(
      child: Text(
        title,
        style: Theme.of(context).extension<ChamberlainGeneralStyle>()?.gradientButtonTextStyle,
      ),
      onPressed: () => onButtonPressed?.call(),
    );
  }
}
