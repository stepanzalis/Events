import 'package:flutter/cupertino.dart';
import 'package:uhk_events/common/managers/network_info.dart';
import 'package:uhk_events/common/managers/preference_manager.dart';
import 'package:uhk_events/io/firebase/firebase_auth_provider.dart';

abstract class UserRepository {
  Future<void> signInAnonymously();

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String> getUserDocumentId();

  Future<String> getUserId();
}

class UserRepositoryImp extends UserRepository {
  final AuthProvider remoteProvider;
  final AppPreferences localProvider;
  final NetworkInfo networkInfo;

  UserRepositoryImp(
      {@required this.remoteProvider,
      @required this.networkInfo,
      @required this.localProvider});

  @override
  Future<String> getUserId() => remoteProvider.getUserId();

  @override
  Future<String> getUserDocumentId() => localProvider.getUserDocumentId();

  @override
  Future<bool> isSignedIn() => remoteProvider.isSignedIn();

  @override
  Future<void> signInAnonymously() => remoteProvider.signInAnonymously();

  @override
  Future<void> signOut() => remoteProvider.signOut();
}
