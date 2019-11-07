import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uhk_events/io/entities/general_info_entity.dart';
import 'package:uhk_events/io/model/wifi_info.dart';

@immutable
class GeneralInfo extends Equatable {
  final WifiInfo wifi;

  GeneralInfo({@required this.wifi});
  GeneralInfo copyWith({WifiInfo info}) => GeneralInfo(wifi: wifi ?? this.wifi);

  static GeneralInfo fromEntity(GeneralInfoEntity entity) {
    return GeneralInfo(wifi: WifiInfo.fromEntity(entity.wifi));
  }

  @override
  String toString() => 'GeneralInfo { wifi: ${wifi.toString()}}';

  @override
  List<Object> get props => [wifi];
}
