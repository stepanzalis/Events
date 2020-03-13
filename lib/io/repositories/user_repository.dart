import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/firebase/firebase_auth_provider.dart';
import 'package:uhk_events/util/managers/network_info.dart';

abstract class UserRepository {
  Future<void> signInAnonymously();

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String> getUserId();
}

class UserRepositoryImp extends UserRepository {
  final AuthProvider remoteProvider;
  final NetworkInfo networkInfo;

  UserRepositoryImp(
      {@required this.remoteProvider, @required this.networkInfo});

  @override
  Future<String> getUserId() => remoteProvider.getUserId();

  @override
  Future<bool> isSignedIn() => remoteProvider.isSignedIn();

  @override
  Future<void> signInAnonymously() => remoteProvider.signInAnonymously();

  @override
  Future<void> signOut() => remoteProvider.signOut();
}
