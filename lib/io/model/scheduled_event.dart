import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uhk_events/io/entities/scheduled_event_entity.dart';

@immutable
class ScheduledEvent extends Equatable {
  final String id;
  final String title;
  final String detailImageUrl;
  final DateTime date;
  final String description;
  final String place;

  ScheduledEvent(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.date,
      @required this.detailImageUrl,
      @required this.place})
      : assert(title != null),
        assert(date != null);

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
          date: date ?? this.date,
          place: place ?? this.place);

  static ScheduledEvent fromEntity(ScheduledEventEntity entity) =>
      ScheduledEvent(
          id: entity.id,
          title: entity.title ?? "",
          description: entity.description ?? "",
          detailImageUrl: entity.detailImageUrl ?? "",
          date: entity.timestamp.toDate(),
          place: entity.place ?? "");

  ScheduledEventEntity toEntity() => ScheduledEventEntity(
      id: id,
      title: title,
      description: description,
      timestamp:
          Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch),
      place: place,
      detailImageUrl: detailImageUrl);

  @override
  String toString() =>
      'ScheduledEvent { id: $id, title: $title, backgroundUrl: $detailImageUrl, date: $date, infoAbout: $description, place: $place}';

  @override
  List<Object> get props =>
      [id, title, detailImageUrl, date, description, place];
}
