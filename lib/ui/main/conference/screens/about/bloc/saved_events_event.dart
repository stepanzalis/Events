import 'package:equatable/equatable.dart';

abstract class SavedEventsEvent extends Equatable {
  const SavedEventsEvent();

  @override
  List<Object> get props => [];
}

class StartObserving extends SavedEventsEvent {}

class StopObserving extends SavedEventsEvent {}

class LoadMyEvents extends SavedEventsEvent {}
