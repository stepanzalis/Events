import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInAnonymously() => _firebaseAuth.signInAnonymously();

  Future<void> signOut() async => _firebaseAuth.signOut();

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUserId() async => (await _firebaseAuth.currentUser()).uid;
}
