import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/main_event.dart';
import 'package:uhk_events/io/repositories/event_repository.dart';

import './bloc.dart';

class AboutInfoBloc extends Bloc<AboutInfoEvent, AboutInfoState> {
  final EventRepository eventRepository;

  AboutInfoBloc({@required this.eventRepository});

  @override
  AboutInfoState get initialState => AboutInfoState.empty();

  @override
  Stream<AboutInfoState> mapEventToState(
    AboutInfoEvent event,
  ) async* {
    if (event is LoadMainEventInfo) {
      yield* _mapLoadMainEventInfoToState(event.id);
    } else if (event is ToggleDescription) {
      yield* _mapToggleDescriptionToState(event.expanded);
    }
  }

  Stream<AboutInfoState> _mapLoadMainEventInfoToState(String id) async* {
    final MainEvent mainEvent = await eventRepository.fetchMainEventInfo(id);
    yield AboutInfoState.filled(
        mainEvent.title, mainEvent.infoAbout, mainEvent.date);
  }

  Stream<AboutInfoState> _mapToggleDescriptionToState(
      bool expandedValue) async* {
    yield state.update(expanded: expandedValue);
  }
}
