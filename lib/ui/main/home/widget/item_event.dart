import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/common/widgets.dart';

class EventItemRow extends StatelessWidget {
  final Faculty faculty;
  final String dateTime;
  final String message;

  const EventItemRow(
      {@required this.dateTime,
      @required this.message,
      @required this.faculty});

  @override
  Widget build(BuildContext context) {
    return ItemContainerSkeleton(
      child: Stack(
        children: <Widget>[
          _ItemDateLogo(dateTime, faculty),
          _ItemMessage(message)
        ],
      ),
    );
  }
}

class _ItemDateLogo extends StatelessWidget {
  final String dateTime;
  final Faculty faculty;

  const _ItemDateLogo(this.dateTime, this.faculty);

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 17, left: 20),
                child: Text(
                  dateTime,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: faculty.facultyColor()),
                ),
              )),
          Align(
              alignment: Alignment.topRight,
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(18)),
                  child: Image.asset(
                    faculty.facultyLogo(),
                    scale: 3.6,
                  )))
        ],
      );
}

class _ItemMessage extends StatelessWidget {
  final String text;

  const _ItemMessage(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 15),
      child: Text(
        text,
        style: Theme.of(context).textTheme.body2,
        maxLines: 2,
      ),
    );
  }
}
