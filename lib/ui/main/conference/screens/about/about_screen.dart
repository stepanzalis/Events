import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/ui/main/conference/widget/main_event_inherited_widget.dart';
import 'package:uhk_events/util/service_locator.dart';

import 'about_content.dart';
import 'bloc/bloc.dart';
import 'event_list.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String eventId = MainEventInheritedWidget.of(context).id;

    return MultiBlocProvider(
      providers: [
        BlocProvider<SavedEventsBloc>(
          create: (context) => injector<SavedEventsBloc>()
            ..add(
              LoadMyEvents(),
            ),
        ),
        BlocProvider<AboutInfoBloc>(
          create: (context) => injector<AboutInfoBloc>()
            ..add(
              LoadMainEventInfo(id: eventId),
            ),
        )
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 4, child: AboutContent()),
          Flexible(child: MainEventItemsListView()),
        ],
      ),
    );
  }
}
