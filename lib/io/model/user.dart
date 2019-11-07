import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uhk_events/io/entities/user_entity.dart';

@immutable
class User extends Equatable {
  final String id;
  final String firebaseToken;

  User({
    @required this.id,
    @required this.firebaseToken,
  });

  User copyWith({String id, String title}) =>
      User(id: id ?? this.id, firebaseToken: title ?? this.firebaseToken);

  @override
  String toString() => 'User { id: $id, title: $firebaseToken}';

  static User fromEntity(UserEntity entity) =>
      User(id: entity.id, firebaseToken: entity.firebaseToken ?? "");

  @override
  List<Object> get props => [id, firebaseToken];
}
