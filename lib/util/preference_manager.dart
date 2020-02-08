import 'package:hive/hive.dart';
import 'package:uhk_events/io/entities/main_event_item_entity.dart';
import 'package:uhk_events/io/model/event_item.dart';

import 'constants.dart';

abstract class BasePreferences {
  void putEvents(List<EventItem> events);

  void putToken(String token);

  void saveMainItemsEvents(List<MainEventItemEntity> events);

  Future<String> getToken();

  Future<List<EventItem>> getEvents();

  Future<bool> isUserLoggedIn();

  Future<List<MainEventItemEntity>> getMainItemsEvents();
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
    Hive.box(Preferences)..put(ApiToken, token);
  }

  @override
  void saveMainItemsEvents(List<MainEventItemEntity> events) {
    Hive.box<MainEventItemEntity>(MainItemEvents)
      ..clear()
      ..addAll(events);
  }

  @override
  Future<String> getToken() async {
    final Box box = await Hive.box(Preferences);
    return await box.get(ApiToken);
  }

  @override
  Future<List<EventItem>> getEvents() async {
    final Box box = Hive.box<EventItem>(Events);
    final values = await box.values;
    return await values.toList();
  }

  @override
  Future<List<MainEventItemEntity>> getMainItemsEvents() async {
    final Box box = Hive.box<MainEventItemEntity>(MainItemEvents);
    final values = await box.values;
    return await values.toList();
  }

  @override
  Future<bool> isUserLoggedIn() async {
    String token = await getToken();
    return (token != null && token.isNotEmpty);
  }
}
