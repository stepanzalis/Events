import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/date_formatter.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';
import 'package:uhk_events/ui/main/conference/screens/about/about_banner.dart';
import 'package:uhk_events/ui/main/home/widget/detail/event_detail_modal.dart';

class ScheduleDetailScreen extends StatelessWidget {
  final MainEventItem eventItem;
  final Color color;

  ScheduleDetailScreen({@required this.eventItem, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            BannerWidget(
              title: eventItem?.title ?? "",
              url: eventItem?.detailImageUrl ?? "",
              color: color,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: EventTimeSubSection(
                      icon: "assets/icons/time_icon.svg",
                      time: format(
                          dateTime: eventItem.startDateTime,
                          format: HUMAN_DATE_TIME_DAYNAME_FORMAT),
                      color: color,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: EventTimeSubSection(
                      icon: "assets/icons/building.svg",
                      time: eventItem.place,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      eventItem.description,
                      style: Theme.of(context).textTheme.body2,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: _FloatingActionButton(color: color),
        bottomNavigationBar: _BottomNavigationBar());
  }
}

class _BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            blurRadius: 10.0,
            spreadRadius: 5.0,
          )
        ],
      ),
      child: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(width: 30),
            GestureDetector(
              child: Image.asset(
                "assets/icons/share.png",
                height: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  final Color color;

  const _FloatingActionButton({@required this.color});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: color,
      child: Center(
        child: Icon(
          Icons.star,
          color: Colors.white,
          size: 40,
        ),
      ),
      onPressed: () {},
    );
  }
}
