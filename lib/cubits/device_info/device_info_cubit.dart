import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamberlain/data/errors/app_error.dart';
import 'package:chamberlain/data/models/device/device_model.dart';
import 'package:chamberlain/data/repositories/device_repository.dart';
import 'package:chamberlain/data/responses/response_status.dart';
import 'package:chamberlain/data/storages/device_storage.dart';
import 'package:chamberlain/data/storages/room_storage.dart';
import 'package:chamberlain/utils/network_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'device_info_state.dart';
part 'device_info_cubit.freezed.dart';

@injectable
class DeviceInfoCubit extends Cubit<DeviceInfoState> {
  DeviceInfoCubit({
    required this.devicesRepository,
    required this.networkUtil,
    required this.deviceStorage,
    required this.roomStorage,
    required this.packageInfo,
  }) : super(const DeviceInfoState.initial());

  final DevicesRepository devicesRepository;
  final NetworkUtil networkUtil;
  final PackageInfo packageInfo;
  final DeviceStorage deviceStorage;
  final RoomStorage roomStorage;

  Future<void> synchronizeDeviceInfo() async {
    final String? roomId = await roomStorage.selectedRoomId;
    final String? deviceId = await deviceStorage.deviceId;
    final String versionName = packageInfo.version;
    final String versionCode = packageInfo.buildNumber;
    final Map<String, String> deviceIPs = await networkUtil.adressIPs();
    await _updateDeviceModel(
      DeviceModel(
        id: deviceId,
        ips: deviceIPs,
        roomId: roomId,
        versionName: versionName,
        versionCode: versionCode,
      ),
    );
  }

  Future<void> _updateDeviceModel(DeviceModel deviceModel) async {
    final ResponseStatus<DeviceModel> response = await devicesRepository.updateDevice(
      deviceModel: deviceModel,
    );
    response.result(
      onSuccess: (deviceModel) async {
        final String? updatedDeviceId = deviceModel.id;
        if (updatedDeviceId != null) {
          await deviceStorage.storeDeviceId(updatedDeviceId);
        }
        emit(
          const DeviceInfoState.success(),
        );
      },
      onError: (failure) => emit(
        DeviceInfoState.failure(
          appError: failure,
        ),
      ),
    );
  }
}
