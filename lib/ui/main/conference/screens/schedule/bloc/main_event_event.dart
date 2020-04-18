import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';

abstract class MainEventEvent extends Equatable {
  const MainEventEvent();
}

class LoadMainEvents extends MainEventEvent {
  final String eventId;

  const LoadMainEvents({@required this.eventId});

  @override
  List<Object> get props => [eventId];
}

class ToggleSavedEvents extends MainEventEvent {
  final bool savedEvents;
  final String eventId;

  const ToggleSavedEvents({@required this.savedEvents, @required this.eventId});

  @override
  List<Object> get props => [savedEvents, eventId];
}

class ToggleEvent extends MainEventEvent {
  final MainEventItem mainEventItem;
  final String eventId;

  const ToggleEvent({@required this.mainEventItem, @required this.eventId});

  @override
  List<Object> get props => [mainEventItem, eventId];

  @override
  String toString() {
    return 'ToggleEvent{mainEventItem: $mainEventItem, eventId: $eventId}';
  }
}
