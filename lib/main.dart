import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:print_lumberdash/print_lumberdash.dart';
import 'package:uhk_events/io/common/constants.dart';
import 'package:uhk_events/ui/main/home/bloc/bloc.dart';
import 'package:uhk_events/ui/main/home/home_view.dart';
import 'package:uhk_events/ui/shared/theme/styling.dart';
import 'package:uhk_events/ui/splashscreen/splashscreen.dart';
import 'package:uhk_events/util/managers/messaging_manager.dart';
import 'package:uhk_events/util/service_locator.dart';

import 'common/bloc_delegate.dart';
import 'common/constants.dart';
import 'io/entities/event_item_entity.dart';
import 'io/entities/main_event_item_entity.dart';
import 'ui/main/home/auth_bloc/auth_bloc.dart';
import 'ui/onboarding/onboarding_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  _startLogging();
  _statusBarColor();
  _initServiceLocator();
  _initHive();

  runApp(
    BlocProvider(
      create: (context) => injector<AuthenticationBloc>()..add(AppStarted()),
      child: EventsApp(),
    ),
  );
}

class EventsApp extends StatefulWidget {
  @override
  _EventsAppState createState() => _EventsAppState();
}

class _EventsAppState extends State<EventsApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'UHK Events',
        debugShowCheckedModeBanner: isDebug,
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
            } else if (state is SplashScreen) {
              return SplashScreenView();
            } else {
              return BlocProvider(
                create: (context) => injector<EventFilteredBloc>(),
                child: HomeView(),
              );
            }
          },
        ),
      );

  @override
  void initState() {
    injector<MessagingManager>()
        .notifications()
        .listen((onData) => {injector<EventsBloc>().add(LoadEvents())});
    super.initState();
  }

  @override
  void dispose() {
    injector<MessagingManager>().close();
    super.dispose();
  }
}

void _statusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent),
  );
}

void _startLogging() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  putLumberdashToWork(
    withClients: [
      PrintLumberdash(),
    ],
  );
}

Future<void> _initServiceLocator() async {
  await initDi();
}

Future<void> _initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter<EventItemEntity>(EventItemEntityAdapter());
  Hive.registerAdapter<MainEventItemEntity>(MainEventItemEntityAdapter());

  await Hive.openBox<EventItemEntity>(Events);
  await Hive.openBox<MainEventItemEntity>(MainItemEvents);
  await Hive.openBox(Preferences);
}
