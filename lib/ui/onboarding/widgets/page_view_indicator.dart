import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/common/colors.dart';
import 'package:uhk_events/ui/main/home/auth_bloc/auth_bloc.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/widgets/dot_indicator.dart';

import '../onboarding_view.dart';

class PageViewIndicator extends StatefulWidget {
  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator> {
  static PageController controller;

  final List<Widget> onboardingPages = [
    ImageTextPageView(
      iconAsset: "assets/icons/walk1.png",
      titleKey: "addToCalendar",
      color: FfColor,
      onClick: () => {
        controller.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeIn)
      },
    ),
    ImageTextPageView(
      iconAsset: "assets/icons/walk2.png",
      titleKey: "conference",
      color: FimColor,
      onClick: () => {
        controller.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeIn)
      },
    ),
    NotificationPageView(
        iconAsset: "assets/icons/walk3.png",
        titleKey: "notifications",
        color: PdfColor),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
      context.bloc<OnboardingBloc>().add(ChangedPaged(index: index));

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
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listenWhen: (_, state) => state.isSkipped == true,
      listener: (context, state) => {
        context.bloc<AuthenticationBloc>().add(LoggedIn()),
      },
      builder: (context, state) {
        return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: DotIndicator(
                selectedPage: state.index,
                pageLength: numberOfPages,
              ),
            ));
      },
    );
  }
}
