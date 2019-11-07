import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:uhk_events/util/theme/theme.dart';
import 'di/locator.dart';
import 'util/bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  setupLocator();

  runApp(EventsApp());
}

class EventsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EventApp ',
      theme: theme,
      home: Container(),
      localizationsDelegates: [
        FlutterI18nDelegate(fallbackFile: 'cs', path: 'assets/i18n'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}

