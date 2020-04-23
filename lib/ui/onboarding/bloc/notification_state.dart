import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {}

class NotificationsInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationsSuccess extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationsLoading extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationsError extends NotificationState {
  final Exception e;
  NotificationsError({this.e});

  @override
  List<Object> get props => [e];
}
