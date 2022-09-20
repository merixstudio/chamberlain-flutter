import 'package:bloc/bloc.dart';
import 'package:chamberlain/utils/network_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'network_info_state.dart';
part 'network_info_cubit.freezed.dart';

@injectable
class NetworkInfoCubit extends Cubit<NetworkInfoState> {
  NetworkInfoCubit({
    required this.networkUtil,
  }) : super(const NetworkInfoState.initial());

  final NetworkUtil networkUtil;

  Future<void> load() async {
    final String addressIP = await networkUtil.addressIP();
    emit(
      NetworkInfoState.info(
        addressIP: addressIP,
      ),
    );
  }
}
