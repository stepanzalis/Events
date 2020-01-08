import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NotificationEvent extends Equatable {}

class ToggleNotifications extends NotificationEvent {
  final bool allowed;

  ToggleNotifications({@required this.allowed});

  @override
  List<Object> get props => [allowed];
}
