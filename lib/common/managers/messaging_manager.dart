import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/common/managers/preference_manager.dart';
import 'package:uhk_events/io/firebase/firestore_provider.dart';

class MessagingManager {
  final StreamController<Map<String, dynamic>> _controller = StreamController();

  final FirebaseMessaging firebaseMessaging;
  final AppPreferences preferenceManager;
  final FirestoreProvider firestoreProvider;

  MessagingManager(
      {@required this.firebaseMessaging,
      @required this.preferenceManager,
      @required this.firestoreProvider});

  void init() {
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
        });
  }

  static Future<void> _backgroundMessageHandler(
      Map<String, dynamic> message) async {}

  void iOSNotificationPermission() =>
      firebaseMessaging.requestNotificationPermissions();

  Future<void> saveToken() async {
    final token = await firebaseMessaging.getToken();

    if (token.isNotEmpty) {
      final String userDocumentId =
          await firestoreProvider.sendFirebaseToken(token);
      await preferenceManager.putUserDocumentId(userDocumentId);
      await preferenceManager.putToken(token);
    }
  }

  Stream<Map<String, dynamic>> notifications() {
    return _controller.stream;
  }

  void close() {
    _controller.close();
  }
}
