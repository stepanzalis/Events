import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoggedIn';
}

class SkippedAuth extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SkippedAuth';
}
