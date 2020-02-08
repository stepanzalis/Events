import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/entities/main_event_item_entity.dart';

class SavedEvent extends Equatable {
  final String title;
  final String place;
  final String timeLeft;

  SavedEvent(
      {@required this.title, @required this.place, @required this.timeLeft});

  factory SavedEvent.fromEntity(MainEventItemEntity entity) {
    return SavedEvent(
        title: entity.title,
        place: entity.place,
        timeLeft: DateTime.now()
            .difference(DateTime.fromMillisecondsSinceEpoch(
                entity.startDateTime.millisecondsSinceEpoch * 1000))
            .inMinutes
            .toString());
  }

  @override
  List<Object> get props => [title, place, timeLeft];
}
