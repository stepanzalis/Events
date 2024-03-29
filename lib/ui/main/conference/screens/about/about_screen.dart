import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/common/service_locator.dart';
import 'package:uhk_events/ui/main/conference/widget/main_event_inherited_widget.dart';

import 'about_content.dart';
import 'bloc/bloc.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String eventId = MainEventInheritedWidget.of(context).id;
    return MultiBlocProvider(
      providers: [
        BlocProvider<SavedEventsBloc>(
          create: (context) =>
              injector<SavedEventsBloc>()..add(LoadMyEvents(eventId: eventId)),
        ),
        BlocProvider<AboutInfoBloc>(
          create: (context) =>
              injector<AboutInfoBloc>()..add(LoadMainEventInfo(id: eventId)),
        )
      ],
      child: AboutView(),
    );
  }
}
