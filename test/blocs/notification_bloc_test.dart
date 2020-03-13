import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uhk_events/common/managers/messaging_manager.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/bloc/notification_bloc.dart';
import 'package:uhk_events/ui/onboarding/bloc/notification_state.dart';

class MockMessagaingManager extends Mock implements MessagingManager {}

void main() {
  NotificationBloc bloc;
  MockMessagaingManager mockMessagaingManager;

  setUp(() {
    mockMessagaingManager = MockMessagaingManager();
    bloc = NotificationBloc(messagingManager: mockMessagaingManager);
  });

  tearDown(() {
    mockMessagaingManager = null;
    bloc = null;
  });

  group('Notifications', () {
    test('initial state should be NotificationState.initial', () {
      expect(bloc.initialState, NotificationState.initial());
      expect(bloc.state.icon, "assets/icons/notification.svg");
    });
  });

  blocTest(
    'emits [NotificationState.initial(), NotificationState.enabled()] when notifications allowed',
    build: () => bloc,
    act: (bloc) => bloc.add(ToggleNotifications(allowed: true)),
    expect: [NotificationState.initial(), NotificationState.enabled()],
  );

  blocTest(
    'emits [NotificationState.initial(), NotificationState.disabled()] when notifications disabled',
    build: () => bloc,
    act: (bloc) => bloc.add(ToggleNotifications(allowed: false)),
    expect: [NotificationState.initial(), NotificationState.disabled()],
  );
}
