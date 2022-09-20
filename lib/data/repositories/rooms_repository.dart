import 'package:chamberlain/config/constants/firebase_constants.dart';
import 'package:chamberlain/data/errors/app_error.dart';
import 'package:chamberlain/data/models/room/room_model.dart';
import 'package:chamberlain/data/responses/response_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class RoomsRepository {
  Stream<ResponseStatus<List<RoomModel>>> watchRooms();
}

@Injectable(as: RoomsRepository)
class FirebaseRoomsRepository extends RoomsRepository {
  FirebaseRoomsRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Stream<ResponseStatus<List<RoomModel>>> watchRooms() async* {
    yield* firestore
        .collection(FirebaseConstants.collections.rooms)
        .snapshots()
        .map(
          (snapshot) => ResponseStatus.success(
            snapshot.docs
                .map((doc) => RoomModel.fromJson(
                      doc.data(),
                    ))
                .toList(),
          ),
        )
        .handleError(
          (error) => ResponseStatus.error(
            AppError.unknownFailure(error),
          ),
        );
  }
}
