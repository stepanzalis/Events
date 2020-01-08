import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MainEventEntity extends Equatable {
  final String id;
  final String title;
  final String backgroundUrl;
  final Timestamp startDate;
  final Timestamp endDate;
  final String infoAbout;
  final bool active;

  const MainEventEntity(
      {@required this.id,
      @required this.title,
      @required this.backgroundUrl,
      @required this.startDate,
      @required this.endDate,
      @required this.infoAbout,
      @required this.active});

  factory MainEventEntity.fromSnapshot(DocumentSnapshot snap) =>
      MainEventEntity(
          id: snap.data['ID'],
          title: snap.data['title'],
          backgroundUrl: snap.data['backgroundUrl'] ?? "",
          startDate: snap.data['startDate'],
          endDate: snap.data['endDate'],
          infoAbout: snap.data['infoAbout'] ?? "",
          active: snap.data['isActive'] ?? false);


  @override
  String toString() {
    return 'MainEventEntity{id: $id, title: $title, backgroundUrl: $backgroundUrl, startDate: $startDate, endDate: $endDate, infoAbout: $infoAbout, active: $active}';
  }

  @override
  List<Object> get props => [id, title, infoAbout, backgroundUrl, startDate, active];
}
