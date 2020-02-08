import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/ui/main/conference/bloc/bloc.dart';
import 'package:uhk_events/ui/main/conference/screens/about/about_screen.dart';
import 'package:uhk_events/ui/main/conference/screens/about/bloc/bloc.dart';
import 'package:uhk_events/util/service_locator.dart';

import 'widget/bottom_navigation_bar.dart';

class ConferenceView extends StatelessWidget {
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
    MultiBlocProvider(
      providers: [
        BlocProvider<SavedEventsBloc>(
          create: (context) => injector<SavedEventsBloc>()..add(LoadMyEvents()),
        )
      ],
      child: AboutView(),
    ),
    Container(),
    Container(),
    Container(),
  ];
}
