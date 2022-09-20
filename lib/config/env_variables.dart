// ignore: avoid_classes_with_only_static_members
class EnvVariables {
  static String get flavor => const String.fromEnvironment('FLAVOR');
  static String get calendarId => const String.fromEnvironment('CALENDAR_ID');
  static bool get emulatorEnabled =>
      const bool.fromEnvironment('EMULATOR_ENABLED');
  static String get emulatorHost =>
      const String.fromEnvironment('EMULATOR_HOST');
  static String get pinCode => const String.fromEnvironment('PIN_CODE');
  static String get timeZone => const String.fromEnvironment('TIMEZONE');
  static bool get interactionFlavorDisabled =>
      const bool.fromEnvironment('INTERACTION_COUNTER_DISABLED');
}
