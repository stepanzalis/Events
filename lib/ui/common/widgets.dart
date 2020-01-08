import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlurredDialog extends StatelessWidget {
  final Widget child;

  const BlurredDialog({@required this.child});

  @override
  Widget build(BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            child: child),
      );
}

class LineSeparator extends StatelessWidget {
  final Color color;

  const LineSeparator({@required this.color});

  @override
  Widget build(BuildContext context) =>
      Container(width: double.infinity, height: 1, color: color);
}

