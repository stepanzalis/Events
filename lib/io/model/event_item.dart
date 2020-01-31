import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';
import 'package:uhk_events/io/entities/event_item_entity.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/util/date_formatter.dart';

part 'event_item.g.dart';

@HiveType(typeId: 0)
class EventItem extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String eventTime;

  @HiveField(2)
  final String eventStart;

  @HiveField(3)
  final String eventEnds;

  @HiveField(4)
  final Faculty faculty;

  @HiveField(5)
  final String eventTitle;

  @HiveField(6)
  final String eventTag;

  @HiveField(7)
  final bool multiDayEvent;

  @HiveField(8)
  final bool isConference;

  EventItem(
      {this.id,
      this.eventTime,
      this.eventStart,
      this.eventEnds,
      this.faculty,
      this.eventTitle,
      this.eventTag,
      this.isConference,
      this.multiDayEvent});

  EventItem copyWith() => EventItem(
        id: id ?? this.id,
        eventStart: eventStart ?? this.eventStart,
        eventEnds: eventEnds ?? this.eventEnds,
        eventTag: eventTag ?? this.eventTag,
        eventTitle: eventTitle ?? this.eventTitle,
        faculty: faculty ?? this.faculty,
        multiDayEvent: multiDayEvent ?? this.multiDayEvent,
        eventTime: eventTime ?? this.eventTime,
        isConference: isConference ?? this.isConference,
      );

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
