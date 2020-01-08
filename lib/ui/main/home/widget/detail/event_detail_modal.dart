import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/ui/common/widgets.dart';

class EventDetailModal extends StatelessWidget {
  final EventItem eventItem;

  const EventDetailModal({@required this.eventItem});

  @override
  Widget build(BuildContext context) => BlurredDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _TopSection(item: eventItem),
            LineSeparator(color: Colors.grey.withOpacity(0.4)),
            _BottomSection(item: eventItem)
          ],
        ),
      );
}

class _CloseWithLogo extends StatelessWidget {
  final String logo;

  const _CloseWithLogo({@required this.logo});

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Image.asset("assets/icons/close.png", width: 18)),
              )),
          Align(
              alignment: Alignment.topRight,
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(18)),
                  child: Image.asset(logo, height: 40))),
        ],
      );
}

class _TopSection extends StatelessWidget {
  final EventItem item;

  const _TopSection({@required this.item});

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(left: 18, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _CloseWithLogo(logo: item.faculty.facultyLogo()),
            SizedBox(height: 30),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(item.eventTitle,
                    style: Theme.of(context).textTheme.display1)),
          ],
        ),
      );
}

class _EventTimeSubSection extends StatelessWidget {
  final EventItem item;

  const _EventTimeSubSection({@required this.item});

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          SvgPicture.asset("assets/icons/time_icon.svg",
              width: 15, color: item.faculty.facultyColor()),
          SizedBox(width: 20),
          Expanded(
              child: Text(item.eventTime,
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontSize: 15)))
        ],
      );
}

class _BottomSection extends StatelessWidget {
  final EventItem item;

  const _BottomSection({@required this.item});

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _EventTimeSubSection(item: item),
            Align(alignment: Alignment.centerLeft, child: Text("")),
            _CalendarButton(item: item)
          ],
        ),
      );
}

class _CalendarButton extends StatelessWidget {
  final EventItem item;

  const _CalendarButton({@required this.item});

  @override
  Widget build(BuildContext context) => Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 10, top: 25),
        width: double.infinity,
        child: RaisedButton(
          child: Text(
              FlutterI18n.translate(context, "addToCalendarBtn").toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display1.copyWith(
                  fontSize: 15, color: Colors.white, letterSpacing: 1.5)),
          onPressed: () => null, // TODO: udělat klik
          color: item.faculty.facultyColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
      );
}
