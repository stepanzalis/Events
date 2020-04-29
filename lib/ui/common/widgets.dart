import 'package:flutter/material.dart';

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
          borderRadius: BorderRadius.circular(120),
        ),
      ),
    );
  }
}
