import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/common/service_locator.dart';
import 'package:uhk_events/common/transitions/slide_transition.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';
import 'package:uhk_events/ui/main/conference/screens/detail/schedule_detail_screen.dart';
import 'package:uhk_events/ui/main/conference/screens/schedule/bloc/bloc.dart';
import 'package:uhk_events/ui/main/conference/widget/main_event_inherited_widget.dart';
import 'package:uhk_events/ui/main/home/home_view.dart';
import 'package:uhk_events/ui/shared/app_bar.dart';

import 'main_event_item_tile.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String eventId = MainEventInheritedWidget.of(context).id;

    return BlocProvider<MainEventBloc>(
        create: (context) =>
            injector<MainEventBloc>()..add(LoadMainEvents(eventId: eventId)),
        child: _ScheduleView());
  }
}

class _ScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = MainEventInheritedWidget.of(context).faculty.facultyColor();

    return BlocBuilder<MainEventBloc, MainEventState>(
      builder: (context, state) {
        return DefaultTabController(
          length: state.dayEvents?.length ?? 0,
          child: Scaffold(
            appBar: EventAppBar(
              context.translate("scheduleTitle"),
              actions: [MyScheduleFilter()],
              tabBar: state.dayEvents == null
                  ? null
                  : createTabBar(
                      state.dayEvents
                          ?.map((dayEvent) => Tab(text: "${dayEvent?.dayDate}"))
                          ?.toList(),
                      color,
                      context),
            ),
            body: state.dayEvents == null
                ? EmptyEventList(textKey: "noSavedEvents")
                : TabBarView(
                    children: state.dayEvents?.map((dayEvent) {
                      return dayEvent.events.isNotEmpty
                          ? _EventList(events: dayEvent.events, color: color)
                          : EmptyEventList(textKey: "noEventsLoaded");
                    })?.toList(),
                  ),
          ),
        );
      },
    );
  }
}

class _EventList extends StatelessWidget {
  final List<MainEventItem> events;
  final Color color;

  const _EventList({@required this.events, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) => MainEventItemTile(
          item: events[index],
          onDetailClick: () {
            Navigator.of(context).push(
              SlideLeftRoute(
                child: BlocProvider.value(
                  value: injector<MainEventBloc>(),
                  child: ScheduleDetailScreen(
                    eventItem: events[index],
                    color: color,
                  ),
                ),
              ),
            );
          },
          onSavedClick: () {
            final eventId = MainEventInheritedWidget.of(context).id;
            context.bloc<MainEventBloc>().add(
                  ToggleEvent(
                    mainEventItem: events[index],
                    eventId: eventId,
                  ),
                );
          },
        ),
      ),
    );
  }
}

class MyScheduleFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventInfo = MainEventInheritedWidget.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(context.translate("mySchedule")),
        SizedBox(width: appBarRightPadding),
        BlocBuilder<MainEventBloc, MainEventState>(
            builder: (_, MainEventState state) {
          return Switch.adaptive(
            activeColor: eventInfo.faculty.facultyColor(),
            value: state.showSavedEvents,
            onChanged: (value) =>
                _toggleSaveEvents(context, value, eventInfo.id),
          );
        }),
        SizedBox(width: appBarRightPadding)
      ],
    );
  }

  void _toggleSaveEvents(BuildContext context, bool value, String eventId) {
    context.bloc<MainEventBloc>().add(
          ToggleSavedEvents(savedEvents: value, eventId: eventId),
        );
  }
}
