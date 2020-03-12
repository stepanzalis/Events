import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/repositories/event_repository.dart';

import './bloc.dart';

class MainEventBloc extends Bloc<MainEventEvent, MainEventState> {
  final EventRepository eventRepository;

  MainEventBloc({@required this.eventRepository});

  @override
  MainEventState get initialState => MainEventState.loading();

  @override
  Stream<MainEventState> mapEventToState(
    MainEventEvent event,
  ) async* {
    if (event is LoadMainEvents) {
      yield* _mapLoadMainEventsToState(event.id);
    } else if (event is ToggleSavedEvents) {
      yield* _mapToggleSavedEventsToState(event.savedEvents);
    }
  }

  Stream<MainEventState> _mapLoadMainEventsToState(String id) async* {
    //TODO
  }

  Stream<MainEventState> _mapToggleSavedEventsToState(bool showSaved) async* {
    yield state.copyWith(isLoading: true, showSavedEvents: showSaved);
  }
}
