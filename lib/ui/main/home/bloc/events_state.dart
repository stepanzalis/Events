import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/event_item.dart';

@immutable
abstract class EventsState extends Equatable {
  const EventsState();
}

class EventsLoading extends EventsState {
  @override
  List<Object> get props => [];
}

class EventsLoaded extends EventsState {

  final List<EventItem> events;
  const EventsLoaded(this.events);

  @override
  List<Object> get props => [events];
}

class EventsNotLoaded extends EventsState {
  @override
  List<Object> get props => [];
}