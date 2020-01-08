import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uhk_events/util/preference_manager_base.dart';

class PreferenceManager extends BasePreferenceManager {

  @override
  void init() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  @override
  Future<Box<dynamic>> openBox(String key) async => Hive.openBox(key);

  @override
  dynamic getBox(String key) async {
    final box = Hive.box(key);
    return box.get(key);
  }

  @override
  void dispose() => Hive.close();
}
