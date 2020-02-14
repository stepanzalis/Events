import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uhk_events/common/colors.dart';
import 'package:uhk_events/common/extensions/context.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/common/widgets.dart';
import 'package:uhk_events/util/constants.dart';

import 'main_event_inherited_widget.dart';

class MyEventItemRow extends StatelessWidget {
  final String title;
  final String place;
  final String timeLeft;

  const MyEventItemRow(
      {@required this.title, @required this.place, @required this.timeLeft});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: ItemContainerSkeleton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle,
                ),
                const SizedBox(height: conferenceWidth),
                Text(place,
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: primaryTextColor)),
                const SizedBox(height: conferenceWidth),
                _TimeLeftPanel(timeLeft: "30MIN")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeLeftPanel extends StatelessWidget {
  final double conferenceFontSize = 15.0;
  final double panelHeight = 35;

  final String timeLeft;

  const _TimeLeftPanel({@required this.timeLeft});

  @override
  Widget build(BuildContext context) {
    final Faculty faculty = MainEventInheritedWidget.of(context).faculty;

    return Container(
      height: panelHeight,
      decoration: BoxDecoration(
        color: faculty.facultyBackgroundColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(containerRadius),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: conferenceWidth),
          SvgPicture.asset("assets/icons/clock.svg",
              color: faculty.facultyColor(), width: conferenceWidth),
          const SizedBox(width: conferenceWidth),
          RichText(
            text: TextSpan(
              text: timeLeft,
              style: Theme.of(context).textTheme.subtitle.copyWith(
                  letterSpacing: 1.4,
                  fontSize: conferenceFontSize,
                  color: faculty.facultyColor()),
              children: [
                TextSpan(
                  text: context.translate("tillStart").toUpperCase(),
                  style: Theme.of(context).textTheme.body2.copyWith(
                        letterSpacing: 1.4,
                        fontSize: conferenceFontSize,
                        color: faculty.facultyColor(),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}

class MyEventEmptyRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Faculty faculty = MainEventInheritedWidget.of(context).faculty;

    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: <Widget>[
          Opacity(
              opacity: 0.2,
              child: SvgPicture.asset("assets/icons/clock.svg",
                  color: faculty.facultyColor())),
          const SizedBox(width: conferenceWidth),
          Expanded(
              child: Text(context.translate("noSavedEvents"),
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.black)))
        ],
      ),
    );
  }
}
