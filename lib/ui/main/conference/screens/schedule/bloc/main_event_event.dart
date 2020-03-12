import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class MainEventEvent extends Equatable {
  const MainEventEvent();
}

class LoadMainEvents extends MainEventEvent {
  final String id;
  const LoadMainEvents({@required this.id});

  @override
  List<Object> get props => [id];
}

class ToggleSavedEvents extends MainEventEvent {
  final bool savedEvents;
  const ToggleSavedEvents({@required this.savedEvents});

  @override
  List<Object> get props => [savedEvents];
}
