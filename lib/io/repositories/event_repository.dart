import 'package:either_option/either_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/date_formatter.dart';
import 'package:uhk_events/common/error/failures.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/common/managers/network_info.dart';
import 'package:uhk_events/common/managers/preference_manager.dart';
import 'package:uhk_events/io/api/api_provider.dart';
import 'package:uhk_events/io/entities/event_item_entity.dart';
import 'package:uhk_events/io/entities/main_event_item_entity.dart';
import 'package:uhk_events/io/firebase/firestore_provider.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/general_info.dart';
import 'package:uhk_events/io/model/main_event.dart';
import 'package:uhk_events/io/model/main_event_day.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';

abstract class EventRepository {
  Future<Either<Failure, List<EventItem>>> getEventList();

  Future<List<MainEventItem>> fetchScheduleFromEvent(String eventId);

  Future<GeneralInfo> fetchGeneralInfo();

  Future<void> postSchedule(String userId, String eventId, MainEventItem event);

  Future<void> togglePostSchedule(
      String userId, String eventId, MainEventItem event);

  Future<void> removeSchedule(
      String userId, String eventId, String scheduleEventId);

  Future<bool> isMainEvent(String id);

  Future<MainEvent> fetchMainEventInfo(String id);

  Future<void> saveMainItemsEvents(List<MainEventItemEntity> events);

  Future<List<MainEventDay>> getDaysFromMainEvent(
      List<MainEventItem> eventItemList);

  Future<List<MainEventItem>> fetchScheduleFromUser(
      String userId, String eventId);
}

class EventRepositoryImpl extends EventRepository {
  final ApiProvider apiProvider;
  final FirestoreProvider firestoreProvider;
  final AppPreferences localDataSource;
  final NetworkInfo networkInfo;

  EventRepositoryImpl(
      {@required this.apiProvider,
      @required this.firestoreProvider,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<GeneralInfo> fetchGeneralInfo() {
    return firestoreProvider.fetchGeneralInfo();
  }

  @override
  Future<List<MainEventItem>> fetchScheduleFromUser(
      String eventId, String userId) {
    return firestoreProvider.fetchScheduleFromUser(userId, eventId);
  }

  List<MainEventItemEntity> filterFromEvent(
      String eventId, List<MainEventItemEntity> entities) {
    return entities.where((entity) => entity.parentEventId == eventId).toList();
  }

  @override
  Future<Either<Failure, List<EventItem>>> getEventList() async {
    if (await networkInfo.isConnected) {
      final List<dynamic> response = await apiProvider.getEventList();

      final eventEntities =
          response.map((item) => EventItemEntity.fromJson(item)).toList();
      final mainEventsId = await firestoreProvider.fetchMainEvents();
      await _pairConferenceWithEvent(eventEntities, mainEventsId);

      if (response != null) {
        await localDataSource.putEvents(eventEntities);
        final List<EventItem> events = await _getEventsFromDatabase()
          ..sortedByDateDesc();

        return Right(events);
      } else {
        return Left(ServerFailure());
      }
    } else {
      final List<EventItem> events = await _getEventsFromDatabase();
      return Right(events);
    }
  }

  Future<void> _pairConferenceWithEvent(
      List<EventItemEntity> eventEntities, List<String> mainEventsId) async {
    for (int i = 0; i < mainEventsId.length; i++) {
      final eventId = mainEventsId[i];
      final EventItemEntity eventEntity = eventEntities
          .firstWhere((e) => e.id.toString() == eventId, orElse: () => null);

      if (eventEntity != null) {
        final index = eventEntities.indexOf(eventEntity);
        eventEntities[index] = eventEntity.update(isConference: true);
      }
    }
  }

  Future<List<EventItem>> _getEventsFromDatabase() async {
    final List<EventItemEntity> entities = await localDataSource.getEvents();
    return entities.fromEntityList();
  }

  @override
  Future<void> postSchedule(
      String userId, String eventId, MainEventItem event) {
    return firestoreProvider.postSchedule(userId, eventId, event);
  }

  @override
  Future<void> removeSchedule(
      String userId, String eventId, String scheduleEventId) {
    return firestoreProvider.removeSchedule(userId, eventId, scheduleEventId);
  }

  @override
  Future<bool> isMainEvent(String id) {
    return firestoreProvider.isConferenceType(id);
  }

  @override
  Future<MainEvent> fetchMainEventInfo(String id) {
    return firestoreProvider.fetchMainEventInfo(id);
  }

  @override
  Future<void> saveMainItemsEvents(List<MainEventItemEntity> events) async {
    return localDataSource.saveMainItemsEvents(events);
  }

  @override
  Future<List<MainEventDay>> getDaysFromMainEvent(
      List<MainEventItem> eventItemList) async {
    List<MainEventDay> dayEvents = [];

    if (eventItemList.isEmpty) return null;
    eventItemList.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));

    for (int i = 0; i < eventItemList.length; i++) {
      if (dayEvents.any((dayEvent) =>
          dayEvent.date.isSameDate(eventItemList[i].startDateTime))) {
        continue;
      } else {
        final DateTime day = eventItemList[i].startDateTime;
        dayEvents.add(
          _castToDayWithEvents(
            day,
            eventItemList,
          ),
        );
      }
    }

    return dayEvents;
  }

  /// Return [MainEventDay] with associated events that are in the same day
  MainEventDay _castToDayWithEvents(
      DateTime startDay, List<MainEventItem> events) {
    return MainEventDay(
        date: startDay,
        dayDate: format(dateTime: startDay, format: API_DATE_FORMAT_LOCALE),
        events:
            events.where((e) => e.startDateTime.isSameDate(startDay)).toList());
  }

  @override
  Future<void> togglePostSchedule(
      String userId, String eventId, MainEventItem event) {
    return event.isSaved
        ? removeSchedule(userId, eventId, event.id)
        : postSchedule(userId, eventId, event);
  }

  @override
  Future<List<MainEventItem>> fetchScheduleFromEvent(String eventId) {
    return firestoreProvider.fetchScheduleFromEvent(eventId);
  }
}

extension XDateTime on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  DateTime nextDay() => this.add(Duration(days: 1));
}
