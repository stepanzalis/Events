import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/util/messaging_manager.dart';

import './bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final MessagingManager messagingManager;

  NotificationBloc({@required this.messagingManager});

  @override
  NotificationState get initialState => NotificationState.initial();

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is ToggleNotifications) {
      if (event.allowed) {
        _saveNotificationValue(event.allowed);
        yield NotificationState.enabled();
      } else {
        yield NotificationState.disabled();
      }
    }
  }

  _saveNotificationValue(bool allowed) async {
    if (allowed) {
      await messagingManager.saveToken();
    }
  }
}
