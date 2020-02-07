import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/main/conference/bloc/bloc.dart';
import 'package:uhk_events/ui/main/conference/screens/about/about_screen.dart';

import 'widget/bottom_navigation_bar.dart';

class ConferenceView extends StatelessWidget {
  final String eventId;
  final Faculty faculty;

  ConferenceView({@required this.eventId, this.faculty, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBloc, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(
            children: pages,
            index: currentIndex,
          ),
          bottomNavigationBar: ConferenceBottomNavigation(index: currentIndex),
        );
      },
    );
  }

  final List<Widget> pages = [
    AboutView(),
    Container(),
    Container(),
    Container(),
  ];
}
