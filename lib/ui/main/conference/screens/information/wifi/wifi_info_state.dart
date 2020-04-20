import 'package:meta/meta.dart';

@immutable
class WifiInfoState {
  final String ssid;
  final String password;

  WifiInfoState({@required this.ssid, @required this.password});

  factory WifiInfoState.empty() {
    return WifiInfoState(ssid: "", password: "");
  }

  factory WifiInfoState.infoLoaded(String ssid, String password) {
    return WifiInfoState(ssid: ssid, password: password);
  }
}
