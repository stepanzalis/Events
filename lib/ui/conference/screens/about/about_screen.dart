import 'package:flutter/material.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/conference/screens/about/about_banner.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BannerWidget(faculty: Faculty.Uhk),
      ],
    );
  }
}
