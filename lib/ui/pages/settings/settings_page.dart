import 'package:auto_route/auto_route.dart';
import 'package:chamberlain/config/injector/di.dart';
import 'package:chamberlain/cubits/app_version/app_version_cubit.dart';
import 'package:chamberlain/cubits/kiosk_mode/kiosk_mode_cubit.dart';
import 'package:chamberlain/cubits/network_info/network_info_cubit.dart';
import 'package:chamberlain/cubits/room/room_cubit.dart';
import 'package:chamberlain/l10n/app_loc.dart';
import 'package:chamberlain/ui/modals/room_list_bottom_sheet/room_list_bottom_sheet_factory.dart';
import 'package:chamberlain/ui/models/room/room_view_model.dart';
import 'package:chamberlain/ui/pages/pin/cubit/pin_cubit.dart';
import 'package:chamberlain/ui/pages/pin/pin_page.dart';
import 'package:chamberlain/ui/pages/settings/widgets/settings_section_header.dart';
import 'package:chamberlain/ui/pages/settings/widgets/settings_select_cell.dart';
import 'package:chamberlain/ui/pages/settings/widgets/settings_switch_cell.dart';
import 'package:chamberlain/ui/pages/settings/widgets/settings_text_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget implements AutoRouteWrapper {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  static const String route = '/settings';

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DI.resolve<AppVersionCubit>()..load(),
        ),
        BlocProvider(
          create: (context) => DI.resolve<PinCubit>(),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isPinValid = context.watch<PinCubit>().state.isValid;
    return AnimatedSwitcher(
      duration: const Duration(
        milliseconds: 300,
      ),
      child: isPinValid ? _buildSettingsPage(context) : const PinPage(),
    );
  }

  Widget _buildSettingsPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLoc.of(context).settingsAppBarTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SettingsSectionHeader(
          title: AppLoc.of(context).settingsSecuritySectionTitle,
        ),
        const _KioskModeSwitch(),
        SettingsSectionHeader(
          title: AppLoc.of(context).settingsDeviceInformationSectionTitle,
        ),
        const _NetworkInfoCell(),
        const SizedBox(
          height: 8.0,
        ),
        SettingsSectionHeader(
          title: AppLoc.of(context).settingsAppInformationSectionTitle,
        ),
        const _AppVersionCell(),
        const SizedBox(
          height: 8.0,
        ),
        SettingsSectionHeader(
          title: AppLoc.of(context).settingsRoomSectionTitle,
        ),
        _RoomSelectCell(
          selectedRoom: context.watch<RoomCubit>().state.room,
          onPressed: () => RoomListBottomSheetFactory.show(
            context,
            selectedRoom: context.read<RoomCubit>().state.room,
            onRoomSelected: (room) => context.read<RoomCubit>().selectRoom(
                  room: room,
                ),
          ),
        ),
      ],
    );
  }
}

class _KioskModeSwitch extends StatelessWidget {
  const _KioskModeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsSwitchCell(
      title: AppLoc.of(context).settingsKioskModeSwitchCellTitle,
      value: context.watch<KioskModeCubit>().state.isEnabled,
      onChanged: (value) => context.read<KioskModeCubit>().changeMode(
            isEnabled: value,
          ),
    );
  }
}

class _NetworkInfoCell extends StatelessWidget {
  const _NetworkInfoCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsTextCell(
      title: AppLoc.of(context).settingsAddressIPTextCellTitle,
      value: context.watch<NetworkInfoCubit>().state.addressIP,
    );
  }
}

class _AppVersionCell extends StatelessWidget {
  const _AppVersionCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? appVersion = context.watch<AppVersionCubit>().state.version;
    return SettingsTextCell(
      title: AppLoc.of(context).settingsAppVersionTextCellTitle,
      value: appVersion,
    );
  }
}

class _RoomSelectCell extends StatelessWidget {
  const _RoomSelectCell({
    this.selectedRoom,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final RoomViewModel? selectedRoom;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SettingsSelectCell(
      title: AppLoc.of(context).settingsRoomSelectCellTitle,
      value: selectedRoom?.name ?? AppLoc.of(context).settingsRoomSelectNoDataCellTitle,
      onPressed: onPressed,
    );
  }
}
