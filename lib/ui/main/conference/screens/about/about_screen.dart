import 'package:flutter/material.dart';

import 'about_content.dart';
import 'event_list.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AboutContent(),
        MainEventItemsListView(),
      ],
    );
  }
}
