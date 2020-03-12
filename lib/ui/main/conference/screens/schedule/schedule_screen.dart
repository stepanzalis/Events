import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';
import 'package:uhk_events/ui/common/app_bar.dart';
import 'package:uhk_events/ui/main/conference/screens/schedule/bloc/bloc.dart';
import 'package:uhk_events/ui/main/conference/widget/main_event_inherited_widget.dart';
import 'package:uhk_events/util/service_locator.dart';

import 'main_event_item_tile.dart';

class ScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String eventId = MainEventInheritedWidget.of(context).id;

    return MultiBlocProvider(providers: [
      BlocProvider<MainEventBloc>(
          create: (context) =>
              injector<MainEventBloc>()..add(LoadMainEvents(id: eventId))),
    ], child: _ScheduleScreen());
  }
}

class _ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = MainEventInheritedWidget.of(context).faculty.facultyColor();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: EventAppBar(context.translate("scheduleTitle"),
              actions: [MyScheduleFilter()],
              tabBar: createTabBar([
                Tab(text: "Pondělí 1.10"),
                Tab(text: "Úterý 2.10"),
              ], color, context)),
          body: TabBarView(children: [
            _EventList(events: []),
            _EventList(events: []),
          ])),
    );
  }
}

class _EventList extends StatelessWidget {
  final List<MainEventItem> events;

  const _EventList({@required this.events});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return MainEventItemTile(
              item: MainEventItem(
                  title: "asdasd",
                  description: "asdasd",
                  startDateTime: DateTime.now()));
        },
      ),
    );
  }
}

class MyScheduleFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = MainEventInheritedWidget.of(context).faculty.facultyColor();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(context.translate("mySchedule")),
        SizedBox(width: appBarRightPadding),
        BlocBuilder<MainEventBloc, MainEventState>(
            builder: (_, MainEventState state) {
          return Switch.adaptive(
              activeColor: color,
              value: state.showSavedEvents,
              onChanged: (value) => _toggleSaveEvents(context, value));
        }),
        SizedBox(width: appBarRightPadding)
      ],
    );
  }

  void _toggleSaveEvents(BuildContext context, bool value) {
    BlocProvider.of<MainEventBloc>(context).add(
      ToggleSavedEvents(savedEvents: value),
    );
  }
}
