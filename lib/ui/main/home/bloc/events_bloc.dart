import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/common/extensions/event_item_extensions.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/repositories/events/event_repository.dart';

import './bloc.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository repository;

  EventsBloc({@required this.repository});

  @override
  EventsState get initialState => EventsLoading();

  @override
  Stream<EventsState> mapEventToState(
    EventsEvent event,
  ) async* {
    if (event is LoadEvents) {
      yield* _mapLoadEventToState(repository);
    }
  }
}

Stream<EventsState> _mapLoadEventToState(EventRepository repository) async* {
  try {
    final List<EventItem> items = await repository.getEventList();
    yield EventsLoaded(items.sortedByDateDesc());
  } catch (_) {
    yield EventsNotLoaded();
  }
}
