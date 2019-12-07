
abstract class AuthProvider {

  Future<void> signInAnonymously();

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String> getUserId();
}
