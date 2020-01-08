import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uhk_events/io/entities/wifi_info_entity.dart';

class GeneralInfoEntity extends Equatable {
  final WifiInfoEntity wifi;

  const GeneralInfoEntity({@required this.wifi});

  factory GeneralInfoEntity.fromSnapshot(DocumentSnapshot snap) {
    return GeneralInfoEntity(wifi: WifiInfoEntity.fromSnapshot(snap));
  }

  @override
  List<Object> get props => [wifi];
}
