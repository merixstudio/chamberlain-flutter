import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamberlain/config/env_variables.dart';
import 'package:chamberlain/data/errors/app_error.dart';
import 'package:chamberlain/data/models/event/event_model.dart';
import 'package:chamberlain/data/models/event/event_source.dart';
import 'package:chamberlain/data/models/event_time/event_time_model.dart';
import 'package:chamberlain/data/repositories/event_repository.dart';
import 'package:chamberlain/extensions/date_extensions.dart';
import 'package:chamberlain/ui/models/event/event_view_model.dart';
import 'package:chamberlain/utils/date_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';

part 'events_state.dart';
part 'events_cubit.freezed.dart';

@injectable
class EventsCubit extends Cubit<EventsState> {
  EventsCubit({
    required this.eventRepository,
  }) : super(const EventsState.initial());

  final EventRepository eventRepository;
  StreamSubscription? _eventsSubscription;

  Future<void> load({
    String? location,
  }) async {
    await _eventsSubscription?.cancel();

    _eventsSubscription = eventRepository
        .watchEvents(
          calendarId: EnvVariables.calendarId,
          from: DateTime.now().beginningOfTheDay(),
          to: DateTime.now().endOfTheDay(),
          location: location,
        )
        .listen(
          (response) => response.result(
            onSuccess: (events) => emit(
              EventsState.success(
                events: events
                    .map(
                      (event) => EventViewModel.fromEventModel(event),
                    )
                    .toList()
                    .sortedBy((a) => a.startTime),
              ),
            ),
            onError: (error) => emit(
              EventsState.failure(
                appError: error,
              ),
            ),
          ),
        );
  }

  Future<void> cancelEvent({
    required EventViewModel? event,
  }) async {
    if (event == null) {
      return;
    }
    await eventRepository.updateEvent(
      eventModel: EventModel(
        id: event.id,
        source: EventSource.device,
        end: EventTimeModel(
          dateTime: DateUtils.formatDefaultDate(DateTime.now()),
          timeZone: EnvVariables.timeZone,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _eventsSubscription?.cancel();
    return super.close();
  }
}
