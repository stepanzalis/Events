import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uhk_events/common/constants.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[const _Background(), const _LogoWithTitle()],
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/icons/background.png"),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _LogoWithTitle extends StatelessWidget {
  const _LogoWithTitle();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 4,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          SvgPicture.asset(
            "assets/icons/uhk_events.svg",
            width: logoSize,
            height: logoSize,
          ),
          const SizedBox(height: 20),
          Text(FlutterI18n.translate(context, "appTitleFull"),
              style: Theme.of(context).textTheme.title)
        ],
      ),
    );
  }
}
