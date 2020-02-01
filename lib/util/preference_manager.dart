import 'package:hive/hive.dart';
import 'package:uhk_events/io/model/event_item.dart';

import 'constants.dart';

abstract class BasePreferences {
  void putEvents(List<EventItem> events);

  void putToken(String token);

  Future<String> getToken();

  Future<List<EventItem>> getEvents();

  Future<bool> isUserLoggedIn();
}

class AppPreferences with BasePreferences {
  @override
  void putEvents(List<EventItem> events) {
    Hive.box<EventItem>(Events)
      ..clear()
      ..addAll(events);
  }

  @override
  void putToken(String token) {
    Hive.box(Preferences)..get(ApiToken);
  }

  @override
  Future<String> getToken() async {
    Box box = await Hive.box(ApiToken);
    return await box.get(ApiToken);
  }

  @override
  Future<List<EventItem>> getEvents() async {
    final box = Hive.box<EventItem>(Events);
    final values = await box.values;
    return await values.toList();
  }

  @override
  Future<bool> isUserLoggedIn() async {
    String token = await getToken();
    return (token != null && token.isNotEmpty);
  }
}
