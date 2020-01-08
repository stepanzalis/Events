import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';

void main() {

  group('Onboarding', () {
    blocTest(
      'emits index 0 when nothing is added',
      build: () => OnboardingBloc(),
      expect: [CurrentPageState(0)],
    );

    blocTest(
      'page index is incremented by 1 index is changed',
      build: () => OnboardingBloc(),
      act: (OnboardingBloc bloc) => bloc.add(ChangedPaged(index: 1)),
      expect: [CurrentPageState(0), CurrentPageState(1)],
    );
  });

  group('Notifications', () {
    blocTest(
      'emits initial state when nothing is added',
      build: () => NotificationBloc(),
      expect: [NotificationsAllowed.initial()],
    );
  });
}