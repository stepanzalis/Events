import 'package:uhk_events/di/locator.dart';
import 'package:uhk_events/io/firebase/firebase_auth_provider.dart';

import 'user_repository.dart';

class UserRepositoryImp with UserRepository {

  final FirebaseAuthProvider _dataProvider = locator.get<FirebaseAuthProvider>();

  @override
  Future<String> getUserId() {
    return _dataProvider.getUserId();
  }

  @override
  Future<bool> isSignedIn() {
    return _dataProvider.isSignedIn();
  }

  @override
  Future<void> signInAnonymously() {
    return _dataProvider.signInAnonymously();
  }

  @override
  Future<void> signOut() {
    return _dataProvider.signOut();
  }
}
