import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class NotificationState extends Equatable {
  final bool allowed;
  final String icon;

  NotificationState.initial(
      {this.allowed = false, this.icon = "assets/icons/notification.svg"});
  NotificationState.enabled(
      {this.allowed = true, this.icon = "assets/icons/notification.svg"});
  NotificationState.disabled(
      {this.allowed = false, this.icon = "assets/icons/no_notification.svg"});

  @override
  List<Object> get props => [allowed, icon];

  @override
  String toString() => 'Notifications {state: $allowed, icon: $icon}';
}
