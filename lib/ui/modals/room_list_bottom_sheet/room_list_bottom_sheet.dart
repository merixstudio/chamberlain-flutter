import 'package:chamberlain/config/styles/theme/extensions/room_list_bottom_sheet_style.dart';
import 'package:chamberlain/cubits/room_list/room_list_cubit.dart';
import 'package:chamberlain/ui/models/room/room_view_model.dart';
import 'package:chamberlain/ui/widgets/empty_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomListBottomSheet extends StatelessWidget {
  const RoomListBottomSheet({
    this.selectedRoom,
    this.onRoomSelected,
    Key? key,
  }) : super(key: key);

  final RoomViewModel? selectedRoom;
  final Function(RoomViewModel room)? onRoomSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomListCubit, RoomListState>(
      builder: (context, state) {
        final Widget child = state.maybeMap(
          failure: (state) => EmptyContainer(
            title: state.error.localizedTitle(context),
          ),
          loading: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: (state) => _buildList(
            context,
            rooms: state.rooms,
          ),
          orElse: () => const SizedBox.shrink(),
        );
        return AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 300,
          ),
          child: child,
        );
      },
    );
  }

  Widget _buildList(
    BuildContext context, {
    required List<RoomViewModel> rooms,
  }) {
    final RoomListBottomSheetStyle? roomListBottomSheetStyle = Theme.of(context).extension<RoomListBottomSheetStyle>();
    return Scrollbar(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final RoomViewModel room = rooms[index];
          final bool isSelected = room.id == selectedRoom?.id;
          return TextButton(
            onPressed: () => onRoomSelected?.call(room),
            style: isSelected
                ? roomListBottomSheetStyle?.selectedRoomCellButtonStyle
                : roomListBottomSheetStyle?.roomCellButtonStyle,
            child: Text(
              room.name,
              style: isSelected
                  ? roomListBottomSheetStyle?.selectedRoomCellNameTextStyle
                  : roomListBottomSheetStyle?.roomCellNameTextStyle,
            ),
          );
        },
        itemCount: rooms.length,
        shrinkWrap: true,
      ),
    );
  }
}
