import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ScheduledEventEntity extends Equatable {
  final String id;
  final String title;
  final String detailImageUrl;
  final Timestamp timestamp;
  final String description;
  final String place;

  const ScheduledEventEntity(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.timestamp,
      @required this.detailImageUrl,
      @required this.place});

  factory ScheduledEventEntity.fromSnapshot(DocumentSnapshot snap) =>
      ScheduledEventEntity(
          id: snap.data['ID'],
          title: snap.data['title'],
          detailImageUrl: snap.data['detailImageUrl'] ?? "",
          timestamp: snap.data['date'],
          description: snap.data['description'] ?? "",
          place: snap.data['place'] ?? "");

  Map<String, Object> toDocument() {
    return {
      'ID': id,
      'title': title,
      'detailImageUrl': detailImageUrl,
      'date': timestamp,
      'description': description,
      'place': place
    };
  }

  @override
  String toString() =>
      'ScheduledEventEntity{ id: $id, title: $title, description: $description, detailImageUrl: $detailImageUrl, date: $timestamp, place: $place}';

  @override
  List<Object> get props =>
      [id, title, description, detailImageUrl, timestamp, place];
}
