import 'package:chamberlain/config/env_variables.dart';
import 'package:chamberlain/config/styles/colors/app_colors.dart';
import 'package:chamberlain/l10n/app_loc.dart';
import 'package:chamberlain/ui/pages/pin/cubit/pin_cubit.dart';
import 'package:chamberlain/ui/pages/pin/widgets/pin_icon_cell.dart';
import 'package:chamberlain/ui/pages/pin/widgets/pin_input_cell.dart';
import 'package:chamberlain/ui/pages/pin/widgets/pin_number_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinPage extends StatelessWidget {
  const PinPage({Key? key}) : super(key: key);

  static const int _zeroCell = 0;
  static const double _spacing = 40.0;
  static const double _keyboardCellAspect = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLoc.of(context).pinAppBarTitle,
        ),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _InputsRow(),
        const SizedBox(
          height: _spacing,
        ),
        Flexible(
          child: _buildNumbersKeyboard(context),
        ),
        const SizedBox(
          height: _spacing,
        ),
        _buildBottomActionsRow(context),
      ],
    );
  }

  Widget _buildNumbersKeyboard(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: _keyboardCellAspect,
        mainAxisSpacing: _spacing,
        crossAxisCount: 3,
        crossAxisSpacing: _spacing,
      ),
      itemBuilder: (context, index) {
        final int fixNumber = index + 1;
        return PinNumberCell(
          number: fixNumber,
          onPressed: () => context.read<PinCubit>().addInputNumber(fixNumber),
        );
      },
      itemCount: 9,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Widget _buildBottomActionsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(),
        const SizedBox(
          width: _spacing,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: _keyboardCellAspect,
            child: PinNumberCell(
              number: _zeroCell,
              onPressed: () =>
                  context.read<PinCubit>().addInputNumber(_zeroCell),
            ),
          ),
        ),
        const SizedBox(
          width: _spacing,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: _keyboardCellAspect,
            child: PinIconCell(
              icon: Icons.close_rounded,
              onPressed: () => context.read<PinCubit>().removeLastInputNumber(),
            ),
          ),
        )
      ],
    );
  }
}

class _InputsRow extends StatelessWidget {
  const _InputsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinCubit, PinState>(
      builder: (context, state) => Column(
        children: [
          _buildInputs(
            isError: state.failed,
            inputs: state.inputs,
          ),
          const SizedBox(
            height: 16.0,
          ),
          AnimatedOpacity(
            opacity: state.failed ? 1.0 : 0.0,
            duration: const Duration(
              milliseconds: 100,
            ),
            child: _buildErrorLabel(context),
          ),
        ],
      ),
    );
  }

  Widget _buildInputs({
    required bool isError,
    required List<int> inputs,
  }) {
    return Row(
      children: List.generate(
        EnvVariables.pinCode.length,
        (index) => Expanded(
          child: AspectRatio(
            aspectRatio: PinPage._keyboardCellAspect,
            child: PinInputCell(
              isError: isError,
              isFilled: inputs.length > index,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorLabel(BuildContext context) {
    return Text(
      AppLoc.of(context).pinInputsErrorLabel,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.darkRed,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
