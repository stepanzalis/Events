import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uhk_events/common/colors.dart';
import 'package:uhk_events/common/extensions/context.dart';
import 'package:uhk_events/ui/main/conference/bloc/bloc.dart';

class ConferenceBottomNavigation extends StatelessWidget {
  final int index;

  const ConferenceBottomNavigation({@required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).backgroundColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (int i) => BlocProvider.of<NavigatorBloc>(context)
          .add(ChangePageIndex(index: i)),
      items: navigationItems(context),
    );
  }

  List<BottomNavigationBarItem> navigationItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/about.svg",
          color: disableBarItemColor,
        ),
        activeIcon: SvgPicture.asset(
          "assets/icons/about.svg",
          color: Colors.black,
        ),
        title: Text(
          context.translate(""),
        ),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/timetable.svg",
          color: disableBarItemColor,
        ),
        activeIcon: SvgPicture.asset(
          "assets/icons/timetable.svg",
          color: Colors.black,
        ),
        title: Text(
          context.translate(""),
        ),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/map.svg",
          color: disableBarItemColor,
        ),
        activeIcon: SvgPicture.asset(
          "assets/icons/map.svg",
          color: Colors.black,
        ),
        title: Text(
          context.translate(""),
        ),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/wifi.svg",
          color: disableBarItemColor,
        ),
        activeIcon: SvgPicture.asset(
          "assets/icons/wifi.svg",
          color: Colors.black,
        ),
        title: Text(
          context.translate(""),
        ),
      ),
    ];
  }
}
