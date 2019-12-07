import 'dart:io';

import 'package:hive/hive.dart';

class PreferenceManager {
  
  static final PreferenceManager _singleton = PreferenceManager._internal();

  PreferenceManager._internal();

  factory PreferenceManager() => _singleton;

  PreferenceManager.init(Directory directory) {
    Hive.init(directory.path);
  }

  Future<Box<dynamic>> openBox(String key) async => Hive.openBox(key);

  dynamic getBox(String key) async {
    final box = Hive.box(key);
    return box.get(key);
  }

  dispose() => Hive.close();
}
