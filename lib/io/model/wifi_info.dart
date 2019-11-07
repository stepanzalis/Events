import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uhk_events/io/entities/wifi_info_entity.dart';

@immutable
class WifiInfo extends Equatable {
  final String ssid;
  final String password;

  WifiInfo({
    @required this.ssid,
    @required this.password,
  });

  WifiInfo copyWith({String id, String title}) =>
      WifiInfo(ssid: id ?? this.ssid, password: title ?? this.password);

  @override
  String toString() => 'WifiInfo { id: $ssid, password: $password}';

  static WifiInfo fromEntity(WifiInfoEntity entity) =>
      WifiInfo(ssid: entity.ssid, password: entity.password ?? "");

  @override
  List<Object> get props => [ssid, password];
}
