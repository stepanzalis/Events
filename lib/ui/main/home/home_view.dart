import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/extensions/context.dart';
import 'package:uhk_events/common/extensions/extensions.dart';
import 'package:uhk_events/common/transitions/slide_transition.dart';
import 'package:uhk_events/io/common/constants.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/common/widgets.dart';
import 'package:uhk_events/ui/main/conference/bloc/bloc.dart';
import 'package:uhk_events/ui/main/conference/conference_view.dart';
import 'package:uhk_events/ui/main/conference/widget/main_event_inherited_widget.dart';
import 'package:uhk_events/ui/main/home/bloc/bloc.dart';
import 'package:uhk_events/ui/main/home/widget/detail/event_detail_modal.dart';
import 'package:uhk_events/ui/main/home/widget/faculty_button.dart';
import 'package:uhk_events/ui/main/home/widget/item_event.dart';
import 'package:uhk_events/util/constants.dart';
import 'package:uhk_events/util/service_locator.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: eventAppBar(
            context.translate("appTitle"), [_FacultyFilterButtons()], context),
        body: BlocBuilder<EventFilteredBloc, EventFilteredState>(
          builder: (_, state) {
            if (state is FilteredEventsLoading) {
              return _LoadingList();
            } else if (state is FilteredEventsLoaded) {
              return _EventListView(items: state.events);
            } else {
              return _EmptyEventList();
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
    final bloc = BlocProvider.of<EventFilteredBloc>(context);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, animation1, animation2) {
        return BlocProvider.value(
          value: bloc,
          child: EventDetailModal(eventItem: item),
        );
      },
      transitionBuilder: (context, animation, _, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
    );
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

class _EmptyEventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/no_wifi.svg",
                  width: NoInternetIconSize,
                ),
                const SizedBox(height: 20),
                Text(
                  context.translate("eventError"),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.body1,
                ),
              ],
            ),
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
                            onTap: () =>
                                BlocProvider.of<EventFilteredBloc>(context)
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
