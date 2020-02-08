import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/widgets/page_view_indicator.dart';
import 'package:uhk_events/util/service_locator.dart';

import 'bloc/onboarding_bloc.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<OnboardingBloc>(
              create: (context) => injector<OnboardingBloc>()),
          BlocProvider<NotificationBloc>(
              create: (context) => injector<NotificationBloc>()),
        ],
        child: Stack(
          children: <Widget>[
            _Background(),
            PageViewIndicator(),
          ],
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/icons/background.png"),
            fit: BoxFit.cover),
      ),
    );
  }
}

class ImageTextPageView extends StatelessWidget {
  final String iconAsset;
  final String titleKey;

  const ImageTextPageView(this.iconAsset, this.titleKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(iconAsset),
          const SizedBox(height: 30),
          OnboardingTitle(titleKey),
        ],
      ),
    );
  }
}

class OnboardingTitle extends StatelessWidget {
  final String titleKey;

  const OnboardingTitle(this.titleKey);

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
            color: Theme.of(context).textTheme.body1.color),
      ),
    );
  }
}
