import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/common/managers/messaging_manager.dart';

import './bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final MessagingManager messagingManager;

  NotificationBloc({@required this.messagingManager});

  @override
  NotificationState get initialState => NotificationsInitial();

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is NotificationsAllowedPressed) {
      try {
        yield NotificationsLoading();
        await _saveNotificationValue();
        yield NotificationsSuccess();
      } catch (e) {
        yield NotificationsError();
      }
    }
  }

  _saveNotificationValue() async {
    await messagingManager.iOSNotificationPermission();
    await messagingManager.saveToken();
  }
}
