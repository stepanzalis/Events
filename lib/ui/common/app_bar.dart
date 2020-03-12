import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uhk_events/common/colors.dart';

class EventAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final TabBar tabBar;

  EventAppBar(this.title, {this.actions, this.tabBar}) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: actions,
        title: Text(title, style: Theme.of(context).textTheme.title),
        bottom: tabBar != null ? tabBar : null);
  }

  @override
  Size get preferredSize => Size(double.infinity, tabBar == null ? 56 : 110);
}

TabBar createTabBar(List<Tab> tabs, Color accentColor, BuildContext context) {
  return TabBar(
    tabs: tabs,
    indicatorColor: accentColor,
    labelStyle: Theme.of(context).textTheme.subtitle.copyWith(
        fontSize: 16, fontWeight: FontWeight.w700, color: accentColor),
    unselectedLabelStyle: Theme.of(context).textTheme.subtitle.copyWith(
        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    labelColor: primaryColor,
  );
}
