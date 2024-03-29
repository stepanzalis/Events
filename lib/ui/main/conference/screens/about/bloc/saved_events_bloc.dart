import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/entities/main_event_item_entity.dart';
import 'package:uhk_events/io/model/saved_event.dart';
import 'package:uhk_events/io/repositories/event_repository.dart';
import 'package:uhk_events/ui/main/conference/screens/about/bloc/ticker.dart';

import './bloc.dart';

class SavedEventsBloc extends Bloc<SavedEventsEvent, SavedEventsState> {
  StreamSubscription<int> _minuteSubscription;

  final Ticker ticker;
  final EventRepository eventRepository;

  SavedEventsBloc({@required this.ticker, @required this.eventRepository});

  @override
  SavedEventsState get initialState => EmptyList();

  @override
  Stream<SavedEventsState> mapEventToState(
    SavedEventsEvent event,
  ) async* {
    if (event is LoadMyEvents) {
      // yield* _mapLoadEventsToState(event.eventId);
    } else if (event is StopObserving) {
      // _mapStopObservingToState();
    }
  }

  Future<List<SavedEvent>> _mapMainItemEventToOverview(
      List<MainEventItemEntity> events) async {
    return events.map((e) => SavedEvent.fromEntity(e)).toList();
  }

  Stream<SavedEventsState> _mapStartObservingToState(String eventId) async* {
    await _minuteSubscription?.cancel();
    _minuteSubscription = ticker.tick().listen((duration) => add(
          LoadMyEvents(eventId: eventId),
        ));
  }

  Stream<SavedEventsState> _mapStopObservingToState() async* {
    _minuteSubscription == null ? null : await _minuteSubscription?.pause();
  }

  @override
  Future<void> close() {
    _minuteSubscription?.cancel();
    return super.close();
  }
}
