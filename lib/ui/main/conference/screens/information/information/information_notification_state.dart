import 'package:flutter/cupertino.dart';

@immutable
class InformationState {
  final bool notificationsEnabled;
  final bool darkMode;
  final String appVersion;
  final String ssid;
  final String password;

  InformationState({
    @required this.notificationsEnabled,
    @required this.darkMode,
    @required this.appVersion,
    @required this.ssid,
    @required this.password,
  });

  factory InformationState.initial(
      {bool allowed = false,
      bool darkMode = false,
      String appVersion = "",
      String ssid = "",
      String password = ""}) {
    return InformationState(
        notificationsEnabled: allowed,
        darkMode: darkMode,
        password: password,
        ssid: ssid,
        appVersion: appVersion);
  }

  InformationState copyWith({
    bool notificationsEnabled,
    bool darkMode,
    String appVersion,
    String ssid,
    String password,
  }) {
    return InformationState(
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        darkMode: darkMode ?? this.darkMode,
        ssid: ssid ?? this.ssid,
        password: password ?? this.password,
        appVersion: appVersion ?? this.appVersion);
  }
}
