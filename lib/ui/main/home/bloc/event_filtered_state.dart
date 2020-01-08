import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/faculty.dart';

abstract class EventFilteredState {
  const EventFilteredState();
}

class FilteredEventsLoading extends EventFilteredState {}

class FilteredEventsLoaded extends EventFilteredState with EquatableMixin {
  final List<EventItem> events;
  final List<Faculty> faculties;

  FilteredEventsLoaded(
    this.events,
    this.faculties,
  );

  @override
  List<Object> get props => [events, faculties];

  @override
  String toString() {
    return 'FilteredEventsLoaded { activeFilter: $faculties }';
  }
}

class EventModalDetail extends EventFilteredState {
  final EventItem item;

  EventModalDetail({@required this.item});

  @override
  String toString() => 'EventModalDetail{event: $item}';
}

class EventConferenceTypeDetail extends EventFilteredState {
  final String id;

  const EventConferenceTypeDetail({@required this.id});

  @override
  String toString() => 'EventConferenceTypeDetail{event: $id}';
}
