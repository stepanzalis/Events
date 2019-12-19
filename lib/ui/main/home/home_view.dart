import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:uhk_events/io/common/constants.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/main/home/bloc/bloc.dart';
import 'package:uhk_events/ui/main/home/widget/faculty_button.dart';
import 'package:uhk_events/ui/main/home/widget/item_event.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          actions: <Widget>[_FilterButtons()],
          title: Text(FlutterI18n.translate(context, "appTitle"),
              style: Theme.of(context).textTheme.title),
        ),
        body: BlocBuilder<EventFilteredBloc, EventFilteredState>(
          builder: (context, state) {
            if (state is FilteredEventsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FilteredEventsLoaded) {
              return _EventListView(items: state.events);
            } else {
              return _EmptyEventList();
            }
          },
        ),
      );
}

class _EventListView extends StatelessWidget {
  final List<EventItem> items;

  const _EventListView({@required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final EventItem event = items[index];
        return EventItemRow(
          dateTime: event.multiDayEvent
              ? "${event.eventStart} - ${event.eventEnds}"
              : "${event.eventStart}",
          message: event.eventTitle,
          faculty: event.faculty,
        );
      },
    );
  }
}

class _EmptyEventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          FlutterI18n.translate(context, "eventError"),
          style: Theme.of(context).textTheme.body1,
        ),
      ),
    );
  }
}

class _FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(right: 10),
        child: BlocBuilder<EventFilteredBloc, EventFilteredState>(
          builder: (context, state) {
            if (state is FilteredEventsLoaded) {
              return Row(
                  children: faculties
                      .map((faculty) => GestureDetector(
                            onTap: () =>
                                BlocProvider.of<EventFilteredBloc>(context)
                                    .add(UpdateFilter(faculty)),
                            child: FilterFacultyButton(
                                faculty: faculty,
                                isEnabled: state.faculties.contains(faculty)),
                          ))
                      .toList());
            } else
              return SizedBox();
          },
        ),
      );
}
