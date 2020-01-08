import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/util/constants.dart';
import 'package:uhk_events/util/preference_manager.dart';

import './bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationsAllowed> {
  final PreferenceManager manager;

  NotificationBloc({@required this.manager});

  @override
  NotificationsAllowed get initialState => NotificationsAllowed.initial();

  @override
  Stream<NotificationsAllowed> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is ToggleNotifications) {
      _saveNotificationValue(event.allowed);

      if (event.allowed) {
        yield NotificationsAllowed.enabled();
      } else
        yield NotificationsAllowed.disabled();
    }
  }

  _saveNotificationValue(bool value) async {
    await manager.openBox(preferences)
      ..put(notifications, value);
  }
}
