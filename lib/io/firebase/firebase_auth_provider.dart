import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthProvider {
  Future<void> signInAnonymously();

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String> getUserId();
}

class FirebaseAuthProvider with AuthProvider {
  final FirebaseAuth firebaseAuth;
  FirebaseAuthProvider({@required this.firebaseAuth});

  @override
  Future<void> signInAnonymously() => firebaseAuth.signInAnonymously();

  @override
  Future<void> signOut() async => firebaseAuth.signOut();

  @override
  Future<bool> isSignedIn() async => await getUserId() != null;

  @override
  Future<String> getUserId() async {
    final user = await firebaseAuth?.currentUser();
    return await user?.uid;
  }
}
