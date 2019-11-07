import 'package:get_it/get_it.dart';
import 'package:uhk_events/io/api/ApiProvider.dart';
import 'package:uhk_events/io/firebase/firebase_auth_provider.dart';
import 'package:uhk_events/io/firebase/firestore_provider.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // http
  locator.registerLazySingleton(() => ApiProvider());

  // Firebase
  locator.registerLazySingleton<FirestoreProvider>(() => FirestoreProvider());
  locator.registerLazySingleton<FirebaseAuthProvider>(
      () => FirebaseAuthProvider());
}
