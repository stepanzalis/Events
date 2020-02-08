import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/faculty.dart';

abstract class EventFilteredState {
  const EventFilteredState();
}

class FilteredEventsLoading extends EventFilteredState {}

class FilteredEventsError extends EventFilteredState {}

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

class EventConferenceDetail extends EventFilteredState {
  final String id;
  final Faculty faculty;

  EventConferenceDetail({@required this.id, @required this.faculty});

  @override
  String toString() {
    return 'EventConferenceDetail{id: $id, faculty: $faculty}';
  }
}
