import 'package:flutter/cupertino.dart';

@immutable
class OnboardingState {
  final int index;
  final bool isSkipped;

  OnboardingState({@required this.index, this.isSkipped});

  factory OnboardingState.initial() {
    return OnboardingState(index: 0, isSkipped: false);
  }

  OnboardingState updatePage({int nextIndex}) {
    return copyWith(index: nextIndex ?? index + 1);
  }

  OnboardingState skipOnboarding() {
    return copyWith(isSkipped: true);
  }

  OnboardingState copyWith({int index, bool isSkipped}) {
    return OnboardingState(
        index: index ?? this.index, isSkipped: isSkipped ?? this.isSkipped);
  }
}
