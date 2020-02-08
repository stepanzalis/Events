import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ScheduledEventEntity extends Equatable {
  final String id;
  final String title;
  final String detailImageUrl;
  final Timestamp startDateTime;
  final Timestamp endDateTime;
  final String description;
  final String place;

  const ScheduledEventEntity(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.startDateTime,
      @required this.endDateTime,
      @required this.detailImageUrl,
      @required this.place});

  factory ScheduledEventEntity.fromSnapshot(DocumentSnapshot snap) =>
      ScheduledEventEntity(
          id: snap.data['ID'],
          title: snap.data['title'],
          detailImageUrl: snap.data['detailImageUrl'] ?? "",
          startDateTime: snap.data['startDateTime'],
          endDateTime: snap.data['endDateTime'],
          description: snap.data['description'] ?? "",
          place: snap.data['place'] ?? "");

  Map<String, Object> toDocument() {
    return {
      'ID': id,
      'title': title,
      'detailImageUrl': detailImageUrl,
      'startDateTime': startDateTime,
      'endDateTime': endDateTime,
      'description': description,
      'place': place
    };
  }

  @override
  String toString() {
    return 'ScheduledEventEntity{id: $id, title: $title, detailImageUrl: $detailImageUrl, startDateTime: $startDateTime, endDateTime: $endDateTime, description: $description, place: $place}';
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        detailImageUrl,
        startDateTime,
        endDateTime,
        place
      ];
}
