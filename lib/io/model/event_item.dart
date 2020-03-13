import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/date_formatter.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';
import 'package:uhk_events/io/entities/event_item_entity.dart';
import 'package:uhk_events/io/model/faculty.dart';

@immutable
class EventItem extends Equatable {
  final int id;
  final String eventTime;
  final String eventStart;
  final String eventEnds;
  final Faculty faculty;
  final String eventTitle;
  final String eventTag;
  final bool multiDayEvent;
  final bool isConference;

  EventItem(
      {this.id,
      this.eventTime,
      this.eventStart,
      this.eventEnds,
      this.faculty,
      this.eventTitle,
      this.eventTag,
      this.isConference = false,
      this.multiDayEvent});

  EventItem update({
    bool isConference,
  }) {
    return copyWith(
        id: id,
        eventEnds: eventEnds,
        eventStart: eventStart,
        eventTime: eventTime,
        faculty: faculty,
        eventTag: eventTag,
        eventTitle: eventTitle,
        multiDayEvent: multiDayEvent,
        isConference: isConference);
  }

  EventItem copyWith(
      {final int id,
      final String eventTime,
      final String eventStart,
      final String eventEnds,
      final Faculty faculty,
      final String eventTitle,
      final String eventTag,
      final bool isConference,
      final bool multiDayEvent}) {
    return EventItem(
        id: id ?? this.id,
        eventStart: eventStart ?? this.eventStart,
        eventEnds: eventEnds ?? this.eventEnds,
        eventTag: eventTag ?? this.eventTag,
        eventTitle: eventTitle ?? this.eventTitle,
        faculty: faculty ?? this.faculty,
        multiDayEvent: multiDayEvent ?? this.multiDayEvent,
        eventTime: eventTime ?? this.eventTime,
        isConference: isConference ?? this.isConference);
  }

  static EventItem fromEntity(EventItemEntity entity) => EventItem(
      id: entity.id,
      multiDayEvent:
          entity.multipleEventStart != null && entity.multipleEventEnd != null,
      eventTime: entity.getEventTime(),
      eventStart: entity.multipleEventStart == null
          ? formatDate(entity.singleEventStart,
              fromFormat: API_DATE_FORMAT_LONGER)
          : formatDate(entity.multipleEventStart),
      eventEnds: entity.multipleEventEnd != null
          ? formatDate(entity.multipleEventEnd)
          : null,
      eventTag: entity.eventTag,
      eventTitle: entity.eventTitle,
      isConference: entity.isConference ?? false,
      faculty: entity.facultyType.getFaculty());

  @override
  String toString() {
    return 'EventItem{id: $id, eventTime: $eventTime, eventStart: $eventStart, eventEnds: $eventEnds, faculty: $faculty, eventTitle: $eventTitle, eventTag: $eventTag, multiDayEvent: $multiDayEvent, isConference: $isConference}';
  }

  @override
  List<Object> get props => [
        eventStart,
        eventEnds,
        faculty,
        eventTitle,
        eventTag,
        multiDayEvent,
        isConference,
        eventTime,
      ];
}
