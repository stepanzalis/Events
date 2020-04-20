import 'package:equatable/equatable.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class LoadFaculties extends MapEvent {
  @override
  List<Object> get props => [];
}
