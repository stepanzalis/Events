import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  @override
  OnboardingState get initialState => OnboardingState.initial();

  @override
  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    if (event is ChangedPaged) {
      yield state.updatePage(nextIndex: event.index);
    } else if (event is OnboardingSkipped) {
      yield state.skipOnboarding();
    }
  }
}
