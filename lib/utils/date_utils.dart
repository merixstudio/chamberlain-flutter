import 'package:chamberlain/config/constants/app_constants.dart';
import 'package:intl/intl.dart';

class DateUtils {
  const DateUtils._();

  static DateTime parseDate(
    String? date, {
    String format = AppConstants.eventDateFormat,
  }) {
    return DateFormat(format).parse(date ?? '');
  }

  static String formatDefaultDate(DateTime dateTime) => DateFormat(AppConstants.eventDateFormat).format(dateTime);

  static DateTime dropSeconds(DateTime dateTime) => dateTime.subtract(
        Duration(
          seconds: dateTime.second,
        ),
      );
}
