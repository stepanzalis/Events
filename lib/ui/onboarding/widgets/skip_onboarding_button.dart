import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/main/auth_bloc/authentification_bloc.dart';
import 'package:uhk_events/ui/main/auth_bloc/authentification_event.dart';

class SkipOnbardingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color color = Faculty.values[Random().nextInt(6)].facultyColor();

    return Positioned(
      top: 40,
      right: 20,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        color: color,
        onPressed: () =>
            BlocProvider.of<AuthenticationBloc>(context).add(SkippedAuth()),
        child: Text(
          FlutterI18n.translate(context, "skipOnboarding"),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
