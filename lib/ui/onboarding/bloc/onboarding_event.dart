import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class ChangedPaged extends OnboardingEvent {
  final int index;
  const ChangedPaged({@required this.index});
}

class OnboardingSkipped extends OnboardingEvent {
  const OnboardingSkipped();
}
