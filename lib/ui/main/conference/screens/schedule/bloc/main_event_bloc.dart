import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/repositories/event_repository.dart';

import './bloc.dart';

class MainEventBloc extends Bloc<MainEventEvent, MainEventState> {
  final EventRepository eventRepository;
  MainEventBloc({@required this.eventRepository});

  @override
  MainEventState get initialState => InitialMainEventState();

  @override
  Stream<MainEventState> mapEventToState(
    MainEventEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
