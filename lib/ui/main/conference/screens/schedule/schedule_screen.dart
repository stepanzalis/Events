import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uhk_events/common/colors.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/ui/common/widgets.dart';
import 'package:uhk_events/ui/main/conference/screens/schedule/bloc/bloc.dart';
import 'package:uhk_events/ui/main/conference/widget/main_event_inherited_widget.dart';
import 'package:uhk_events/util/service_locator.dart';

class ScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<MainEventBloc>(
          create: (context) => injector<MainEventBloc>()),
    ], child: _ScheduleScreen());
  }
}

class _ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: eventAppBar(
          context.translate("scheduleTitle"), [MyScheduleFilter()], context),
      body: Container(color: backgroundColor),
    );
  }
}

class MyScheduleFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = MainEventInheritedWidget.of(context).faculty.facultyColor();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(context.translate("mySchedule")),
        Switch.adaptive(
            activeColor: color, value: false, onChanged: (value) {}),
        SizedBox(width: appBarRightPadding)
      ],
    );
  }
}
