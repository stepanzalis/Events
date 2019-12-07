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
  final String user;
  Authenticated(this.user);

  @override
  List<Object> get props => [user];
}
