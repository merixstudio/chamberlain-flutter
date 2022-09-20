part of 'events_calendar.dart';

class _HoursList extends StatelessWidget {
  const _HoursList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        AppConstants.numberOfHoursInCalendar,
        (index) {
          final DateTime currentTime = DateTime.now();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HourCell(
                hour: _calculateHourTime(
                  currentTime: currentTime,
                  index: index,
                ),
              ),
              if (index != AppConstants.numberOfHoursInCalendar - 1) _buildSeparator(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40.0,
      ),
      child: Container(
        color: AppColors.grey01,
        height: 1.0,
        width: 8.0,
      ),
    );
  }

  DateTime _calculateHourTime({
    required DateTime currentTime,
    required int index,
  }) {
    return currentTime
        .subtract(
          Duration(
            hours: currentTime.hour,
            minutes: currentTime.minute,
            seconds: currentTime.second,
          ),
        )
        .add(
          Duration(
            hours: index + AppConstants.minCalendarHour,
          ),
        );
  }
}
