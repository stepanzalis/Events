import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/repositories/user/user_repository.dart';

import 'auth_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository});

  @override
  AuthenticationState get initialState => SplashScreen();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else {
      yield* _mapLoggedInToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await userRepository.isSignedIn();
      if (isSignedIn) {
        final userId = await userRepository.getUserId();
        yield Authenticated(userId);
      } else {
        userRepository.signInAnonymously();
        yield Uninitialized();
      }
    } catch (e) {
      yield Uninitialized();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await userRepository.getUserId());
  }
}
