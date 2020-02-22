import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';

@immutable
class MainEventDay extends Equatable {
  final String dayDate;
  final List<MainEventItem> events;

  MainEventDay({@required this.dayDate, @required this.events})
      : assert(dayDate != null, "$dayDate must not be null or empty"),
        assert(events != null,
            "$events must not be null, provide empty list if no events scheduled");

  @override
  List<Object> get props => [dayDate, events];
}
