import 'package:uhk_events/io/model/event_item.dart';
import 'package:uhk_events/util/date_formatter.dart';
import '../constants.dart';

extension EventExtensions on List<EventItem> {
  List<EventItem> sortedByDateDesc() {
    this.sort(
      (b, a) => getDate(a.eventStart, HUMAN_DATE_FORMAT).compareTo(
        getDate(b.eventStart, HUMAN_DATE_FORMAT),
      ),
    );
    return this;
  }
}
