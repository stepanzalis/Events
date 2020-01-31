import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final int statusCode;

  ServerFailure({this.statusCode});
}

class NoInternetConnectionFailure extends Failure {}
