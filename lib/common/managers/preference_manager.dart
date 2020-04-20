import 'package:hive/hive.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/io/entities/event_item_entity.dart';
import 'package:uhk_events/io/entities/main_event_item_entity.dart';

abstract class BasePreferences {
  void putEvents(List<EventItemEntity> events);

  void putToken(String token);

  void saveMainItemsEvents(List<MainEventItemEntity> events);

  void putUserDocumentId(String userDocumentId);

  void setDarkMode(bool enabled);

  void setNotifications(bool enabled);

  Future<String> getToken();

  Future<bool> getDarkMode();

  Future<List<EventItemEntity>> getEvents();

  Future<bool> isUserLoggedIn();

  Future<String> getUserDocumentId();

  Future<List<MainEventItemEntity>> getMainItemsEvents();
}

class AppPreferences with BasePreferences {
  @override
  void putEvents(List<EventItemEntity> events) async {
    final box = Hive.box<EventItemEntity>(Events);
    await box.clear();
    await box.addAll(events);
  }

  @override
  void putToken(String token) {
    Hive.box(Preferences)..put(ApiToken, token);
  }

  @override
  void putUserDocumentId(String userDocumentId) {
    Hive.box(Preferences)..put(UserDocumentId, userDocumentId);
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
  Future<String> getUserDocumentId() async {
    final Box box = await Hive.box(Preferences);
    return await box.get(UserDocumentId);
  }

  @override
  Future<List<EventItemEntity>> getEvents() async {
    final Box box = Hive.box<EventItemEntity>(Events);
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
    String userId = await getUserDocumentId();
    return (userId != null && userId.isNotEmpty);
  }

  @override
  Future<bool> getDarkMode() async {
    final Box box = await Hive.box(Preferences);
    return await box.get(DarkMode);
  }

  @override
  void setDarkMode(bool enabled) {
    Hive.box(Preferences)..put(DarkMode, enabled);
  }

  @override
  void setNotifications(bool enabled) {
    Hive.box(Preferences)..put(Notification, enabled);
  }
}
