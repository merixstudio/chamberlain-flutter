part of 'device_info_cubit.dart';

@freezed
class DeviceInfoState with _$DeviceInfoState {
  const factory DeviceInfoState.initial() = _Initial;
  const factory DeviceInfoState.success() = _Success;
  const factory DeviceInfoState.failure({
    required AppError appError,
  }) = _Failure;
}
