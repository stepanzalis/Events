import 'package:flutter/foundation.dart';
import 'package:uhk_events/io/model/faculty.dart';

// App
bool isDebug = !kReleaseMode;

const String PREFERENCES_BOX = "preferencesBox";
const String EVENTS_BOX = "eventsBox";

const String EVENTS = "events";

// Faculties
final List<Faculty> faculties = [
  Faculty.Uhk,
  Faculty.Ff,
  Faculty.Fim,
  Faculty.Pdf,
  Faculty.Prf,
];
