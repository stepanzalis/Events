import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/repositories/event_repository.dart';

import './bloc.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository repository;

  EventsBloc({@required this.repository});

  @override
  EventsState get initialState => EventsLoading();

  @override
  Stream<EventsState> mapEventToState(EventsEvent event) async* {
    if (event is LoadEvents) {
      yield* _mapLoadEventToState();
    }
  }

  Stream<EventsState> _mapLoadEventToState() async* {
    yield EventsLoading();
    final itemsOrError = await repository.getEventList();
    yield itemsOrError.fold(
      (failure) => EventsNotLoaded(),
      (response) =>
          response.isEmpty ? EventsNotLoaded() : EventsLoaded(response),
    );
  }
}
