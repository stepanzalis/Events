import 'package:equatable/equatable.dart';

abstract class SavedEventsEvent extends Equatable {
  const SavedEventsEvent();
}

class StartObserving extends SavedEventsEvent {
  @override
  List<Object> get props => null;
}

class StopObserving extends SavedEventsEvent {
  @override
  List<Object> get props => null;
}

class LoadMyEvents extends SavedEventsEvent {
  @override
  List<Object> get props => null;
}
