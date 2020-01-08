import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/api/ApiProvider.dart';
import 'package:uhk_events/io/firebase/firestore_provider.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/general_info.dart';
import 'package:uhk_events/io/model/main_event.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';

import 'event_repository.dart';

class EventRepositoryImpl with EventRepository {

  final ApiProvider apiProvider;
  final FirestoreProvider firestoreProvider;

  const EventRepositoryImpl({@required this.apiProvider, @required this.firestoreProvider});

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
  Future<List<EventItem>> getEventList() {
    return apiProvider.getEventList();
  }

  @override
  Future<void> postSchedule(String userId, String eventId, ScheduledEvent event) {
    return firestoreProvider.postSchedule(userId, eventId, event);
  }

  @override
  Future<void> removeSchedule(String userId, String eventId, String scheduleEventId) {
    return firestoreProvider.removeSchedule(userId, eventId, scheduleEventId);
  }

  @override
  Future<bool> isMainEvent(int id) {
    return firestoreProvider.isConferenceType(id);
  }
}
