import 'package:equatable/equatable.dart';
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
