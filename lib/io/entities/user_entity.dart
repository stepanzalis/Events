import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UserEntity extends Equatable {
  final String id;
  final String firebaseToken;

  const UserEntity({@required this.id, @required this.firebaseToken});

  factory UserEntity.fromSnapshot(DocumentSnapshot snap) => UserEntity(
      id: snap.data['ID'], firebaseToken: snap.data['firebaseToken']);

  Map<String, Object> toDocument() {
    return {
      'ID': id,
      'firebaseToken': firebaseToken,
    };
  }

  @override
  String toString() => 'UserEntity{ id: $id, title: $firebaseToken}';

  @override
  List<Object> get props => [id, firebaseToken];
}
