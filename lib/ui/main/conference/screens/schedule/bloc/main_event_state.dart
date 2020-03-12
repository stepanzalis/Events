import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/main_event_day.dart';

@immutable
class MainEventState {
  final bool isLoading;
  final bool showSavedEvents;
  final List<MainEventDay> dayEvents;

  MainEventState(
      {@required this.isLoading,
      @required this.dayEvents,
      @required this.showSavedEvents});

  factory MainEventState.loading() {
    return MainEventState(
        isLoading: true, showSavedEvents: false, dayEvents: []);
  }

  factory MainEventState.loaded(bool showSaved, List<MainEventDay> events) {
    return MainEventState(
        isLoading: false, showSavedEvents: showSaved, dayEvents: events);
  }

  MainEventState copyWith(
      {bool isLoading, bool showSavedEvents, List<MainEventDay> dayEvents}) {
    return MainEventState(
      isLoading: isLoading ?? this.isLoading,
      showSavedEvents: showSavedEvents ?? this.showSavedEvents,
      dayEvents: dayEvents ?? this.dayEvents,
    );
  }

  @override
  String toString() {
    return 'MainEventState{isLoading: $isLoading, showSavedEvents: $showSavedEvents, dayEvents: $dayEvents}';
  }
}
