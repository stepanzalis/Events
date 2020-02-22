import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:uhk_events/io/api/api_provider.dart';
import 'package:uhk_events/io/firebase/firebase_auth_provider.dart';
import 'package:uhk_events/io/firebase/firestore_provider.dart';
import 'package:uhk_events/io/repositories/event_repository.dart';
import 'package:uhk_events/io/repositories/user_repository.dart';
import 'package:uhk_events/ui/main/conference/bloc/bloc.dart';
import 'package:uhk_events/ui/main/conference/screens/about/bloc/bloc.dart';
import 'package:uhk_events/ui/main/conference/screens/about/bloc/ticker.dart';
import 'package:uhk_events/ui/main/conference/screens/schedule/bloc/main_event_bloc.dart';
import 'package:uhk_events/ui/main/home/auth_bloc/auth_bloc.dart';
import 'package:uhk_events/ui/main/home/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/bloc/notification_bloc.dart';
import 'package:uhk_events/util/preference_manager.dart';

import 'messaging_manager.dart';
import 'network_info.dart';

final injector = GetIt.instance;

Future<void> initDi() async {
  // Blocs
  injector.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(userRepository: injector())..add(AppStarted()),
  );

  injector.registerFactory<EventsBloc>(
    () => EventsBloc(repository: injector())..add(LoadEvents()),
  );

  injector.registerFactory<EventFilteredBloc>(
    () => EventFilteredBloc(eventsBloc: injector()),
  );

  injector.registerFactory<NotificationBloc>(
    () => NotificationBloc(messagingManager: injector()),
  );

  injector.registerFactory<OnboardingBloc>(() => OnboardingBloc());

  injector.registerFactory<NavigatorBloc>(() => NavigatorBloc());

  injector.registerFactory<SavedEventsBloc>(
      () => SavedEventsBloc(eventRepository: injector(), ticker: injector()));

  injector.registerFactory<AboutInfoBloc>(
      () => AboutInfoBloc(eventRepository: injector()));

  injector.registerFactory<MainEventBloc>(
    () => MainEventBloc(eventRepository: injector()),
  );

  // Repositories
  injector.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(
        apiProvider: injector(),
        localDataSource: injector(),
        firestoreProvider: injector(),
        networkInfo: injector()),
  );

  injector.registerLazySingleton<UserRepository>(
    () =>
        UserRepositoryImp(remoteProvider: injector(), networkInfo: injector()),
  );

  // Data sources
  injector.registerLazySingleton<ApiProvider>(
    () => ApiProvider(client: injector()),
  );

  injector.registerLazySingleton<FirestoreProvider>(
    () => FirestoreProvider(),
  );

  injector.registerLazySingleton<AuthProvider>(
    () => FirebaseAuthProvider(),
  );

  injector.registerLazySingleton<AppPreferences>(
    () => AppPreferences(),
  );

  injector.registerLazySingleton<MessagingManager>(
    () => MessagingManager(
        preferenceManager: injector(),
        firestoreProvider: injector(),
        firebaseMessaging: injector()),
  );

  // Core
  injector
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injector()));

  // External
  injector.registerLazySingleton(() => DataConnectionChecker());
  injector.registerLazySingleton(() => FirebaseMessaging());
  injector.registerLazySingleton(() => Ticker());
  injector.registerLazySingleton(() => http.Client());
}
