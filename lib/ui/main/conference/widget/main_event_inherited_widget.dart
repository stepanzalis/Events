import 'package:flutter/material.dart';
import 'package:uhk_events/io/model/faculty.dart';

class MainEventInheritedWidget extends InheritedWidget {
  const MainEventInheritedWidget({
    Key key,
    @required this.faculty,
    @required this.id,
    @required Widget child,
  })  : assert(faculty != null),
        assert(id != null),
        assert(child != null),
        super(key: key, child: child);

  final Faculty faculty;
  final String id;

  static MainEventInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(MainEventInheritedWidget old) =>
      faculty != old.faculty;
}
