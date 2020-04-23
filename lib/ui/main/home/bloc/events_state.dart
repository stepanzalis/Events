import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/event_item.dart';

abstract class EventsState {
  const EventsState();
}

class EventsLoading extends EventsState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class EventsLoaded extends EventsState with EquatableMixin {
  final List<EventItem> events;

  EventsLoaded({@required this.events});

  @override
  List<Object> get props => [events];
}

class EventsNotLoaded extends EventsState with EquatableMixin {
  @override
  List<Object> get props => [];
}
