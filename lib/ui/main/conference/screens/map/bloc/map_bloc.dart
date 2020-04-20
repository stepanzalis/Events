import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uhk_events/io/repositories/map_repository.dart';

import 'bloc.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository mapRepository;
  MapBloc({@required this.mapRepository});

  @override
  MapState get initialState => MapState.empty();

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    yield* _mapLoadMarkersToState();
  }

  Stream<MapState> _mapLoadMarkersToState() async* {
    final Set<Marker> markers = await mapRepository.loadMarkers();
    yield MapState.loaded(markers);
  }
}
