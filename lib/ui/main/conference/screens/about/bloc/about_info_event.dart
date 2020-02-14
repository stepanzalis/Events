import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AboutInfoEvent extends Equatable {
  const AboutInfoEvent();
}

class LoadMainEventInfo extends AboutInfoEvent {
  final String id;

  const LoadMainEventInfo({@required this.id});

  @override
  List<Object> get props => [];
}

class ToggleDescription extends AboutInfoEvent {
  final bool expanded;

  const ToggleDescription({@required this.expanded});

  @override
  List<Object> get props => [expanded];
}
