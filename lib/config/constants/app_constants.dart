class AppConstants {
  const AppConstants._();

  static const int minCalendarHour = 5;
  static const int maxCalendarHour = 22;
  static const int minNewEventPeriodInMinutes = 5;
  static const int numberOfHoursInCalendar =
      maxCalendarHour - minCalendarHour + 1;
  static const int defaultIdleTimeInSeconds = 30;
  static const String eventDateFormat = "yyyy-MM-dd'T'HH:mm:ss";
  static const String defaultEventName = 'Quick reservation';
  static const int maxTimeDifferenceToGroupEvents = 15;
}
