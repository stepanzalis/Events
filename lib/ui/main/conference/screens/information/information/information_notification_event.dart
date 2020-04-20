import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class InformationNotificationEvent extends Equatable {
  const InformationNotificationEvent();
}

class ChangedNotification extends InformationNotificationEvent {
  final bool allowed;
  ChangedNotification({@required this.allowed});

  @override
  List<Object> get props => [allowed];
}

class ChangedDarkMode extends InformationNotificationEvent {
  final bool darkMode;
  ChangedDarkMode({@required this.darkMode});

  @override
  List<Object> get props => [darkMode];
}

class GetCurrentSettings extends InformationNotificationEvent {
  @override
  List<Object> get props => [];
}
