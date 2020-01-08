import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uhk_events/io/common/constants.dart';
import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/ui/main/home/bloc/bloc.dart';
import 'package:uhk_events/ui/main/home/widget/detail/event_detail_modal.dart';
import 'package:uhk_events/ui/main/home/widget/faculty_button.dart';
import 'package:uhk_events/ui/main/home/widget/item_event.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          actions: <Widget>[_FilterButtons()],
          title: Text(FlutterI18n.translate(context, "appTitle"),
              style: Theme.of(context).textTheme.title),
        ),
        body: BlocConsumer<EventFilteredBloc, EventFilteredState>(
            listenWhen: (_, state) =>
                state is EventModalDetail || state is EventConferenceTypeDetail,
            listener: (context, EventFilteredState state) {
              if (state is EventModalDetail) {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return EventDetailModal(eventItem: state.item);
                  },
                );
              } else if (state is EventConferenceTypeDetail) {
                return Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Container()));
              } else
                return null;
            },
            buildWhen: (_, state) =>
                state is FilteredEventsLoading || state is FilteredEventsLoaded,
            builder: (context, state) {
              if (state is FilteredEventsLoading) {
                return _LoadingList();
              } else if (state is FilteredEventsLoaded) {
                return _EventListView(items: state.events);
              } else {
                return _EmptyEventList();
              }
            }),
      );
}

class _EventListView extends StatelessWidget {
  final List<EventItem> items;

  const _EventListView({@required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final EventItem event = items[index];
        return GestureDetector(
          onTap: () => BlocProvider.of<EventFilteredBloc>(context)
              .add(GetEventDetail(event)),
          child: EventItemRow(
            dateTime: event.eventTime,
            message: event.eventTitle,
            faculty: event.faculty,
          ),
        );
      },
    );
  }
}

class _EmptyEventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          FlutterI18n.translate(context, "eventError"),
          style: Theme.of(context).textTheme.body1,
        ),
      ),
    );
  }
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
                period: Duration(milliseconds: 400),
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
                        SizedBox(height: 5),
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

class _FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(right: 10),
        child: BlocBuilder<EventFilteredBloc, EventFilteredState>(
          condition: (prev, state) => state is FilteredEventsLoaded,
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
