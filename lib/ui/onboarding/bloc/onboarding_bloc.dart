import 'dart:async';

import 'package:bloc/bloc.dart';
import './bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  @override
  OnboardingState get initialState => CurrentPageState(0);

  @override
  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    if (event is ChangedPaged) {
      yield CurrentPageState(event.index);
    }
  }
}
