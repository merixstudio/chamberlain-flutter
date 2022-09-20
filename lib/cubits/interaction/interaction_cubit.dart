import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamberlain/config/constants/app_constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'interaction_state.dart';
part 'interaction_cubit.freezed.dart';

class InteractionCubit extends Cubit<InteractionState> {
  InteractionCubit() : super(const InteractionState.initial());

  Timer? _timer;

  void countdown({
    Duration duration = const Duration(
      seconds: AppConstants.defaultIdleTimeInSeconds,
    ),
  }) {
    _timer?.cancel();
    _timer = Timer.periodic(
      duration,
      (time) {
        emit(
          const InteractionState.noInteraction(),
        );
        emit(
          const InteractionState.initial(),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
