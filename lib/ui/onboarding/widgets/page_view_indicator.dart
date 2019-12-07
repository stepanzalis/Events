import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:uhk_events/ui/main/auth_bloc/auth_bloc.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/widgets/dot_indicator.dart';

class PageViewIndicator extends StatefulWidget {
  final List<Widget> children;

  const PageViewIndicator({@required this.children});

  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator> {
  PageController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
            controller: controller,
            onPageChanged: pageChanged,
            itemCount: widget.children.length,
            itemBuilder: (context, index) => widget.children[index]),
        _BottomDotIndicator(widget.children)
      ],
    );
  }

  pageChanged(int index) =>
      BlocProvider.of<OnboardingBloc>(context).add(ChangedPaged(index: index));

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }
}

class _BottomDotIndicator extends StatelessWidget {
  final List<Widget> children;

  const _BottomDotIndicator(this.children);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is CurrentPageState) {
          return Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: DotIndicator(
              selectedPage: state.index,
              pageLength: children.length,
            ),
          );
        }
        return Container();
      },
    );
  }
}
