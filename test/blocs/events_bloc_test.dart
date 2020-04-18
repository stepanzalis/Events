import 'package:bloc_test/bloc_test.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/repositories/event_repository.dart';
import 'package:uhk_events/ui/main/home/bloc/bloc.dart';

class MockEventRepository extends Mock implements EventRepository {}

class MockEventItem extends Mock implements EventItem {}

void main() {
  EventRepository mockEventRepository;
  MockEventItem mockEventItem;
  EventsBloc bloc;

  setUp(() {
    mockEventItem = MockEventItem();
    mockEventRepository = MockEventRepository();
    bloc = EventsBloc(repository: mockEventRepository);
  });

  tearDown(() {
    mockEventRepository = null;
    bloc = null;
  });

  group('EventsBloc', () {
    test('initial state should be [EventsLoading]', () {
      expect(bloc.initialState, EventsLoading());
    });

    blocTest(
      'emits [EventsLoading(), EventsLoaded()] when LoadEvent is fired',
      build: () {
        when(mockEventRepository.getEventList())
            .thenAnswer((_) async => await Right([mockEventItem]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadEvents()),
      expect: [
        EventsLoading(),
        EventsLoaded([mockEventItem])
      ],
    );
  });
}
