import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/main_event_day.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';
import 'package:uhk_events/io/repositories/event_repository.dart';
import 'package:uhk_events/io/repositories/user_repository.dart';

import './bloc.dart';

class MainEventBloc extends Bloc<MainEventEvent, MainEventState> {
  final EventRepository eventRepository;
  final UserRepository userRepository;

  MainEventBloc(
      {@required this.eventRepository, @required this.userRepository});

  @override
  MainEventState get initialState => MainEventState.loading();

  @override
  Stream<MainEventState> mapEventToState(
    MainEventEvent event,
  ) async* {
    if (event is LoadMainEvents) {
      yield* _mapLoadMainEventsToState(
        event.eventId,
        await userRepository.getUserDocumentId(),
      );
    } else if (event is ToggleSavedEvents) {
      yield* _mapLoadMainEventsToState(
          event.eventId, await userRepository.getUserDocumentId(),
          showSaved: event.savedEvents);
    } else if (event is ToggleEvent) {
      yield* _mapToggleEventToState(event);
    }
  }

  Stream<MainEventState> _mapToggleEventToState(
      ToggleEvent toggleEvent) async* {
    await eventRepository.togglePostSchedule(
      await userRepository.getUserDocumentId(),
      toggleEvent.eventId,
      toggleEvent.mainEventItem,
    );

    yield* _mapLoadMainEventsToState(
        toggleEvent.eventId, await userRepository.getUserDocumentId(),
        showSaved: state.showSavedEvents);
  }

  Stream<MainEventState> _mapLoadMainEventsToState(
      String eventId, String userId,
      {bool showSaved = false}) async* {
    yield state.copyWith(showSavedEvents: showSaved);

    final List<MainEventItem> events =
        await eventRepository.fetchScheduleFromEvent(eventId);
    final List<MainEventItem> savedEvents =
        await eventRepository.fetchScheduleFromUser(eventId, userId);

    final evensToShow =
        await _getEventsWithSavedArgument(showSaved, events, savedEvents);

    final List<MainEventDay> dayEvents =
        await eventRepository.getDaysFromMainEvent(evensToShow);
    yield MainEventState.loaded(showSaved, dayEvents);
  }

  Future<List<MainEventItem>> _getEventsWithSavedArgument(
    bool showSaved,
    List<MainEventItem> events,
    List<MainEventItem> savedEvents,
  ) async {
    if (showSaved) {
      for (int i = 0; i < savedEvents.length; i++) {
        final event = savedEvents[i];
        savedEvents[i] = event.copyWith(isSaved: true);
      }
    } else {
      for (int i = 0; i < events.length; i++) {
        final event = events[i];
        if (savedEvents.any((e2) => event.id == e2.id)) {
          events[i] = event.copyWith(isSaved: true);
        }
      }
    }
    return showSaved ? savedEvents : events;
  }
}
