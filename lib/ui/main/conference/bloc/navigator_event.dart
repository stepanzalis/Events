import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NavigatorEvent extends Equatable {
  const NavigatorEvent();
}

class ChangePageIndex extends NavigatorEvent {
  final int index;

  const ChangePageIndex({@required this.index});

  @override
  List<Object> get props => [index];
}
