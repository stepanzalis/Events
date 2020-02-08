import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uhk_events/io/entities/main_event_entity.dart';

@immutable
class MainEvent extends Equatable {
  final String id;
  final String title;
  final String backgroundUrl;
  final DateTime startDate;
  final DateTime endDate;
  final String infoAbout;
  final bool active;

  MainEvent(
      {@required this.id,
      @required this.title,
      @required this.backgroundUrl,
      @required this.startDate,
      @required this.endDate,
      @required this.infoAbout,
      @required this.active})
      : assert(title != null, startDate != null);

  MainEvent copyWith(
          {String id,
          String title,
          String infoAbout,
          String backgroundUrl,
          DateTime date,
          bool active}) =>
      MainEvent(
          id: id ?? this.id,
          title: title ?? this.title,
          infoAbout: infoAbout ?? this.infoAbout,
          backgroundUrl: backgroundUrl ?? this.backgroundUrl,
          startDate: startDate ?? this.startDate,
          endDate: endDate ?? this.endDate,
          active: active ?? this.active);

  @override
  String toString() =>
      'MainEvent { id: $id, title: $title, infoAbout: $infoAbout, backgroundUrl: $backgroundUrl, startDate: $startDate, active: $active}';

  static MainEvent fromEntity(MainEventEntity entity) => MainEvent(
        id: entity.id,
        title: entity.title,
        backgroundUrl: entity.backgroundUrl,
        startDate: entity.startDate.toDate(),
        endDate: entity.endDate.toDate(),
        infoAbout: entity.infoAbout,
        active: entity.active ?? false,
      );

  @override
  List<Object> get props =>
      [id, title, backgroundUrl, startDate, endDate, infoAbout, active];
}
