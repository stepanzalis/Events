import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';

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
    return ItemContainer(
      Stack(
        children: <Widget>[
          _ItemDateLogo(dateTime, faculty),
          _ItemMessage(message)
        ],
      ),
    );
  }
}

class ItemContainer extends StatelessWidget {
  final Widget child;

  const ItemContainer(this.child);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 20.0,
              spreadRadius: 3,
              offset: const Offset(0.0, 10.0),
            )
          ],
        ),
        child: child,
      );
}

class _ItemDateLogo extends StatelessWidget {
  final String dateTime;
  final Faculty faculty;

  const _ItemDateLogo(this.dateTime, this.faculty);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 17, left: 20),
          child: Text(
            dateTime,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: faculty.facultyColor()),
          ),
        ),
        Image.asset(
          faculty.facultyLogo(),
          scale: 3.6,
        ),
      ],
    );
  }
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
