import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/widgets/dot_indicator.dart';

import '../onboarding_view.dart';
import 'notification_panel.dart';
import 'skip_onboarding_button.dart';

class PageViewIndicator extends StatefulWidget {
  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator> {
  PageController controller;

  final List<Widget> onboardingPages = [
    const ImageTextPageView("assets/icons/calendar.svg", "addToCalendar"),
    const ImageTextPageView("assets/icons/conference.svg", "conference"),
    const NotificationPanel(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BlocBuilder<OnboardingBloc, OnboardingState>(
          condition: (_, state) =>
              (state as CurrentPageState).index != onboardingPages.length - 1,
          builder: (context, state) => SkipOnbardingButton(),
        ),
        PageView.builder(
            controller: controller,
            onPageChanged: pageChanged,
            itemCount: onboardingPages.length,
            itemBuilder: (context, index) => onboardingPages[index]),
        _BottomDotIndicator(onboardingPages.length),
      ],
    );
  }

  void pageChanged(int index) =>
      BlocProvider.of<OnboardingBloc>(context).add(ChangedPaged(index: index));

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }
}

class _BottomDotIndicator extends StatelessWidget {
  final int numberOfPages;

  const _BottomDotIndicator(this.numberOfPages);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is CurrentPageState) {
          return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 120),
                child: DotIndicator(
                  selectedPage: state.index,
                  pageLength: numberOfPages,
                ),
              ));
        }
        return Container();
      },
    );
  }
}
