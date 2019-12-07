import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/firebase/auth_provider.dart';

import 'user_repository.dart';

class UserRepositoryImp with UserRepository {

  final AuthProvider dataProvider;
   UserRepositoryImp({@required this.dataProvider});

  @override
  Future<String> getUserId() => dataProvider.getUserId();

  @override
  Future<bool> isSignedIn() => dataProvider.isSignedIn();

  @override
  Future<void> signInAnonymously() => dataProvider.signInAnonymously();

  @override
  Future<void> signOut() => dataProvider.signOut();
}
