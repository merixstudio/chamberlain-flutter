import 'package:auto_route/auto_route.dart';
import 'package:chamberlain/config/env_variables.dart';
import 'package:chamberlain/config/flavor_type.dart';
import 'package:chamberlain/config/injector/di.dart';
import 'package:chamberlain/cubits/device_info/device_info_cubit.dart';
import 'package:chamberlain/cubits/events/events_cubit.dart';
import 'package:chamberlain/cubits/current_time/current_time_cubit.dart';
import 'package:chamberlain/cubits/events/status/events_status_cubit.dart';
import 'package:chamberlain/cubits/interaction/interaction_cubit.dart';
import 'package:chamberlain/cubits/kiosk_mode/kiosk_mode_cubit.dart';
import 'package:chamberlain/cubits/network_info/network_info_cubit.dart';
import 'package:chamberlain/cubits/room/room_cubit.dart';
import 'package:chamberlain/cubits/room_list/room_list_cubit.dart';
import 'package:chamberlain/data/storages/room_storage.dart';
import 'package:chamberlain/ui/app_coordinator.dart';
import 'package:chamberlain/ui/widgets/interaction_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chamberlain/config/router/app_router.dart';
import 'package:chamberlain/config/styles/theme/app_theme.dart';

class AppPage extends StatefulWidget {
  const AppPage({
    required this.appRouter,
    Key? key,
  }) : super(key: key);

  final AppRouter appRouter;

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => DI.resolve<DeviceInfoCubit>()..synchronizeDeviceInfo(),
        ),
        BlocProvider(
          create: (_) => DI.resolve<CurrentTimeCubit>(),
        ),
        BlocProvider(
          create: (_) => DI.resolve<InteractionCubit>(),
        ),
        BlocProvider(
          create: (_) => DI.resolve<EventsCubit>(),
        ),
        BlocProvider(
          create: (context) => EventsStatusCubit(
            currentTimeCubit: context.read<CurrentTimeCubit>(),
            eventsCubit: context.read<EventsCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => RoomCubit(
              currentTimeCubit: context.read<CurrentTimeCubit>(),
              eventsStatusCubit: context.read<EventsStatusCubit>(),
              roomStorage: DI.resolve<RoomStorage>()),
        ),
        BlocProvider(
          lazy: false,
          create: (_) {
            final KioskModeCubit kioskModeCubit = DI.resolve<KioskModeCubit>()
              ..load();
            if (EnvVariables.flavor == FlavorType.prod.value) {
              kioskModeCubit.changeMode(
                isEnabled: true,
              );
            }
            return kioskModeCubit;
          },
        ),
        BlocProvider(
          create: (_) => DI.resolve<NetworkInfoCubit>()..load(),
        ),
        BlocProvider(
          create: (_) => DI.resolve<RoomListCubit>()..load(),
        ),
      ],
      child: AppCoordinator(
        appRouter: DI.resolve<AppRouter>(),
        child: InteractionDetector(
          onInteraction: (context) => EnvVariables.interactionFlavorDisabled
              ? null
              : context.read<InteractionCubit>().countdown(),
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerDelegate: widget.appRouter.delegate(
              initialRoutes: [
                _prepareInitialRoute(),
              ],
            ),
            routeInformationParser: widget.appRouter.defaultRouteParser(),
            theme: AppTheme.fromType(ThemeType.light).themeData,
          ),
        ),
      ),
    );
  }

  PageRouteInfo _prepareInitialRoute() {
    return const HomePageRoute();
  }
}
