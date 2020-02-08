import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/ui/main/home/auth_bloc/auth_bloc.dart';
import 'package:uhk_events/ui/main/home/auth_bloc/authentification_bloc.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/onboarding_view.dart';
import 'package:uhk_events/util/messaging_manager.dart';
import 'package:uhk_events/util/service_locator.dart';

class NotificationPanel extends StatelessWidget {
  const NotificationPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const _NotificationImage(),
        const SizedBox(height: 30),
        const OnboardingTitle("notifications"),
        const SizedBox(height: 30),
        const _NotificationSwitch(),
        const SizedBox(height: 20),
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
    return BlocBuilder<NotificationBloc, NotificationState>(
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
    return BlocConsumer<NotificationBloc, NotificationState>(
      listenWhen: (_, state) => state.allowed,
      listener: (_, state) {
        injector<MessagingManager>().iOSNotificationPermission();
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.translate("allowNotifications"),
              style: Theme.of(context).textTheme.body1,
            ),
            const SizedBox(width: 30),
            Switch.adaptive(
              activeColor: Colors.black,
              value: state.allowed,
              onChanged: (value) =>
                  BlocProvider.of<NotificationBloc>(context).add(
                ToggleNotifications(allowed: value),
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
    return MaterialButton(
      color: Theme.of(context).buttonColor,
      onPressed: onClick,
      minWidth: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Text(context.translate("continue"),
          style: const TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}
