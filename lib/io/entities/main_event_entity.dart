import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MainEventEntity extends Equatable {
  final String id;
  final String title;
  final String backgroundUrl;
  final Timestamp date;
  final String infoAbout;
  final bool active;

  MainEventEntity(
      {@required this.id,
      @required this.title,
      @required this.backgroundUrl,
      @required this.date,
      @required this.infoAbout,
      @required this.active});

  factory MainEventEntity.fromSnapshot(DocumentSnapshot snap) =>
      MainEventEntity(
          id: snap.data['ID'],
          title: snap.data['title'],
          backgroundUrl: snap.data['backgroundUrl'] ?? "",
          date: snap.data['date'],
          infoAbout: snap.data['infoAbout'] ?? "",
          active: snap.data['isActive'] ?? false);

  @override
  String toString() =>
      'MainEventEntity{ id: $id, title: $title, infoAbout: $infoAbout, backgroundUrl: $backgroundUrl, date: $date, active: $active}';

  @override
  List<Object> get props => [id, title, infoAbout, backgroundUrl, date, active];
}
