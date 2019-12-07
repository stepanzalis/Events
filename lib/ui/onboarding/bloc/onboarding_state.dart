import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();
}

class CurrentPageState extends OnboardingState {
  final int index;
  CurrentPageState(this.index);

  @override
  List<Object> get props => [index];
}
