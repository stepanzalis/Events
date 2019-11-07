import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/io/entities/event_item_entity.dart';
import 'package:uhk_events/util/date_formatter.dart';

@immutable
class EventItem extends Equatable {
  final int id;
  final String eventStart;
  final String eventEnds;
  final String facultyType;
  final String facultyTitle;
  final String eventTitle;
  final String eventTag;
  final bool multiDayEvent;

  EventItem(
      {this.id,
      this.eventStart,
      this.eventEnds,
      this.facultyType,
      this.facultyTitle,
      this.eventTitle,
      this.eventTag,
      this.multiDayEvent});

  EventItem copyWith() => EventItem(
        id: id ?? this.id,
        eventStart: eventStart ?? this.eventStart,
        eventEnds: eventEnds ?? this.eventEnds,
        eventTag: eventTag ?? this.eventTag,
        eventTitle: eventTitle ?? this.eventTitle,
        facultyTitle: facultyTitle ?? this.facultyTitle,
        facultyType: facultyType ?? this.facultyType,
        multiDayEvent: multiDayEvent ?? this.multiDayEvent,
      );

  static EventItem fromEntity(EventItemEntity entity) => EventItem(
      id: entity.id,
      multiDayEvent:
          entity.multipleEventStart != null && entity.multipleEventEnd != null,
      eventStart: entity.multipleEventStart == null
          ? formatDate(entity.singleEventStart,
              fromFormat: API_DATE_FORMAT_LONGER)
          : formatDate(entity.multipleEventStart),
      eventEnds: entity.multipleEventEnd != null
          ? formatDate(entity.multipleEventEnd)
          : null,
      eventTag: entity.eventTag,
      eventTitle: entity.eventTitle,
      facultyTitle: entity.facultyTitle,
      facultyType: entity.facultyType);

  @override
  String toString() {
    return 'EventItem {id: $id, eventTitle: $eventTitle, multipleDays: $multiDayEvent, eventTag: $eventTag, facultyType: $facultyType, facultyTitle: $facultyTitle }';
  }

  @override
  List<Object> get props => [
        eventStart,
        eventEnds,
        facultyType,
        facultyTitle,
        eventTitle,
        eventTag,
        multiDayEvent
      ];
}
