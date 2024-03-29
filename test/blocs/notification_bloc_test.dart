import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uhk_events/common/managers/messaging_manager.dart';
import 'package:uhk_events/ui/onboarding/bloc/bloc.dart';
import 'package:uhk_events/ui/onboarding/bloc/notification_bloc.dart';

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
    test('initial state should be NotificationState.initial', () {});
  });

  blocTest(
    'emits [NotificationsInitial, NotificationStateSuccess] when notifications are allowed',
    build: () => bloc,
    act: (bloc) => bloc.add(NotificationsAllowedPressed()),
    expect: [
      NotificationsInitial(),
      NotificationsLoading(),
      NotificationsSuccess()
    ],
  );

  blocTest(
    'emits [NotificationState.initial(), NotificationState.disabled()] when notifications are disabled',
    build: () {
      when(mockMessagaingManager.saveToken()).thenThrow(throwsException);
      return NotificationBloc(messagingManager: mockMessagaingManager);
    },
    act: (bloc) => bloc.add(NotificationsAllowedPressed()),
    expect: [
      NotificationsInitial(),
      NotificationsLoading(),
      NotificationsError()
    ],
  );
}
