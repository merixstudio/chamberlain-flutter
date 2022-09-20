import 'package:chamberlain/data/models/attendee/attendee_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';

part 'profile_view_model.freezed.dart';

@freezed
class ProfileViewModel with _$ProfileViewModel {
  const factory ProfileViewModel({
    required String avatar,
    required String name,
  }) = _ProfileViewModel;

  const ProfileViewModel._();

  String get initials {
    final List<String> emailSplitByDot = name.split('.');
    if (emailSplitByDot.length > 1) {
      return '${emailSplitByDot.first.substring(0, 1)}${emailSplitByDot[1].substring(0, 1)}'.toUpperCase();
    } else {
      return emailSplitByDot.firstOrNull?.substring(0, 1).toUpperCase() ?? '';
    }
  }

  static ProfileViewModel fromAttendeeModel(AttendeeModel attendeeModel) {
    return ProfileViewModel(
      name: attendeeModel.email ?? '',
      avatar: '',
    );
  }

  ///Filered out models where resource is true to remove room from the guest list
  static List<ProfileViewModel> fromAttendeeModels(List<AttendeeModel> attendeeModels) {
    return attendeeModels
        .where((element) => !(element.resource ?? false))
        .map((attendee) => ProfileViewModel.fromAttendeeModel(attendee))
        .toList();
  }
}
