import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        _Background(),
        _LogoWithTitle()
      ],
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) => Image.asset(
        "assets/icons/background.png",
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      );
}

class _LogoWithTitle extends StatelessWidget {
  const _LogoWithTitle();

  final double logoSize = 80;

  @override
  Widget build(BuildContext context) => Positioned(
        top: MediaQuery.of(context).size.height / 4,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            SvgPicture.asset(
              "assets/icons/uhk_events.svg",
              width: logoSize,
              height: logoSize,
            ),
            SizedBox(height: 20),
            Text(FlutterI18n.translate(context, "appTitleFull"),
                style: Theme.of(context).textTheme.title)
          ],
        ),
      );
}
