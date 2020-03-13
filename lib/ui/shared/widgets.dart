import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uhk_events/common/constants.dart';

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

class ItemContainerSkeleton extends StatelessWidget {
  final Widget child;

  const ItemContainerSkeleton({@required this.child});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 20.0,
              spreadRadius: 3,
              offset: const Offset(0.0, 10.0),
            )
          ],
        ),
        child: child,
      );
}

class LineSeparator extends StatelessWidget {
  final Color color;

  const LineSeparator({@required this.color});

  @override
  Widget build(BuildContext context) =>
      Container(width: double.infinity, height: 1, color: color);
}

class RoundedButton extends StatelessWidget {
  final String title;
  final Function onClick;
  final Color color;

  const RoundedButton(
      {@required this.title, @required this.color, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10, top: 25),
      child: RaisedButton(
        child: Text(title.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.display1.copyWith(
                fontSize: 15, color: Colors.white, letterSpacing: 1.5)),
        onPressed: onClick,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(containerRadius),
        ),
      ),
    );
  }
}
