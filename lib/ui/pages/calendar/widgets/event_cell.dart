part of 'events_calendar.dart';

class _EventCell extends StatelessWidget {
  const _EventCell({
    required this.event,
    this.margin,
    this.onPressed,
    this.showBorder = false,
    Key? key,
  }) : super(key: key);

  final EventViewModel event;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(
        milliseconds: 300,
      ),
      opacity: event.isSynchronized ? 1.0 : 0.4,
      child: Container(
        decoration: BoxDecoration(
          border: showBorder
              ? Border.all(
                  color: AppColors.black,
                  width: 1.5,
                )
              : null,
          borderRadius: AppDimensions.radius.smallRadius(),
          color: AppColors.darkGrey,
        ),
        margin: const EdgeInsets.only(
          bottom: 2.0,
        ).add(margin ?? EdgeInsets.zero),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: event.is30MinsOrBelow ? 0.0 : 16.0,
              horizontal: 16.0,
            ),
            foregroundColor: AppColors.orangeLight,
          ),
          onPressed: onPressed,
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: event.is30MinsOrBelow
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: _buildNameDurationSection(context),
        ),
        if (event.is60MinsOrMore)
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: MembersAvatarList(
              members: event.members,
            ),
          ),
      ],
    );
  }

  Widget _buildNameDurationSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Text nameLabel = _buildName(context);
        final double nameWidth = nameLabel.width(context);
        final bool nameFitsInWidth = constraints.maxWidth > (nameWidth + 8);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (nameFitsInWidth)
              nameLabel
            else
              Expanded(
                child: nameLabel,
              ),
            const SizedBox(
              width: 8.0,
            ),
            if (nameFitsInWidth)
              Flexible(
                child: _buildTimePeriod(
                  context,
                ),
              )
          ],
        );
      },
    );
  }

  Text _buildName(BuildContext context) {
    return Text(
      event.name,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context)
          .extension<DayCalendarStyle>()
          ?.eventCellNameLabelTextStyle,
    );
  }

  Widget _buildTimePeriod(BuildContext context) {
    return Text(
      event.fromToString,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      style: Theme.of(context)
          .extension<DayCalendarStyle>()
          ?.eventCellPeriodLabelTextStyle,
    );
  }
}
