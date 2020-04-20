import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uhk_events/common/colors.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/common/service_locator.dart';
import 'package:uhk_events/io/common/wifi_type.dart';
import 'package:uhk_events/ui/main/conference/screens/information/information/bloc.dart';
import 'package:uhk_events/ui/main/conference/screens/information/widgets/widgets.dart';
import 'package:uhk_events/ui/main/conference/screens/information/wifi/bloc.dart';
import 'package:uhk_events/ui/main/conference/widget/main_event_inherited_widget.dart';
import 'package:uhk_events/ui/shared/app_bar.dart';
import 'package:uhk_events/ui/shared/widgets.dart';

import 'wifi/wifi_info_bloc.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InformationBloc>(
          create: (context) =>
              injector<InformationBloc>()..add(GetCurrentSettings()),
        ),
        BlocProvider<WifiInfoBloc>(
          create: (context) => injector<WifiInfoBloc>()..add(LoadWifiInfo()),
        )
      ],
      child: Scaffold(
        appBar: EventAppBar(context.translate("information")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _WifiBox(),
            _SettingsBox(),
            _AuthorsBox(),
            _AppVersion(),
          ],
        ),
      ),
    );
  }
}

class _WifiBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color color =
        MainEventInheritedWidget.of(context).faculty.facultyColor();

    return ItemContainerSkeleton(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<InformationBloc, InformationState>(
          builder: (context, state) => Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/wifi.svg", height: 20),
                  SizedBox(width: 20),
                  Text(
                    context.translate("wifi"),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(fontSize: 16),
                  )
                ],
              ),
              const SizedBox(height: 15),
              _WifiInfo(
                  color: color.withOpacity(0.3),
                  type: WifiField.SSID,
                  content: state.ssid),
              const SizedBox(height: 10),
              _WifiInfo(
                  color: UhkColor.withOpacity(0.3),
                  type: WifiField.PASSWORD,
                  content: state.password),
            ],
          ),
        ),
      ),
    );
  }
}

class _WifiInfo extends StatelessWidget {
  final Color color;
  final WifiField type;
  final String content;

  _WifiInfo({
    @required this.color,
    @required this.type,
    @required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            color: UhkColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: RichText(
            text: TextSpan(
              text: type == WifiField.SSID
                  ? context.translate("ssid")
                  : context.translate("password"),
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: content,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontWeight: FontWeight.normal, fontSize: 14)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              context.translate("settings"),
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(height: 20),
            _PushNotificationSwitch(),
            const Separator(),
            _DarkModeButton(),
            const Separator(),
          ],
        ),
      ),
    );
  }
}

class _AuthorsBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 20.0,
                      spreadRadius: 3,
                      offset: const Offset(0.0, 10.0),
                    )
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        context.translate("developer"),
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            "Štěpán Záliš",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(fontSize: 14),
                          ),
                          SizedBox(width: 30),
                          Image.asset(
                            "assets/icons/arrow_info.png",
                            width: 15,
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ],
    );
  }
}

class _AppVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: <Widget>[
          BlocBuilder<InformationBloc, InformationState>(
            builder: (context, state) {
              return Text(
                "Verze aplikace: ${state.appVersion}",
                style:
                    Theme.of(context).textTheme.caption.copyWith(fontSize: 13),
              );
            },
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}

class _PushNotificationSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InformationBloc, InformationState>(
      builder: (context, state) => SwitchListTile.adaptive(
        contentPadding: EdgeInsets.all(0),
        title: Text(
          context.translate("allowNotifications"),
          style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
        ),
        value: state.notificationsEnabled,
        onChanged: (value) {
          context
              .bloc<InformationBloc>()
              .add(ChangedNotification(allowed: value));
        },
      ),
    );
  }
}

class _DarkModeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(
        context.translate("darkMode"),
        style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Image.asset(
          "assets/icons/dark_mode.png",
          width: 30,
        ),
      ),
    );
  }
}
