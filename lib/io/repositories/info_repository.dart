import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';
import 'package:uhk_events/common/managers/messaging_manager.dart';
import 'package:uhk_events/common/managers/preference_manager.dart';
import 'package:uhk_events/io/firebase/firestore_provider.dart';
import 'package:uhk_events/io/model/wifi_info.dart';

abstract class InfoRepository {
  Future<WifiInfo> fetchWifiInfo();

  Future<String> getAppVersionInfo();

  Future<bool> getNotificationsEnabled();

  Future<bool> getDarkModeEnabled();

  void setNotificationEnabled(bool enabled);

  void setDarkModeEnabled(bool enabled);
}

class InfoRepositoryImp extends InfoRepository {
  final MessagingManager messagingManager;
  final FirestoreProvider remoteProvider;
  final AppPreferences localDataSource;

  InfoRepositoryImp({
    @required this.messagingManager,
    @required this.remoteProvider,
    @required this.localDataSource,
  });

  @override
  Future<WifiInfo> fetchWifiInfo() async {
    return remoteProvider.fetchWifiInfo();
  }

  @override
  Future<String> getAppVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Future<bool> getNotificationsEnabled() async {
    return (await localDataSource.getToken()).isNotEmpty;
  }

  @override
  void setDarkModeEnabled(bool enabled) {
    localDataSource.setDarkMode(enabled);
  }

  @override
  void setNotificationEnabled(bool enabled) {
    localDataSource.setNotifications(enabled);
  }

  @override
  Future<bool> getDarkModeEnabled() {
    return localDataSource.getDarkMode();
  }
}
