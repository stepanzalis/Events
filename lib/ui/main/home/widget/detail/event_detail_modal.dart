import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/extensions/context.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/ui/shared/widgets.dart';
import 'package:uhk_events/common/date_formatter.dart';

class EventDetailModal extends StatelessWidget {
  final EventItem eventItem;

  const EventDetailModal({@required this.eventItem});

  @override
  Widget build(BuildContext context) {
    return BlurredDialog(
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
}

class _CloseWithLogo extends StatelessWidget {
  final String logo;

  const _CloseWithLogo({@required this.logo});

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset("assets/icons/close.png", width: 18)),
          ),
          ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(18)),
              child: Image.asset(logo, height: 40)),
        ],
      );
}

class _TopSection extends StatelessWidget {
  final EventItem item;

  const _TopSection({@required this.item});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _CloseWithLogo(logo: item.faculty.facultyLogo()),
          const SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.only(left: 18, bottom: 20, right: 18),
              child: Text(
                item.eventTitle,
                style: Theme.of(context).textTheme.display1,
                textAlign: TextAlign.start,
              )),
        ],
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
          const SizedBox(width: 20),
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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
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
  Widget build(BuildContext context) => RoundedButton(
        title: context.translate("addToCalendarBtn"),
        color: item.faculty.facultyColor(),
        onClick: () => _addItemToCalendar(item),
      );

  void _addItemToCalendar(EventItem eventItem) {
    Add2Calendar.addEvent2Cal(
      Event(
        title: eventItem.eventTitle,
        description: eventItem.eventTime,
        startDate: getDate(eventItem.eventStart, HUMAN_DATE_FORMAT),
        allDay: eventItem.multiDayEvent ? false : true,
        endDate: eventItem.multiDayEvent
            ? getDate(eventItem.eventEnds, HUMAN_DATE_FORMAT)
            : getDate(eventItem.eventStart, HUMAN_DATE_FORMAT),
      ),
    );
  }
}
