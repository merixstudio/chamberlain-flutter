import 'package:flutter/material.dart';
import 'package:chamberlain/config/injector/di.dart';
import 'package:chamberlain/config/router/app_router.dart';
import 'package:chamberlain/ui/pages/app/app_page.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      appRouter: DI.resolve<AppRouter>(),
    );
  }
}
