import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class WifiInfoBloc extends Bloc<WifiInfoEvent, WifiInfoState> {
  @override
  WifiInfoState get initialState => WifiInfoState.empty();

  @override
  Stream<WifiInfoState> mapEventToState(
    WifiInfoEvent event,
  ) async* {
    if (event is LoadWifiInfo) {
      yield WifiInfoState.infoLoaded("dod2020", "dod");
    }
  }
}
