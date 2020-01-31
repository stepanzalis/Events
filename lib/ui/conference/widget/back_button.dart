import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uhk_events/common/constants.dart';

class ConferenceBackButton extends StatelessWidget {
  final Color fillColor;

  ConferenceBackButton({@required this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: backButtonSize,
          height: backButtonSize,
          decoration: BoxDecoration(color: fillColor, shape: BoxShape.circle),
          child: Center(
            child:
                SvgPicture.asset("assets/icons/arrow.svg", color: Colors.white),
          ),
        ),
      ),
    );
  }
}
