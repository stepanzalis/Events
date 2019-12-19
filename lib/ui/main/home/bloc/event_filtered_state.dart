import 'package:equatable/equatable.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/faculty.dart';

abstract class EventFilteredState extends Equatable {
  const EventFilteredState();
}

class FilteredEventsLoading extends EventFilteredState {

  @override
  List<Object> get props => [];
}

class FilteredEventsLoaded extends EventFilteredState {
  final List<EventItem> events;
  final List<Faculty> faculties;

  const FilteredEventsLoaded(
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
