import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {}

class ToggleNotifications extends NotificationEvent {
  final bool value;
  ToggleNotifications(this.value);

  @override
  List<Object> get props => [value];
}
