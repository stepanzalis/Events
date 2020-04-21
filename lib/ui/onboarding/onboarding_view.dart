import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/common/service_locator.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/widgets/page_view_indicator.dart';
import 'package:uhk_events/ui/shared/widgets.dart';

import 'bloc/onboarding_bloc.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<OnboardingBloc>(
            create: (context) => injector<OnboardingBloc>(),
          ),
          BlocProvider<NotificationBloc>(
            create: (context) => injector<NotificationBloc>(),
          ),
        ],
        child: PageViewIndicator(),
      ),
    );
  }
}

class ImageTextPageView extends StatelessWidget {
  final String iconAsset;
  final String titleKey;
  final Color color;
  final VoidCallback onClick;

  const ImageTextPageView(
      {@required this.iconAsset,
      @required this.titleKey,
      @required this.color,
      @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return _IconTextWrapper(
      iconAsset,
      titleKey,
      color,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40),
          child: RoundedButton(
              onClick: onClick,
              title: context.translate("continue"),
              color: color),
        )
      ],
    );
  }
}

class NotificationPageView extends StatelessWidget {
  final String iconAsset;
  final String titleKey;
  final Color color;

  const NotificationPageView(
      {@required this.iconAsset,
      @required this.titleKey,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      condition: (_, state) =>
          state is NotificationsError || state is NotificationsSuccess,
      listener: (context, state) {
        if (state is NotificationsSuccess) {
          _skipOnboarding(context);
        } else {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(context.translate("notificationError"))));
        }
      },
      child: _IconTextWrapper(
        iconAsset,
        titleKey,
        color,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40),
            child: BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
              if (state is NotificationsLoading) {
                return CircularProgressIndicator();
              } else {
                return RoundedButton(
                    onClick: () => _allowNotifications(context),
                    title: context.translate("allowNotifications"),
                    color: color);
              }
            }),
          ),
          FlatButton(
              onPressed: () => _skipOnboarding(context),
              child: Text(
                context.translate("skipOnboarding").toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(fontSize: 13, letterSpacing: 1.4),
              ))
        ],
      ),
    );
  }

  void _allowNotifications(BuildContext context) {
    context.bloc<NotificationBloc>().add(NotificationsAllowedPressed());
  }

  void _skipOnboarding(BuildContext context) {
    context.bloc<OnboardingBloc>().add(OnboardingSkipped());
  }
}

class _OnboardingTitle extends StatelessWidget {
  final String titleKey;

  const _OnboardingTitle(this.titleKey);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Text(
        context.translate(titleKey),
        textAlign: TextAlign.center,
        style: TextStyle(
            height: 1.5,
            fontSize: 20,
            color: Theme.of(context).textTheme.body2.color),
      ),
    );
  }
}

class _IconTextWrapper extends StatelessWidget {
  final String iconAsset;
  final String titleKey;
  final Color color;
  final List<Widget> children;

  const _IconTextWrapper(this.iconAsset, this.titleKey, this.color,
      {@required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(iconAsset, width: 80),
          const SizedBox(height: 50),
          _OnboardingTitle(titleKey),
          ...children
        ],
      ),
    );
  }
}
