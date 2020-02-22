import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class MainEventEvent extends Equatable {
  const MainEventEvent();
}

class LoadMainEvents extends MainEventEvent {
  final String id;
  final bool savedEvents;
  const LoadMainEvents({@required this.id, this.savedEvents = false});

  @override
  List<Object> get props => [id, savedEvents];
}
