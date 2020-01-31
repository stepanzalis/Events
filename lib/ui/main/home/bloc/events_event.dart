import 'package:equatable/equatable.dart';
import 'package:uhk_events/io/model/faculty.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
}

class LoadEvents extends EventsEvent {
  @override
  List<Object> get props => [];
}

class ToggleFaculty extends EventsEvent {
  final Faculty faculty;

  const ToggleFaculty(this.faculty);

  @override
  List<Object> get props => [faculty];
}
