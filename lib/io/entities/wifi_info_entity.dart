import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class WifiInfoEntity extends Equatable {
  final String ssid;
  final String password;

  const WifiInfoEntity({@required this.ssid, @required this.password});

  factory WifiInfoEntity.fromDocument(DocumentSnapshot doc) =>
      WifiInfoEntity(ssid: doc.data['SSID'], password: doc.data['password']);

  @override
  String toString() => 'WifiEntity{ id: $ssid, title: $password}';

  @override
  List<Object> get props => [ssid, password];
}
