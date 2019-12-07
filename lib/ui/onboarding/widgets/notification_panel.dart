import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uhk_events/ui/main/auth_bloc/auth_bloc.dart';
import 'package:uhk_events/ui/main/auth_bloc/authentification_bloc.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/onboarding_view.dart';

class NotificationPanel extends StatelessWidget {
  const NotificationPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _NotificationImage(),
        SizedBox(height: 40),
        OnboardingTitle("notifications"),
        SizedBox(height: 30),
        _NotificationSwitch(),
        SizedBox(height: 80),
        _ContinueButton(
            () => BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn()))
      ],
    );
  }
}

class _NotificationImage extends StatelessWidget {
  const _NotificationImage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationsAllowed>(
      builder: (context, state) {
        return SvgPicture.asset(state.icon);
      },
    );
  }
}

class _NotificationSwitch extends StatelessWidget {
  const _NotificationSwitch();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationsAllowed>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              FlutterI18n.translate(context, "allowNotifications"),
              style: Theme.of(context).textTheme.body1,
            ),
            SizedBox(width: 30),
            Switch.adaptive(
              activeColor: Colors.black,
              value: state.allowed,
              onChanged: (value) =>
                  BlocProvider.of<NotificationBloc>(context).add(
                ToggleNotifications(value),
              ),
            )
          ],
        );
      },
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final VoidCallback onClick;

  const _ContinueButton(this.onClick);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      color: Theme.of(context).buttonColor,
      onPressed: onClick,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      highlightedBorderColor: Theme.of(context).buttonColor,
      borderSide: BorderSide(color: Theme.of(context).buttonColor),
      child: Text(FlutterI18n.translate(context, "continue"),
          style: TextStyle(fontSize: 18, color: Colors.black)),
    );
  }
}
