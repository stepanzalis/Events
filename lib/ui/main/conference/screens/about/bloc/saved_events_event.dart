import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SavedEventsEvent extends Equatable {
  const SavedEventsEvent();

  @override
  List<Object> get props => [];
}

class StartObserving extends SavedEventsEvent {}

class StopObserving extends SavedEventsEvent {}

class LoadMyEvents extends SavedEventsEvent {
  final String eventId;
  const LoadMyEvents({@required this.eventId});
}
