part of 'kiosk_mode_cubit.dart';

@freezed
class KioskModeState with _$KioskModeState {
  const KioskModeState._();

  const factory KioskModeState.enabled() = _Enabled;
  const factory KioskModeState.disabled() = _Disabled;

  bool get isEnabled => map(
        enabled: (_) => true,
        disabled: (_) => false,
      );
}
