import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:uhk_events/util/constants.dart';
import 'package:uhk_events/util/preference_manager.dart';

import './bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationsAllowed> {
  @override
  NotificationsAllowed get initialState => NotificationsAllowed.initial();

  @override
  Stream<NotificationsAllowed> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is ToggleNotifications) {
      _saveNotificationValue(event.value);

      if (event.value) {
        yield NotificationsAllowed.enabled();
      } else
        yield NotificationsAllowed.disabled();
    }
  }
}

_saveNotificationValue(bool value) async {
  await PreferenceManager().openBox(preferences)
    ..put(notifications, value);
}
