import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/io/model/saved_event.dart';
import 'package:uhk_events/ui/main/conference/widget/item_my_event.dart';

import 'bloc/bloc.dart';

class MainEventItemsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 170,
        child: BlocBuilder<SavedEventsBloc, SavedEventsState>(
          builder: (context, state) {
            if (state is EventsLoaded) {
              final List<SavedEvent> events = state.events;
              return ListView.builder(
                itemCount: state.events.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final SavedEvent event = events[index];
                  return MyEventItemRow(
                      title: event.title,
                      place: event.place,
                      timeLeft: event.timeLeft);
                },
              );
            } else {
              return MyEventEmptyRow();
            }
          },
        ));
  }
}
