import 'package:flutter/material.dart';
import 'package:uhk_events/common/colors.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/conference/widget/back_button.dart';

class BannerWidget extends StatelessWidget {
  final Faculty faculty;

  BannerWidget({@required this.faculty});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConferenceBackButton(fillColor: faculty.facultyColor()),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.white, disableBarItemColor])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Text(
                  "17.2.2020",
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30),
              ),
              Padding(
                child: Text(
                  "Zasedání asociace děkanů filozofických fakult",
                  style: Theme.of(context).textTheme.display1.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
