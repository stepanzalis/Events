import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uhk_events/io/entities/main_event_item_entity.dart';

@immutable
class MainEventItem extends Equatable {
  final String id;
  final String title;
  final String detailImageUrl;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String description;
  final bool isSaved;
  final String place;

  MainEventItem(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.startDateTime,
      @required this.endDateTime,
      @required this.detailImageUrl,
      @required this.isSaved,
      @required this.place})
      : assert(title != null),
        assert(startDateTime != null);

  MainEventItem copyWith(
          {String id,
          String title,
          String backgroundUrl,
          DateTime date,
          String description,
          bool isSaved,
          String place}) =>
      MainEventItem(
          id: id ?? this.id,
          title: title ?? this.title,
          description: description ?? this.description,
          detailImageUrl: backgroundUrl ?? this.detailImageUrl,
          isSaved: isSaved ?? this.isSaved,
          startDateTime: date ?? this.startDateTime,
          endDateTime: date ?? this.endDateTime,
          place: place ?? this.place);

  static MainEventItem fromEntity(MainEventItemEntity entity) => MainEventItem(
      id: entity.id,
      title: entity.title ?? "",
      description: entity.description ?? "",
      detailImageUrl: entity.backgroundUrl ?? "",
      startDateTime: entity.startDateTime.toDate(),
      endDateTime: entity.endDateTime.toDate(),
      isSaved: entity.isChosen,
      place: entity.place ?? "");

  MainEventItemEntity toEntity() => MainEventItemEntity(
      id: id,
      title: title,
      isChosen: isSaved,
      description: description,
      startDateTime: Timestamp.fromMillisecondsSinceEpoch(
          startDateTime.millisecondsSinceEpoch),
      endDateTime: Timestamp.fromMillisecondsSinceEpoch(
          endDateTime.millisecondsSinceEpoch),
      place: place,
      backgroundUrl: detailImageUrl);

  @override
  List<Object> get props => [
        id,
        title,
        detailImageUrl,
        startDateTime,
        endDateTime,
        description,
        isSaved,
        place
      ];
}
