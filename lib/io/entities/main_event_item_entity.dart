import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'main_event_item_entity.g.dart';

@HiveType(typeId: 2)
class MainEventItemEntity extends HiveObject implements EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String backgroundUrl;

  //@HiveField(3)
  final Timestamp startDateTime;

  //@HiveField(4)
  final Timestamp endDateTime;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final bool isChosen;

  @HiveField(7)
  final String place;

  MainEventItemEntity(
      {@required this.id,
      @required this.title,
      @required this.place,
      @required this.backgroundUrl,
      @required this.startDateTime,
      @required this.endDateTime,
      @required this.description,
      @required this.isChosen});

  factory MainEventItemEntity.fromSnapshot(DocumentSnapshot snap) =>
      MainEventItemEntity(
          id: snap.data['ID'],
          title: snap.data['title'],
          backgroundUrl: snap.data['detailImageUrl'] ?? "",
          startDateTime: snap.data['startDateTime'],
          endDateTime: snap.data['endDateTime'],
          place: snap.data['place'],
          description: snap.data['description'] ?? "",
          isChosen: false);

  @override
  List<Object> get props => [
        id,
        title,
        description,
        backgroundUrl,
        startDateTime,
        endDateTime,
        endDateTime,
        isChosen
      ];
}
