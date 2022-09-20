import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'app_version_state.dart';
part 'app_version_cubit.freezed.dart';

class AppVersionCubit extends Cubit<AppVersionState> {
  AppVersionCubit({
    required this.packageInfo,
  }) : super(const AppVersionState.initial());

  final PackageInfo packageInfo;

  void load() {
    String appVersion = packageInfo.version;
    if (Platform.isAndroid && appVersion.contains('-')) {
      appVersion = appVersion.split('-').first;
    }

    emit(
      AppVersionState.loaded(appVersion),
    );
  }
}
