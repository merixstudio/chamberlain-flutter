part of 'pin_cubit.dart';

@freezed
class PinState with _$PinState {
  const PinState._();

  const factory PinState.inputs({
    required List<int> inputs,
  }) = _Inputs;
  const factory PinState.valid({
    required List<int> inputs,
  }) = _Valid;
  const factory PinState.failed({
    required List<int> inputs,
  }) = _Failed;

  bool get isValid => maybeWhen(
        valid: (_) => true,
        orElse: () => false,
      );

  bool get failed => maybeWhen(
        failed: (_) => true,
        orElse: () => false,
      );
}
