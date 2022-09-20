import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'current_time_state.dart';
part 'current_time_cubit.freezed.dart';

@injectable
class CurrentTimeCubit extends Cubit<CurrentTimeState> {
  CurrentTimeCubit()
      : super(
          CurrentTimeState.time(
            currentTime: DateTime.now(),
          ),
        ) {
    _startTimer();
  }

  late final Timer _timer;

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }

  Future<void> _startTimer() async {
    //Wait till next minute
    await Future.delayed(Duration(
      seconds: 60 - DateTime.now().second,
    ));
    _emitCurrentTime();
    _timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (timer) => _emitCurrentTime(),
    );
  }

  void _emitCurrentTime() {
    final DateTime lastTime = state.currentTime;
    final DateTime newTime = DateTime.now();
    if (lastTime.day != newTime.day) {
      emit(
        CurrentTimeState.dayChanged(
          currentTime: newTime,
        ),
      );
    }
    emit(
      CurrentTimeState.time(
        currentTime: newTime,
      ),
    );
  }
}
