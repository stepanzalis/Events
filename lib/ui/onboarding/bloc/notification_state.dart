import 'package:equatable/equatable.dart';

class NotificationsAllowed extends Equatable {
  final bool allowed;
  final String icon;

  NotificationsAllowed.initial(
      {this.allowed = false, this.icon = "assets/icons/notification.svg"});
  NotificationsAllowed.enabled(
      {this.allowed = true, this.icon = "assets/icons/notification.svg"});
  NotificationsAllowed.disabled(
      {this.allowed = false, this.icon = "assets/icons/no_notification.svg"});

  @override
  List<Object> get props => [allowed, icon];

  @override
  String toString() => 'NotificationsAllowed{allowed: $allowed, icon: $icon}';
}
