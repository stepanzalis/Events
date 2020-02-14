import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/faculty.dart';

import 'bloc.dart';
import 'event_filtered_state.dart';
import 'events_state.dart';

class EventFilteredBloc extends Bloc<EventFilteredEvent, EventFilteredState> {
  final EventsBloc eventsBloc;
  StreamSubscription eventsSubscription;

  EventFilteredBloc({@required this.eventsBloc}) {
    eventsSubscription = eventsBloc.listen((state) {
      if (state is EventsLoaded) {
        final _state = (eventsBloc.state as EventsLoaded);
        add(UpdateEvents(_state.events));
      } else if (state is EventsNotLoaded) {
        add(ShowErrorMessage());
      }
    });
  }

  @override
  EventFilteredState get initialState {
    if (eventsBloc.state is EventsLoaded) {
      return FilteredEventsLoaded(
          (eventsBloc.state as EventsLoaded).events, const <Faculty>[]);
    } else {
      return FilteredEventsLoading();
    }
  }

  @override
  Stream<EventFilteredState> mapEventToState(
    EventFilteredEvent event,
  ) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateEvents) {
      yield* _mapEventsUpdatedToState(event);
    } else {
      yield FilteredEventsError();
    }
  }

  Stream<EventFilteredState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    if (eventsBloc.state is EventsLoaded) {
      final events = (eventsBloc.state as EventsLoaded).events;
      final faculties = state is FilteredEventsLoaded
          ? (state as FilteredEventsLoaded).faculties
          : const <Faculty>[];
      final filter = _addOrRemoveFilterFaculty(faculties, event.faculty);

      yield FilteredEventsLoaded(
          _mapEventsToFilteredEvents(events, filter), filter);
    }
  }

  List<Faculty> _addOrRemoveFilterFaculty(
      List<Faculty> faculties, Faculty faculty) {
    final newList = <Faculty>[...faculties];

    if (newList.contains(faculty)) {
      newList.remove(faculty);
    } else {
      newList.add(faculty);
    }
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
