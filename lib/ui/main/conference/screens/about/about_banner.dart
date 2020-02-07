import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uhk_events/common/colors.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';
import 'package:uhk_events/io/model/faculty.dart';

class BannerWidget extends StatelessWidget {
  final Faculty faculty;
  final String title;
  final String date;

  const BannerWidget({@required this.title, @required this.faculty, this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _ConferenceBackButton(fillColor: faculty.facultyColor()),
        _BannerSkeleton(
          date: "17.2.2020",
          title: "Zasedání asociace děkanů filozofických fakult",
        )
      ],
    );
  }
}

class _ConferenceBackButton extends StatelessWidget {
  final Color fillColor;

  const _ConferenceBackButton({@required this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
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

class _BannerSkeleton extends StatelessWidget {
  final String title;
  final String date;

  const _BannerSkeleton({@required this.title, @required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        // image: DecorationImage(image: NetworkImage("")),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.white, disableBarItemColor],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            child: Text(
              date,
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: Colors.white),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30),
          ),
          Padding(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          ),
        ],
      ),
    );
  }
}
