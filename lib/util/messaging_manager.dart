import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/firebase/firestore_provider.dart';
import 'package:uhk_events/util/preference_manager.dart';

class MessagingManager {
  static final StreamController<Map<String, dynamic>> _controller =
      StreamController();

  final FirebaseMessaging firebaseMessaging;
  final AppPreferences preferenceManager;
  final FirestoreProvider firestoreProvider;

  MessagingManager(
      {@required this.firebaseMessaging,
      @required this.preferenceManager,
      this.firestoreProvider}) {
    firebaseMessaging.configure(
      onBackgroundMessage:
          Platform.isAndroid ? _backgroundMessageHandler : null,
      onMessage: (Map<String, dynamic> message) async {
        _controller.add(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        _controller.add(message);
      },
      onResume: (Map<String, dynamic> message) async {
        _controller.add(message);
      },
    );
  }

  static Future<dynamic> _backgroundMessageHandler(
      Map<String, dynamic> message) async {
    await _controller.add(message);
  }

  void iOSNotificationPermission() =>
      firebaseMessaging.requestNotificationPermissions();

  void saveToken() async {
    final String token = await firebaseMessaging.getToken();
    await preferenceManager.putToken(token);
  }

  Stream<Map<String, dynamic>> notifications() {
    return _controller.stream;
  }

  void close() {
    _controller.close();
  }
}
