import 'package:flutter/material.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/io/model/main_event.dart';
import 'package:uhk_events/ui/main/conference/widget/item_my_event.dart';

import 'about_banner.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const BannerWidget(faculty: Faculty.Uhk, title: "", date: ""),
        _SectionTitle(text: context.translate("aboutEvent")),
        const SizedBox(height: 10),
        _EventDescriptionText(
            text: "Test", onClick: () => null, isExpanded: false),
        const SizedBox(height: 10),
        _SectionTitle(text: context.translate("mySchedule")),
        const SizedBox(height: 10),
        _MainEventListView(items: null)
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: Text(text, style: Theme.of(context).textTheme.subtitle),
    );
  }
}

class _MainEventListView extends StatelessWidget {
  final List<MainEvent> items;

  const _MainEventListView({@required this.items});

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final MainEvent event = items[index];
          return MyEventItemRow(
              title: "Úvodní přednáška", place: "Budova A", timeLeft: "30min");
        },
      );
}

class _EventDescriptionText extends StatefulWidget {
  final String text;
  final bool isExpanded;
  final Function onClick;

  _EventDescriptionText(
      {@required this.text, @required this.onClick, this.isExpanded = false});

  @override
  _EventDescriptionTextState createState() => _EventDescriptionTextState();
}

class _EventDescriptionTextState extends State<_EventDescriptionText>
    with TickerProviderStateMixin<_EventDescriptionText> {
  final int _maxCharCount = 150;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AnimatedSize(
              vsync: this,
              duration: const Duration(milliseconds: 400),
              child: Text(
                widget.text,
                maxLines: 3,
                style: Theme.of(context).textTheme.body2.copyWith(height: 1.5),
                overflow: TextOverflow.fade,
              )),
          widget.text.length >= _maxCharCount
              ? _ShowMoreButton(
                  title: context.translate("more"),
                  color: Faculty.Uhk.facultyColor(),
                  onClick: widget.onClick)
              : Container()
        ],
      ),
    );
  }
}

class _ShowMoreButton extends StatelessWidget {
  final Color color;
  final Function onClick;
  final String title;

  const _ShowMoreButton(
      {@required this.title, @required this.color, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 80,
      child: RaisedButton(
        child: Text(title.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.display1.copyWith(
                fontSize: 13, color: Colors.white, letterSpacing: 1.5)),
        onPressed: onClick,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70.0),
        ),
      ),
    );
  }
}
