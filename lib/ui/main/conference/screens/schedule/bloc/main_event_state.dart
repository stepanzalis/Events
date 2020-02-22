import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/main_event_day.dart';

abstract class MainEventState extends Equatable {
  const MainEventState();
}

class MainEventLoading extends MainEventState {
  @override
  List<Object> get props => [];
}

class MainEventLoaded extends MainEventState {
  final List<MainEventDay> dayEvents;

  const MainEventLoaded({@required this.dayEvents});

  @override
  List<Object> get props => [dayEvents];
}
