import 'package:bloc/bloc.dart';
import 'package:chamberlain/config/constants/app_constants.dart';
import 'package:chamberlain/config/env_variables.dart';
import 'package:chamberlain/data/errors/app_error.dart';
import 'package:chamberlain/data/models/event/event_model.dart';
import 'package:chamberlain/data/models/event/event_source.dart';
import 'package:chamberlain/data/models/event_time/event_time_model.dart';
import 'package:chamberlain/data/repositories/event_repository.dart';
import 'package:chamberlain/ui/modals/new_event_dialog/event_period.dart';
import 'package:chamberlain/utils/date_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

part 'create_event_state.dart';
part 'create_event_cubit.freezed.dart';

@injectable
class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit({
    required this.eventRepository,
  }) : super(const CreateEventState.initial());

  final EventRepository eventRepository;

  Future<void> create({
    required EventPeriod eventPeriod,
    String? location,
  }) async {
    emit(
      const CreateEventState.loading(),
    );

    //TODO Define default event name
    //TODO Check if we can skip timezones.
    final DateTime startDateTime = DateUtils.dropSeconds(DateTime.now());
    final DateTime endDateTime = startDateTime.add(eventPeriod.duration);

    final String startTime = DateUtils.formatDefaultDate(startDateTime);
    final String endTime = DateUtils.formatDefaultDate(endDateTime);

    final response = await eventRepository.createEvent(
      eventModel: EventModel(
        id: const Uuid().v4().replaceAll('-', ''),
        name: AppConstants.defaultEventName,
        location: location,
        start: EventTimeModel(
          dateTime: startTime,
          timeZone: EnvVariables.timeZone,
        ),
        end: EventTimeModel(
          dateTime: endTime,
          timeZone: EnvVariables.timeZone,
        ),
        source: EventSource.device,
      ),
    );

    response.result(
      onSuccess: (event) => emit(const CreateEventState.success()),
      onError: (error) => emit(
        CreateEventState.failure(
          appError: error,
        ),
      ),
    );
  }
}
