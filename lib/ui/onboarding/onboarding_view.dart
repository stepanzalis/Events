import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/widgets/inside_page_view.dart';
import 'package:uhk_events/ui/onboarding/widgets/notification_panel.dart';
import 'package:uhk_events/ui/onboarding/widgets/page_view_indicator.dart';

import 'bloc/onboarding_bloc.dart';

class OnboardingView extends StatelessWidget {

  final List<Widget> onboardingPages = [
    InsidePageView(
        child: ImageTextPageView("assets/icons/calendar.svg", "addToCalendar")),
    InsidePageView(
        child: ImageTextPageView("assets/icons/conference.svg", "conference")),
    InsidePageView(child: NotificationPanel(), showSkippedButton: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<OnboardingBloc>(create: (context) => OnboardingBloc()),
          BlocProvider<NotificationBloc>(create: (context) => NotificationBloc()),
        ],
        child: PageViewIndicator(children: onboardingPages),
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
          SizedBox(height: 40),
          OnboardingTitle(titleKey),
          SizedBox(height: 200),
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
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Text(
        FlutterI18n.translate(context, titleKey),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, color: Theme.of(context).textTheme.body1.color),
      ),
    );
  }
}
