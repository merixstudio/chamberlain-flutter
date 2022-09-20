part of 'network_info_cubit.dart';

@freezed
class NetworkInfoState with _$NetworkInfoState {
  const NetworkInfoState._();

  const factory NetworkInfoState.initial() = _Initial;
  const factory NetworkInfoState.info({
    required String? addressIP,
  }) = _Info;

  String? get addressIP => mapOrNull<String?>(
        info: (state) => state.addressIP,
      );
}
