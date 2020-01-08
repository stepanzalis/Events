
import 'package:hive/hive.dart';

abstract class BasePreferenceManager {

  void init();

  dynamic getBox(String key);

  void dispose();

  Future<Box<dynamic>> openBox(String key);

}