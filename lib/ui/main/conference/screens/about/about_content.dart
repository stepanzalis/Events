import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/main/conference/screens/about/bloc/about_info_bloc.dart';
import 'package:uhk_events/ui/main/conference/screens/about/bloc/about_info_state.dart';
import 'package:uhk_events/ui/main/conference/widget/main_event_inherited_widget.dart';

import 'about_banner.dart';
import 'bloc/about_info_event.dart';
import 'event_list.dart';

class AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Faculty faculty = MainEventInheritedWidget.of(context).faculty;

    return BlocBuilder<AboutInfoBloc, AboutInfoState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BannerWidget(
                color: faculty.facultyColor(),
                title: state.title,
                url: state.url,
                date: state.date),
            _SectionTitle(text: context.translate("aboutEvent")),
            _ExpandedScrollContainer(
              children: <Widget>[
                const SizedBox(height: 10),
                _EventDescriptionText(
                    text: state.description,
                    color: faculty.facultyColor(),
                    onClick: () => BlocProvider.of<AboutInfoBloc>(context).add(
                        ToggleDescription(
                            expanded: !state.isDescriptionExpanded)),
                    isExpanded: state.isDescriptionExpanded),
              ],
            ),
            _SectionTitle(text: context.translate("mySchedule")),
            MainEventItemsListView()
          ],
        );
      },
    );
  }
}

class _ExpandedScrollContainer extends StatelessWidget {
  final List<Widget> children;

  _ExpandedScrollContainer({@required this.children});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ),
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
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }
}

class _EventDescriptionText extends StatefulWidget {
  final String text;
  final bool isExpanded;
  final Color color;
  final Function onClick;

  _EventDescriptionText(
      {@required this.text,
      @required this.onClick,
      @required this.color,
      this.isExpanded = false});

  @override
  _EventDescriptionTextState createState() => _EventDescriptionTextState();
}

class _EventDescriptionTextState extends State<_EventDescriptionText>
    with TickerProviderStateMixin<_EventDescriptionText> {
  final int _maxCharCount = 150;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedSize(
                vsync: this,
                duration: const Duration(milliseconds: 400),
                child: Text(
                  widget.text,
                  maxLines: widget.isExpanded ? null : 3,
                  style:
                      Theme.of(context).textTheme.body2.copyWith(height: 1.5),
                  overflow: TextOverflow.fade,
                )),
            widget.text.length >= _maxCharCount
                ? _ShowMoreButton(
                    title: widget.isExpanded
                        ? context.translate("less")
                        : context.translate("more"),
                    color: widget.color,
                    onClick: widget.onClick)
                : Container()
          ],
        ),
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
      height: 30,
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
