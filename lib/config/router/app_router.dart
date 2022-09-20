import 'package:auto_route/auto_route.dart';
import 'package:chamberlain/ui/pages/calendar/calendar_page.dart';
import 'package:chamberlain/ui/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:chamberlain/ui/pages/home/home_page.dart';

part 'app_router.gr.dart';

@AdaptiveAutoRouter(
  routes: [
    AutoRoute(
      page: HomePage,
      path: HomePage.route,
    ),
    AutoRoute(
      page: CalendarPage,
      path: CalendarPage.route,
    ),
    AutoRoute(
      page: SettingsPage,
      path: SettingsPage.route,
    ),
  ],
)
@Singleton()
class AppRouter extends _$AppRouter {}
