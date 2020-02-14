import 'package:equatable/equatable.dart';

abstract class MainEventState extends Equatable {
  const MainEventState();
}

class InitialMainEventState extends MainEventState {
  @override
  List<Object> get props => [];
}
