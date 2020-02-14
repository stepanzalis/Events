import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uhk_events/io/entities/main_event_entity.dart';
import 'package:uhk_events/util/date_formatter.dart';

@immutable
class MainEvent extends Equatable {
  final String id;
  final String title;
  final String backgroundUrl;
  final String date;
  final String infoAbout;
  final bool active;

  MainEvent(
      {@required this.id,
      @required this.title,
      @required this.backgroundUrl,
      @required this.date,
      @required this.infoAbout,
      @required this.active})
      : assert(title != null, date != null);

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
          date: date ?? this.date,
          active: active ?? this.active);

  @override
  String toString() =>
      'MainEvent { id: $id, title: $title, infoAbout: $infoAbout, backgroundUrl: $backgroundUrl, startDate: $date, active: $active}';

  static MainEvent fromEntity(MainEventEntity entity) => MainEvent(
        id: entity.id,
        title: entity.title,
        backgroundUrl: entity.backgroundUrl,
        date:
            dateFromTimestamp(entity.startDate.toDate().millisecondsSinceEpoch),
        infoAbout: entity.infoAbout,
        active: entity.active ?? false,
      );

  @override
  List<Object> get props => [id, title, backgroundUrl, date, infoAbout, active];
}
