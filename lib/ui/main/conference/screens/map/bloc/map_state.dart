import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
class MapState {
  final Set<Marker> markers;

  MapState({@required this.markers});

  factory MapState.empty() {
    return MapState(markers: Set());
  }

  factory MapState.loaded(Set<Marker> markers) {
    return MapState(markers: markers);
  }
}
