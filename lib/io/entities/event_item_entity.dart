import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/util/date_formatter.dart';

part 'event_item_entity.g.dart';

@immutable
@HiveType(typeId: 0)
class EventItemEntity extends HiveObject implements EquatableMixin {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String publishDate;

  @HiveField(2)
  final String singleEventStart;

  @HiveField(3)
  final String multipleEventStart;

  @HiveField(4)
  final String multipleEventEnd;

  @HiveField(5)
  final String facultyType;

  @HiveField(6)
  final String facultyTitle;

  @HiveField(7)
  final String eventUrl;

  @HiveField(8)
  final String eventTitle;

  @HiveField(9)
  final String eventTag;

  @HiveField(10)
  final bool isConference;

  EventItemEntity(
      {this.id,
      this.publishDate,
      this.singleEventStart,
      this.multipleEventStart,
      this.multipleEventEnd,
      this.facultyType,
      this.facultyTitle,
      this.eventUrl,
      this.eventTitle,
      this.eventTag,
      this.isConference});

  factory EventItemEntity.fromJson(Map<String, dynamic> json) =>
      EventItemEntity(
        id: json['id'],
        publishDate: json['publishDate'],
        singleEventStart: json['singleEventStart'],
        multipleEventEnd: json['multipleEventEnd'],
        multipleEventStart: json['multipleEventStart'],
        facultyTitle: json['facultyTitle'],
        facultyType: json['facultyType'],
        eventTag: json['eventTag'],
        eventTitle: json['eventTitle'],
        eventUrl: json['eventUrl'],
      );

  EventItemEntity update({
    bool isConference,
  }) {
    return copyWith(
        id: id,
        eventTag: eventTag,
        eventTitle: eventTitle,
        singleEventStart: singleEventStart,
        multipleEventStart: multipleEventStart,
        facultyType: facultyType,
        facultyTitle: facultyTitle,
        publishDate: publishDate,
        multipleEventEnd: multipleEventEnd,
        eventUrl: eventUrl,
        isConference: isConference);
  }

  EventItemEntity copyWith(
      {final int id,
      final String publishDate,
      final String singleEventStart,
      final String multipleEventStart,
      final String multipleEventEnd,
      final String facultyType,
      final String facultyTitle,
      final String eventUrl,
      final String eventTitle,
      final String eventTag,
      final bool isConference}) {
    return EventItemEntity(
        id: id ?? this.id,
        publishDate: publishDate ?? this.publishDate,
        facultyTitle: facultyTitle ?? this.facultyTitle,
        facultyType: facultyType ?? this.facultyType,
        multipleEventStart: multipleEventStart ?? this.multipleEventStart,
        multipleEventEnd: multipleEventEnd ?? this.multipleEventEnd,
        singleEventStart: singleEventStart ?? this.singleEventStart,
        eventUrl: eventUrl ?? this.eventUrl,
        eventTag: eventTag ?? this.eventTag,
        eventTitle: eventTitle ?? this.eventTitle,
        isConference: isConference ?? this.isConference);
  }

  @override
  String toString() =>
      'EventListEntity {id: $id, eventTitle: $eventTitle, eventTag: $eventTag, eventUrl: $eventUrl, facultyType: $facultyType, facultyTitle: $facultyTitle publishDate: $publishDate, singleEventStart: $singleEventStart, isConferece: $isConference }';

  String getEventTime() {
    if (this.multipleEventStart != null && this.multipleEventEnd != null) {
      return "${formatDate(this.multipleEventStart)} - ${formatDate(this.multipleEventEnd)}";
    } else {
      return formatDate(this.singleEventStart,
          fromFormat: API_DATE_FORMAT_LONGER);
    }
  }

  @override
  List<Object> get props => [
        publishDate,
        singleEventStart,
        multipleEventStart,
        multipleEventEnd,
        facultyType,
        facultyTitle,
        eventUrl,
        eventTitle,
        eventTag,
        isConference
      ];
}
