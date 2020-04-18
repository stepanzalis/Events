import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {}

class NotificationsAllowedPressed extends NotificationEvent {
  NotificationsAllowedPressed();

  @override
  List<Object> get props => [];
}
