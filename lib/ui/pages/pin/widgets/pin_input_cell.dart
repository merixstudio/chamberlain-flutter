import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';

class PinInputCell extends StatelessWidget {
  const PinInputCell({
    this.isError = false,
    this.isFilled = false,
    Key? key,
  }) : super(key: key);

  final bool isError;
  final bool isFilled;

  static const double _sizeOfFilledIndicator = 16.0;
  Color get _fillColor => isError ? AppColors.darkRed : AppColors.orangeDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isFilled ? _fillColor : AppColors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: isFilled ? _fillColor.withOpacity(0.2) : AppColors.black,
      ),
      margin: const EdgeInsets.all(8.0),
      child: Center(
        child: isFilled
            ? Container(
                decoration: BoxDecoration(
                  color: _fillColor,
                  shape: BoxShape.circle,
                ),
                height: _sizeOfFilledIndicator,
                width: _sizeOfFilledIndicator,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
