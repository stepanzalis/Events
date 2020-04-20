import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uhk_events/ui/shared/widgets.dart';

class Separator extends StatelessWidget {
  const Separator();

  @override
  Widget build(BuildContext context) {
    return LineSeparator(color: Colors.grey.withOpacity(0.4));
  }
}
