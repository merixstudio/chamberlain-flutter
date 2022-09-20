import 'package:chamberlain/config/constants/firebase_constants.dart';
import 'package:chamberlain/config/env_variables.dart';
import 'package:chamberlain/data/errors/app_error.dart';
import 'package:chamberlain/data/models/event/event_model.dart';
import 'package:chamberlain/data/responses/response_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class EventRepository {
  Stream<ResponseStatus<List<EventModel>>> watchEvents({
    required String calendarId,
    required DateTime from,
    required DateTime to,
    String? location,
  });

  Future<ResponseStatus<EventModel>> createEvent({
    required EventModel eventModel,
  });

  Future<ResponseStatus<EventModel>> updateEvent({
    required EventModel eventModel,
  });
}

@Injectable(as: EventRepository)
class FirebaseEventRepository extends EventRepository {
  FirebaseEventRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Stream<ResponseStatus<List<EventModel>>> watchEvents({
    required String calendarId,
    required DateTime from,
    required DateTime to,
    String? location,
  }) async* {
    yield* firestore
        .collection(FirebaseConstants.collections.calendars)
        .doc(EnvVariables.calendarId)
        .collection(FirebaseConstants.collections.events)
        .where(
          FirebaseConstants.keys.startDateTime,
          isGreaterThanOrEqualTo: from.toIso8601String(),
        )
        .where(
          FirebaseConstants.keys.startDateTime,
          isLessThanOrEqualTo: to.toIso8601String(),
        )
        .where(
          FirebaseConstants.keys.location,
          isEqualTo: location,
        )
        .snapshots()
        .map(
          (snapshot) => ResponseStatus.success(
            snapshot.docs
                .map((doc) => EventModel.fromJson(
                      doc.data(),
                    ))
                .toList(),
          ),
        )
        .handleError((error) async* {
      yield ResponseStatus.error(AppError.unknownFailure(error));
    });
  }

  @override
  Future<ResponseStatus<EventModel>> createEvent({
    required EventModel eventModel,
  }) {
    try {
      firestore
          .collection(FirebaseConstants.collections.calendars)
          .doc(EnvVariables.calendarId)
          .collection(FirebaseConstants.collections.events)
          .add(eventModel.toJson());
      return Future.value(ResponseStatus.success(eventModel));
    } on FirebaseException catch (error) {
      //TODO handle firebase specific errors if needed
      return Future.value(ResponseStatus.error(AppError.unknownFailure(error)));
    } catch (error) {
      return Future.value(ResponseStatus.error(AppError.unknownFailure(error)));
    }
  }

  @override
  Future<ResponseStatus<EventModel>> updateEvent({
    required EventModel eventModel,
  }) async {
    try {
      final events = await firestore
          .collection(FirebaseConstants.collections.calendars)
          .doc(EnvVariables.calendarId)
          .collection(FirebaseConstants.collections.events)
          .where(FirebaseConstants.keys.id, isEqualTo: eventModel.id)
          .get();
      for (var event in events.docs) {
        await event.reference.update(eventModel.toJson());
      }
      return Future.value(ResponseStatus.success(eventModel));
    } on FirebaseException catch (error) {
      //TODO handle firebase specific errors if needed
      return Future.value(ResponseStatus.error(AppError.unknownFailure(error)));
    } catch (error) {
      return Future.value(ResponseStatus.error(AppError.unknownFailure(error)));
    }
  }
}
