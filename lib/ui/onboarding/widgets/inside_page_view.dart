import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:uhk_events/ui/main/auth_bloc/authentification_bloc.dart';
import 'package:uhk_events/ui/main/auth_bloc/authentification_event.dart';

class InsidePageView extends StatelessWidget {
  final Widget child;
  final bool showSkippedButton;

  const InsidePageView({@required this.child, this.showSkippedButton = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset("/assets/icons/background.png"),
        ),
        if (showSkippedButton)
          Positioned(
              top: 40,
              right: 20,
              child: OutlineButton(
                  onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                      .add(SkippedAuth()),
                  child:
                      Text(FlutterI18n.translate(context, "skipOnboarding"))))
        else
          Container(),
        child
      ],
    );
  }
}
