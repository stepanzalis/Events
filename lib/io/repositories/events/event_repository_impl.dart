import 'package:uhk_events/di/locator.dart';
import 'package:uhk_events/io/api/ApiProvider.dart';
import 'package:uhk_events/io/firebase/firestore_provider.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/general_info.dart';
import 'package:uhk_events/io/model/main_event.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';

import 'event_repository.dart';

class EventRepositoryImpl extends EventRepository {
  final ApiProvider _apiProvider = locator.get<ApiProvider>();
  final FirestoreProvider _firestoreProvider = locator.get<FirestoreProvider>();

  @override
  Future<GeneralInfo> fetchGeneralInfo() {
    return _firestoreProvider.fetchGeneralInfo();
  }

  @override
  Future<List<MainEvent>> fetchMainEvents() {
    return _firestoreProvider.fetchMainEvents();
  }

  @override
  Future<List<ScheduledEvent>> fetchScheduleFromEvent(String eventId) {
    return _firestoreProvider.fetchScheduleFromEvent(eventId);
  }

  @override
  Future<List<EventItem>> getEventList() {
    return _apiProvider.getEventList();
  }

  @override
  Future<void> postSchedule(String userId, String eventId, ScheduledEvent event) {
    return _firestoreProvider.postSchedule(userId, eventId, event);
  }

  @override
  Future<void> removeSchedule(String userId, String eventId, String scheduleEventId) {
    return _firestoreProvider.removeSchedule(userId, eventId, scheduleEventId);
  }
}
