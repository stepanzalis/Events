import 'package:equatable/equatable.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/faculty.dart';

abstract class EventFilteredEvent extends Equatable {
  const EventFilteredEvent();
}

class UpdateFilter extends EventFilteredEvent {
  final Faculty faculty;

  const UpdateFilter(this.faculty);

  @override
  List<Object> get props => [faculty];

  @override
  String toString() => 'UpdateFilter { filter: $faculty }';
}

class UpdateEvents extends EventFilteredEvent {
  final List<EventItem> events;

  const UpdateEvents(this.events);

  @override
  List<Object> get props => [events];
}
