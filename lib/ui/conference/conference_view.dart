import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uhk_events/common/colors.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/conference/screens/about/about_screen.dart';

class ConferenceView extends StatelessWidget {
  final String eventId;
  final Faculty faculty;

  const ConferenceView({@required this.eventId, this.faculty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AboutView(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/about.svg",
                color: disableBarItemColor),
            activeIcon:
                SvgPicture.asset("assets/icons/about.svg", color: Colors.black),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/timetable.svg",
                color: disableBarItemColor),
            activeIcon: SvgPicture.asset("assets/icons/timetable.svg",
                color: Colors.black),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/map.svg",
                color: disableBarItemColor),
            activeIcon:
                SvgPicture.asset("assets/icons/map.svg", color: Colors.black),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/wifi.svg",
                color: disableBarItemColor),
            activeIcon:
                SvgPicture.asset("assets/icons/wifi.svg", color: Colors.black),
            title: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
