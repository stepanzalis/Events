import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class ChangedPaged extends OnboardingEvent {
  final int index;

  const ChangedPaged({@required this.index});

  @override
  List<Object> get props => [index];
}

class OnboardingSkipped extends OnboardingEvent {
  const OnboardingSkipped();

  @override
  List<Object> get props => [];
}
