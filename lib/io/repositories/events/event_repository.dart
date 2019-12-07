import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/general_info.dart';
import 'package:uhk_events/io/model/main_event.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';

abstract class EventRepository {
  Future<List<EventItem>> getEventList();

  Future<List<MainEvent>> fetchMainEvents();

  Future<List<ScheduledEvent>> fetchScheduleFromEvent(String eventId);

  Future<GeneralInfo> fetchGeneralInfo();

  Future<void> postSchedule(
      String userId, String eventId, ScheduledEvent event);

  Future<void> removeSchedule(
      String userId, String eventId, String scheduleEventId);
}
