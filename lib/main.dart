import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uhk_events/io/api/ApiProvider.dart';
import 'package:uhk_events/io/firebase/firestore_provider.dart';
import 'package:uhk_events/io/repositories/events/event_repository_impl.dart';
import 'package:uhk_events/io/repositories/user/user_repository_impl.dart';
import 'package:uhk_events/styling.dart';
import 'package:uhk_events/ui/main/home/bloc/bloc.dart';
import 'package:uhk_events/ui/main/home/home_view.dart';

import 'io/firebase/firebase_auth_provider.dart';
import 'ui/main/auth_bloc/auth_bloc.dart';
import 'ui/onboarding/onboarding_view.dart';
import 'util/bloc_delegate.dart';

void _statusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

void main() async {
  _statusBarColor();
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: UserRepositoryImp(
          dataProvider: FirebaseAuthProvider(),
        ),
      )..add(AppStarted()),
      child: EventsApp(),
    ),
  );
}

class EventsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UHK Events',
      debugShowCheckedModeBanner: false,
      theme: theme,
      localizationsDelegates: [
        FlutterI18nDelegate(fallbackFile: 'cs', path: 'assets/i18n'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return OnboardingView();
          } else {
            return BlocProvider(
                create: (context) => EventsBloc(
                    repository: EventRepositoryImpl(
                        apiProvider: ApiProvider(),
                        firestoreProvider: FirestoreProvider())),
                child: BlocProvider(
                  create: (context) => EventFilteredBloc(
                      eventsBloc: BlocProvider.of<EventsBloc>(context)
                        ..add(LoadEvents())),
                  child: HomeView(),
                ));
          }
        },
      ),
    );
  }
}
