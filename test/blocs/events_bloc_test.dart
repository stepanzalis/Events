import 'package:bloc_test/bloc_test.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uhk_events/common/error/failures.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/repositories/event_repository.dart';
import 'package:uhk_events/ui/main/home/bloc/bloc.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  EventRepository mockEventRepository;
  EventsBloc bloc;

  setUp(() {
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
      'emits [EventsLoading(), EventsNotLoaded()] when LoadEvent is fired and return error',
      build: () {
        when(mockEventRepository.getEventList())
            .thenAnswer((_) async => await Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadEvents()),
      expect: [EventsLoading(), EventsNotLoaded()],
      verify: () async {
        verify(mockEventRepository.getEventList()).called(1);
      },
    );

    blocTest(
      'emits [EventsLoading(), EventsNotLoaded()] when LoadEvent is fired and return empty events',
      build: () {
        when(mockEventRepository.getEventList())
            .thenAnswer((_) async => await Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadEvents()),
      expect: [EventsLoading(), EventsNotLoaded()],
      verify: () async {
        verify(mockEventRepository.getEventList()).called(1);
      },
    );

    blocTest(
      'emits [EventsLoading(), EventsLoaded()] when LoadEvent is fired and return list of events',
      build: () {
        when(mockEventRepository.getEventList())
            .thenAnswer((_) async => await Right([EventItem()]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadEvents()),
      expect: [
        EventsLoading(),
        EventsLoaded(events: [EventItem()])
      ],
      verify: () async {
        verify(mockEventRepository.getEventList()).called(1);
      },
    );
  });
}
