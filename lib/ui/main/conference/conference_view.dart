import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/ui/main/conference/bloc/bloc.dart';
import 'package:uhk_events/ui/main/conference/screens/about/about_screen.dart';
import 'package:uhk_events/ui/main/conference/screens/schedule/schedule_screen.dart';

import 'widget/bottom_navigation_bar.dart';

class ConferenceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBloc, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(
            children: _pages,
            index: currentIndex,
          ),
          bottomNavigationBar: ConferenceBottomNavigation(index: currentIndex),
        );
      },
    );
  }

  final List<Widget> _pages = [
    AboutView(),
    ScheduleView(),
    Container(),
    Container(),
  ];
}
