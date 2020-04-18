import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uhk_events/common/colors.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/date_formatter.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';
import 'package:uhk_events/ui/main/conference/widget/main_event_inherited_widget.dart';
import 'package:uhk_events/ui/shared/widgets.dart';

class MainEventItemTile extends StatelessWidget {
  final MainEventItem item;
  final VoidCallback onSavedClick;
  final VoidCallback onDetailClick;

  MainEventItemTile(
      {@required this.item, this.onSavedClick, this.onDetailClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDetailClick,
      child: ItemContainerSkeleton(
        child: _ListTile(
          title: item.title,
          subtitle: item.description,
          isSelected: item.isSaved,
          startTime:
              format(dateTime: item.startDateTime, format: ONLY_TIME_FORMAT),
          onStarClick: onSavedClick,
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String startTime;
  final VoidCallback onStarClick;
  final bool isSelected;

  _ListTile(
      {@required this.title,
      @required this.subtitle,
      @required this.startTime,
      @required this.onStarClick,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 15, 20),
      child: Row(
        children: <Widget>[
          Text(startTime,
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(color: primaryTextColor, fontSize: 24)),
          SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Text(subtitle,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: primaryTextColor)),
              ],
            ),
          ),
          SizedBox(width: 10),
          SaveEventStar(isSelected: isSelected ? 1 : 0.3, onClick: onStarClick),
        ],
      ),
    );
  }
}

class SaveEventStar extends StatelessWidget {
  final double isSelected;
  final VoidCallback onClick;

  const SaveEventStar({@required this.isSelected, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    final Color color =
        MainEventInheritedWidget.of(context).faculty.facultyColor();

    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Opacity(
          opacity: isSelected,
          child: SvgPicture.asset(
            "assets/icons/star.svg",
            width: 30,
            color: color,
          ),
        ),
      ),
    );
  }
}
