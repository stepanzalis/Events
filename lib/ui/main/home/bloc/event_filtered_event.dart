import 'package:equatable/equatable.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/faculty.dart';

abstract class EventFilteredEvent {
  const EventFilteredEvent();
}

class UpdateFilter extends EventFilteredEvent {
  final Faculty faculty;

  const UpdateFilter(this.faculty);

  @override
  String toString() => 'UpdateFilter { filter: $faculty }';
}

class UpdateEvents extends EventFilteredEvent with EquatableMixin{
  final List<EventItem> events;

  UpdateEvents(this.events);

  @override
  List<Object> get props => [events];
}

class GetEventDetail extends EventFilteredEvent {
  final EventItem item;

  const GetEventDetail(this.item);

  @override
  List<Object> get props => [item];
}


