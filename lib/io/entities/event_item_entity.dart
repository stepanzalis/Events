import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/util/date_formatter.dart';

@immutable
class EventItemEntity extends Equatable {
  final int id;
  final String publishDate;
  final String singleEventStart;
  final String multipleEventStart;
  final String multipleEventEnd;
  final String facultyType;
  final String facultyTitle;
  final String eventUrl;
  final String eventTitle;
  final String eventTag;

  const EventItemEntity(
      {this.id,
      this.publishDate,
      this.singleEventStart,
      this.multipleEventStart,
      this.multipleEventEnd,
      this.facultyType,
      this.facultyTitle,
      this.eventUrl,
      this.eventTitle,
      this.eventTag});

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

  @override
  String toString() =>
      'EventListEntity {id: $id, eventTitle: $eventTitle, eventTag: $eventTag, eventUrl: $eventUrl, facultyType: $facultyType, facultyTitle: $facultyTitle publishDate: $publishDate, singleEventStart: $singleEventStart }';

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
        eventTag
      ];
}
