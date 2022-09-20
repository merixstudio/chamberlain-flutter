part of 'app_theme.dart';

const double _scale = 1.0;

TextTheme get _textTheme => const TextTheme(
      // Extra Large Title
      displayMedium: TextStyle(
        fontSize: 56.0 * _scale,
      ),
      // Large Title
      displaySmall: TextStyle(
        fontSize: 34.0 * _scale,
      ),
      // Title 1
      titleLarge: TextStyle(
        fontSize: 28.0 * _scale,
      ),
      // Title 2
      titleMedium: TextStyle(
        fontSize: 22.0 * _scale,
      ),
      // Title 3
      titleSmall: TextStyle(
        fontSize: 20.0 * _scale,
      ),
      // Headline
      bodyMedium: TextStyle(
        fontSize: 18.0 * _scale,
      ),
      // Body
      bodySmall: TextStyle(
        fontSize: 16.0 * _scale,
      ),
      // Subhead
      labelLarge: TextStyle(
        fontSize: 14.0 * _scale,
      ),
      // Caption
      labelMedium: TextStyle(
        fontSize: 12.0 * _scale,
      ),
      // Caption 2
      labelSmall: TextStyle(
        fontSize: 10.0 * _scale,
      ),
    );

ThemeData get lightTheme {
  return ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: AppColors.black,
      elevation: 0.0,
      titleTextStyle: _textTheme.bodyMedium?.copyWith(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: AppColors.grey01,
    ),
    backgroundColor: AppColors.black,
    buttonTheme: const ButtonThemeData(
      splashColor: AppColors.orangeLight,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      endIndent: 0.0,
      indent: 0.0,
      thickness: 1.0,
    ),
    extensions: [
      ChamberlainGeneralStyle(
        accentGradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.orangeLight,
            AppColors.orangeDark,
          ],
        ),
        gradientButtonTextStyle: _textTheme.labelLarge?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        primaryTextColor: AppColors.white,
        secondaryTextColor: AppColors.black,
      ),
      HomePageStyle(
        currentTimeStyle: _textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        roomNameStyle: _textTheme.bodyMedium?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
        roomStatusStyle: _textTheme.displayMedium?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
        ),
        additionalInfoStyle: _textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        additionalInfoTimeLeftStyle: _textTheme.titleLarge?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
        bottomButton: _textTheme.bodySmall?.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        bottomButtonStyle: TextButton.styleFrom(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimensions.radius.big),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          foregroundColor: AppColors.orangeLight,
        ),
      ),
      NewEventDialogStyle(
        currentTimeLabelTextStyle: _textTheme.titleSmall?.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        timePeriodItemTextStyle: _textTheme.titleSmall?.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
        selectedTimePeriodItemTextStyle: _textTheme.titleSmall?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      EventDetailsDialogStyle(
        eventNameTextStyle: _textTheme.titleSmall?.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w700,
        ),
        eventDateTextStyle: _textTheme.labelLarge?.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
        membersSectionTitleTextStyle: _textTheme.labelLarge?.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w700,
        ),
        memberCellFullNameTextStyle: _textTheme.bodySmall?.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      DayCalendarStyle(
        eventCellNameLabelTextStyle: _textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        eventCellPeriodLabelTextStyle: _textTheme.labelLarge?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
        eventCellMembersReamingLabelTextStyle: _textTheme.labelMedium?.copyWith(
          color: AppColors.trueBlack,
          fontWeight: FontWeight.bold,
        ),
        hourCellLabelTextStyle: _textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
        separatorLabelTextStyle: _textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      SettingsPageStyle(
        sectionHeaderTitleTextStyle: _textTheme.bodyMedium?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
        cellTitleTextStyle: _textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
        cellTextValueTextStyle: _textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      RoomListBottomSheetStyle(
        roomCellNameTextStyle: _textTheme.labelLarge?.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
        selectedRoomCellNameTextStyle: _textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
        roomCellButtonStyle: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          backgroundColor: AppColors.white,
          padding: const EdgeInsets.all(16.0),
          foregroundColor: AppColors.orangeLight,
        ),
        selectedRoomCellButtonStyle: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          backgroundColor: AppColors.orangeLight,
          padding: const EdgeInsets.all(16.0),
          foregroundColor: AppColors.orangeDark,
        ),
      ),
    ],
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 32.0,
      sizeConstraints: BoxConstraints.tight(const Size.square(56.0)),
    ),
    scaffoldBackgroundColor: AppColors.black,
    splashColor: AppColors.orangeLight,
    textTheme: _textTheme,
  );
}
