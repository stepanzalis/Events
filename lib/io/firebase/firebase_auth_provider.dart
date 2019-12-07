import 'package:firebase_auth/firebase_auth.dart';
import 'package:uhk_events/io/firebase/auth_provider.dart';

class FirebaseAuthProvider with AuthProvider {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> signInAnonymously() => _firebaseAuth.signInAnonymously();

  @override
  Future<void> signOut() async => _firebaseAuth.signOut();

  @override
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  @override
  Future<String> getUserId() async {
     final user = await _firebaseAuth.currentUser();
     return user.uid;
  }
}
