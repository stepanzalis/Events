import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/bloc/onboarding_bloc.dart';

void main() {
  OnboardingBloc bloc;

  setUp(() {
    bloc = OnboardingBloc();
  });

  tearDown(() {
    bloc = null;
  });

  group('Onboarding', () {
    test('initial state should be SplashScreen', () {
      expect(bloc.initialState, CurrentPageState(0));
    });

    blocTest(
      'page index should be incremented by 1 when index is changed',
      build: () => OnboardingBloc(),
      act: (bloc) => bloc.add(ChangedPaged(index: 1)),
      expect: [CurrentPageState(0), CurrentPageState(1)],
    );
  });
}
