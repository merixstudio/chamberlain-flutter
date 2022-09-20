part of 'events_calendar.dart';

class _HourCell extends StatelessWidget {
  const _HourCell({
    required this.hour,
    Key? key,
  }) : super(key: key);

  final DateTime hour;

  static const double height = 19.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Text(
            hour.hourFormatted(),
            style: Theme.of(context).extension<DayCalendarStyle>()?.hourCellLabelTextStyle,
          ),
          const SizedBox(
            width: 12.0,
          ),
          const Expanded(
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
