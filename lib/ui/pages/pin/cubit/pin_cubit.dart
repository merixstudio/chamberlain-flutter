import 'package:bloc/bloc.dart';
import 'package:chamberlain/config/env_variables.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_state.dart';
part 'pin_cubit.freezed.dart';

class PinCubit extends Cubit<PinState> {
  PinCubit()
      : super(
          EnvVariables.pinCode.isEmpty
              ? const PinState.valid(
                  inputs: [],
                )
              : const PinState.inputs(
                  inputs: [],
                ),
        );

  Future<void> addInputNumber(int number) async {
    final List<int> currentInput = [
      ...state.inputs,
    ];

    if (currentInput.length < EnvVariables.pinCode.length) {
      emit(
        PinState.inputs(
          inputs: currentInput..add(number),
        ),
      );
      if (currentInput.length == EnvVariables.pinCode.length) {
        if (currentInput.join() == EnvVariables.pinCode) {
          emit(
            PinState.valid(
              inputs: currentInput,
            ),
          );
        } else {
          emit(
            PinState.failed(
              inputs: currentInput,
            ),
          );
        }
      }
    } else {
      emit(
        PinState.inputs(
          inputs: [
            number,
          ],
        ),
      );
    }
  }

  Future<void> removeLastInputNumber() async {
    final List<int> currentInput = [
      ...state.inputs,
    ];

    if (currentInput.isNotEmpty) {
      emit(
        PinState.inputs(
          inputs: currentInput..removeLast(),
        ),
      );
    }
  }
}
