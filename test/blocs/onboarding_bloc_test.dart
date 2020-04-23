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
    test('Firts index is 0', () {
      assert(bloc.state.index == 0);
    });
  });
}
