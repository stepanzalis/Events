import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/saved_event.dart';

abstract class SavedEventsState extends Equatable {
  const SavedEventsState();
}

class EmptyList extends SavedEventsState {
  @override
  List<Object> get props => [];
}

class EventsLoaded extends SavedEventsState {
  final List<SavedEvent> events;
  const EventsLoaded({@required this.events});

  @override
  List<Object> get props => [];
}
