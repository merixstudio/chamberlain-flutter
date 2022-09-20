import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamberlain/utils/kiosk_mode_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'kiosk_mode_state.dart';
part 'kiosk_mode_cubit.freezed.dart';

@injectable
class KioskModeCubit extends Cubit<KioskModeState> {
  KioskModeCubit({
    required this.kioskModeUtil,
  }) : super(
          const KioskModeState.disabled(),
        );

  final KioskModeUtil kioskModeUtil;
  StreamSubscription? _kioskModeStream;

  @override
  Future<void> close() {
    _kioskModeStream?.cancel();
    return super.close();
  }

  Future<void> load() async {
    final bool updatedStatus = await kioskModeUtil.isEnabled();

    emit(
      updatedStatus ? const KioskModeState.enabled() : const KioskModeState.disabled(),
    );
  }

  Future<void> changeMode({
    required bool isEnabled,
  }) async {
    if (isEnabled) {
      await kioskModeUtil.enable();
    } else {
      await kioskModeUtil.disable();
    }

    if (isEnabled) {
      _kioskModeStream = kioskModeUtil.watchStatus().listen((isEnabled) {
        if (isEnabled) {
          _kioskModeStream?.cancel();
        }
        load();
      });
    } else {
      return load();
    }
  }
}
