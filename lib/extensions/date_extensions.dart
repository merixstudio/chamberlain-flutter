import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  DateTime beginningOfTheDay() {
    return DateTime(year, month, day);
  }

  DateTime endOfTheDay() {
    return DateTime(year, month, day, 23, 59, 59);
  }

  String hourFormatted() {
    return DateFormat(DateFormat.HOUR24_MINUTE).format(this);
  }
}
