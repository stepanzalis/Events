import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uhk_events/io/entities/scheduled_event_entity.dart';

@immutable
class ScheduledEvent extends Equatable {
  final String id;
  final String title;
  final String detailImageUrl;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String description;
  final String place;

  ScheduledEvent(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.startDateTime,
      @required this.endDateTime,
      @required this.detailImageUrl,
      @required this.place})
      : assert(title != null),
        assert(startDateTime != null);

  ScheduledEvent copyWith(
          {String id,
          String title,
          String backgroundUrl,
          DateTime date,
          String description,
          String place}) =>
      ScheduledEvent(
          id: id ?? this.id,
          title: title ?? this.title,
          description: detailImageUrl ?? this.description,
          detailImageUrl: backgroundUrl ?? this.detailImageUrl,
          startDateTime: date ?? this.startDateTime,
          endDateTime: date ?? this.endDateTime,
          place: place ?? this.place);

  static ScheduledEvent fromEntity(ScheduledEventEntity entity) =>
      ScheduledEvent(
          id: entity.id,
          title: entity.title ?? "",
          description: entity.description ?? "",
          detailImageUrl: entity.detailImageUrl ?? "",
          startDateTime: entity.startDateTime.toDate(),
          endDateTime: entity.endDateTime.toDate(),
          place: entity.place ?? "");

  ScheduledEventEntity toEntity() => ScheduledEventEntity(
      id: id,
      title: title,
      description: description,
      startDateTime: Timestamp.fromMillisecondsSinceEpoch(
          startDateTime.millisecondsSinceEpoch),
      endDateTime: Timestamp.fromMillisecondsSinceEpoch(
          endDateTime.millisecondsSinceEpoch),
      place: place,
      detailImageUrl: detailImageUrl);

  @override
  List<Object> get props => [
        id,
        title,
        detailImageUrl,
        startDateTime,
        endDateTime,
        description,
        place
      ];
}
