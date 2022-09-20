import 'package:chamberlain/config/constants/firebase_constants.dart';
import 'package:chamberlain/data/models/device/device_model.dart';
import 'package:chamberlain/data/responses/response_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class DevicesRepository {
  Future<ResponseStatus<DeviceModel>> updateDevice({
    required DeviceModel deviceModel,
  });
}

@Injectable(as: DevicesRepository)
class FirebaseDevicesRepository extends DevicesRepository {
  FirebaseDevicesRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Future<ResponseStatus<DeviceModel>> updateDevice({
    required DeviceModel deviceModel,
  }) async {
    final CollectionReference deviceCollection = firestore.collection(FirebaseConstants.collections.devices);
    if (deviceModel.id == null) {
      final String id = (await deviceCollection.add(deviceModel.toJson())).id;
      return ResponseStatus.success(
        deviceModel.copyWith(
          id: id,
        ),
      );
    } else {
      await deviceCollection.doc(deviceModel.id).set(deviceModel.toJson());
      return ResponseStatus.success(deviceModel);
    }
  }
}
