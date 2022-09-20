part of 'events_calendar.dart';

class _CurrentTimeIndicator extends StatelessWidget {
  const _CurrentTimeIndicator({Key? key}) : super(key: key);

  static const double height = 5.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.orangeDark,
              boxShadow: [
                BoxShadow(
                  color: AppColors.orangeDark,
                  blurRadius: 8.0,
                ),
              ],
            ),
            height: 1.0,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.orangeDark,
            boxShadow: [
              BoxShadow(
                color: AppColors.orangeDark,
                blurRadius: 8.0,
              ),
            ],
            shape: BoxShape.circle,
          ),
          height: height,
          width: height,
        )
      ],
    );
  }
}
