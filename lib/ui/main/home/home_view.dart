import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/extensions/context.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/common/service_locator.dart';
import 'package:uhk_events/common/transitions/slide_transition.dart';
import 'package:uhk_events/io/common/constants.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/main/conference/bloc/bloc.dart';
import 'package:uhk_events/ui/main/conference/conference_view.dart';
import 'package:uhk_events/ui/main/conference/widget/main_event_inherited_widget.dart';
import 'package:uhk_events/ui/main/home/bloc/bloc.dart';
import 'package:uhk_events/ui/main/home/widget/detail/event_detail_modal.dart';
import 'package:uhk_events/ui/main/home/widget/faculty_button.dart';
import 'package:uhk_events/ui/main/home/widget/item_event.dart';
import 'package:uhk_events/ui/shared/app_bar.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: EventAppBar(
          context.translate("appTitle"),
          actions: [_FacultyFilterButtons()],
        ),
        body: BlocBuilder<EventFilteredBloc, EventFilteredState>(
          builder: (_, state) {
            if (state is FilteredEventsLoading) {
              return _LoadingList();
            } else if (state is FilteredEventsLoaded) {
              return _EventListView(items: state.events);
            } else {
              return EmptyEventList(
                textKey: "eventError",
                icon: SvgPicture.asset(
                  "assets/icons/no_wifi.svg",
                  width: NoInternetIconSize,
                ),
              );
            }
          },
        ),
      );
}

class _EventListView extends StatelessWidget {
  final List<EventItem> items;

  const _EventListView({@required this.items});

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final EventItem event = items[index];
          return GestureDetector(
            onTap: () => event.isConference
                ? _showConferenceView(event, context)
                : _showModalDialog(event, context),
            child: EventItemRow(
              dateTime: event.eventTime,
              message: event.eventTitle,
              faculty: event.faculty,
            ),
          );
        },
      );

  void _showModalDialog(EventItem item, BuildContext context) {
    final bloc = context.bloc<EventFilteredBloc>();

    showModal(
        context: context,
        configuration: FadeScaleTransitionConfiguration(),
        builder: (context) {
          return BlocProvider.value(
            value: bloc,
            child: EventDetailModal(eventItem: item),
          );
        });
  }

  void _showConferenceView(EventItem item, BuildContext context) {
    Navigator.of(context).push(
      SlideLeftRoute(
        child: BlocProvider(
          create: (context) => injector<NavigatorBloc>(),
          child: MainEventInheritedWidget(
            id: item.id.toString(),
            faculty: item.faculty,
            child: ConferenceView(),
          ),
        ),
      ),
    );
  }
}

class EmptyEventList extends StatelessWidget {
  final String textKey;
  final Widget icon;

  EmptyEventList({@required this.textKey, this.icon});

  @override
  Widget build(BuildContext context) => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon ?? Container(),
              const SizedBox(height: 20),
              Text(
                context.translate(textKey),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.body1,
              ),
            ],
          ),
        ),
      );
}

class _LoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int itemCount = MediaQuery.of(context).size.height ~/ 100;

    return ListView.builder(
        itemCount: itemCount,
        itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                period: const Duration(milliseconds: 400),
                child: Container(
                  height: 80,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 12, left: 20),
                          height: 17,
                          width: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          margin: const EdgeInsets.only(top: 17, left: 20),
                          height: 17,
                          width: MediaQuery.of(context).size.width / 1.5,
                          color: Colors.grey,
                        ),
                      ]),
                ),
              ),
            ));
  }
}

class _FacultyFilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(right: appBarRightPadding),
        child: BlocBuilder<EventFilteredBloc, EventFilteredState>(
          condition: (_, state) => state is FilteredEventsLoaded,
          builder: (context, state) {
            if (state is FilteredEventsLoaded) {
              return Row(
                  children: faculties
                      .map((faculty) => GestureDetector(
                            onTap: () => context
                                .bloc<EventFilteredBloc>()
                                .add(UpdateFilter(faculty)),
                            child: FilterFacultyButton(
                                faculty: faculty,
                                isActive:
                                    isFilterActive(state.faculties, faculty)),
                          ))
                      .toList());
            } else {
              return Container();
            }
          },
        ),
      );

  bool isFilterActive(List<Faculty> allFaculties, Faculty faculty) =>
      allFaculties.contains(faculty);
}
