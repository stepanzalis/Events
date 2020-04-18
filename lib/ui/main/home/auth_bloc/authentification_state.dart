import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class SplashScreen extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final String userId;
  Authenticated(this.userId);

  @override
  List<Object> get props => [userId];
}
