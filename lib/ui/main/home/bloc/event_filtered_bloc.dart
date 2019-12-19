import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/faculty.dart';
import './bloc.dart';

class EventFilteredBloc extends Bloc<EventFilteredEvent, EventFilteredState> {
  final EventsBloc eventsBloc;
  StreamSubscription eventsSubscription;

  EventFilteredBloc({@required this.eventsBloc}) {
    eventsSubscription = eventsBloc.listen((state) {
      if (state is EventsLoaded) {
        add(UpdateEvents((eventsBloc.state as EventsLoaded).events));
      }
    });
  }

  @override
  EventFilteredState get initialState {
    return eventsBloc.state is EventsLoaded
        ? FilteredEventsLoaded(
            (eventsBloc.state as EventsLoaded).events,
            <Faculty>[],
          )
        : FilteredEventsLoading();
  }

  @override
  Stream<EventFilteredState> mapEventToState(
    EventFilteredEvent event,
  ) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateEvents) {
      yield* _mapEventsUpdatedToState(event);
    }
  }

  Stream<EventFilteredState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    if (eventsBloc.state is EventsLoaded) {
      final events = (eventsBloc.state as EventsLoaded).events;
      final faculties = (state as FilteredEventsLoaded).faculties;
      final filter = _addOrRemoveFilterFaculty(faculties, event.faculty);

      yield FilteredEventsLoaded(
          _mapEventsToFilteredEvents(events, filter), filter);
    }
  }

  List<Faculty> _addOrRemoveFilterFaculty(List<Faculty> faculties, Faculty faculty) {
    var newList = <Faculty>[]..addAll(faculties);

    if (newList.contains(faculty))
      newList.remove(faculty);
    else
      newList.add(faculty);
    return newList;
  }

  Stream<EventFilteredState> _mapEventsUpdatedToState(
      UpdateEvents event) async* {
    final visibilityFilter = state is FilteredEventsLoaded
        ? (state as FilteredEventsLoaded).faculties
        : <Faculty>[];

    yield FilteredEventsLoaded(
      (eventsBloc.state as EventsLoaded).events,
      visibilityFilter,
    );
  }

  List<EventItem> _mapEventsToFilteredEvents(
      List<EventItem> events, List<Faculty> filter) {
    if (filter.isEmpty) return events;
    return events.where((e) => filter.contains(e.faculty)).toList();
  }

  @override
  Future<void> close() {
    eventsSubscription.cancel();
    return super.close();
  }
}