import 'package:either_option/either_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/api/api_provider.dart';
import 'package:uhk_events/io/entities/main_event_item_entity.dart';
import 'package:uhk_events/io/firebase/firestore_provider.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/general_info.dart';
import 'package:uhk_events/io/model/main_event.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';
import 'package:uhk_events/util/error/failures.dart';
import 'package:uhk_events/util/network_info.dart';
import 'package:uhk_events/util/preference_manager.dart';

abstract class EventRepository {
  Future<Either<Failure, List<EventItem>>> getEventList();

  Future<List<MainEvent>> fetchMainEvents();

  Future<List<ScheduledEvent>> fetchScheduleFromEvent(String eventId);

  Future<GeneralInfo> fetchGeneralInfo();

  Future<void> postSchedule(
      String userId, String eventId, ScheduledEvent event);

  Future<void> removeSchedule(
      String userId, String eventId, String scheduleEventId);

  Future<bool> isMainEvent(String id);

  Future<List<MainEvent>> getMainEvents();

  Future<List<MainEventItemEntity>> getMainItemEvents();
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
  Future<List<MainEvent>> fetchMainEvents() {
    return firestoreProvider.fetchMainEvents();
  }

  @override
  Future<List<ScheduledEvent>> fetchScheduleFromEvent(String eventId) {
    return firestoreProvider.fetchScheduleFromEvent(eventId);
  }

  @override
  Future<List<MainEventItemEntity>> getMainItemEvents() {
    return localDataSource.getMainItemsEvents();
  }

  @override
  Future<Either<Failure, List<EventItem>>> getEventList() async {
    if (await networkInfo.isConnected) {
      final List<EventItem> response = await apiProvider.getEventList();
      if (response != null) {
        await localDataSource.putEvents(response);
        return Right(response);
      } else {
        return Left(ServerFailure());
      }
    } else {
      final List<EventItem> events = await localDataSource.getEvents();
      return Right(events);
    }
  }

  @override
  Future<void> postSchedule(
      String userId, String eventId, ScheduledEvent event) {
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
  Future<List<MainEvent>> getMainEvents() {
    return firestoreProvider.fetchMainEvents();
  }
}
