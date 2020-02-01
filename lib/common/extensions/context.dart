import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

extension Translations on BuildContext {
  String translate(String key) {
    return FlutterI18n.translate(this, key);
  }
}
