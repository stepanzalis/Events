import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/model/wifi_info.dart';
import 'package:uhk_events/io/repositories/info_repository.dart';

import './bloc.dart';

class InformationBloc
    extends Bloc<InformationNotificationEvent, InformationState> {
  final InfoRepository infoRepository;

  InformationBloc({@required this.infoRepository});

  @override
  InformationState get initialState => InformationState.initial();

  @override
  Stream<InformationState> mapEventToState(
    InformationNotificationEvent event,
  ) async* {
    if (event is GetCurrentSettings) {
      final WifiInfo wifiInfo = await infoRepository.fetchWifiInfo();
      final String versionName = await infoRepository.getAppVersionInfo();
      final bool notifications = await infoRepository.getNotificationsEnabled();
      final bool darkMode = await infoRepository.getNotificationsEnabled();

      yield state.copyWith(
          notificationsEnabled: notifications,
          darkMode: darkMode,
          appVersion: versionName,
          ssid: wifiInfo.ssid,
          password: wifiInfo.password);
    } else if (event is ChangedNotification) {
      yield state.copyWith(notificationsEnabled: event.allowed);
      await infoRepository.setNotificationEnabled(event.allowed);
    } else if (event is ChangedDarkMode) {
      yield state.copyWith(notificationsEnabled: event.darkMode);
      await infoRepository.setDarkModeEnabled(event.darkMode);
    }
  }
}
