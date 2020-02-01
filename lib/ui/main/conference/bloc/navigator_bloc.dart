import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(
    NavigatorEvent event,
  ) async* {
    if (event is ChangePageIndex) {
      yield event.index;
    }
  }
}
