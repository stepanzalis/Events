import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class LoadFaculties extends MapEvent {
  final TargetPlatform platform;
  LoadFaculties({this.platform});

  @override
  List<Object> get props => [platform];
}
