import 'package:intl/intl.dart';
import 'package:uhk_events/common/constants.dart';

String dateFromTimestamp(int timestamp) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final dateFormat = DateFormat(HUMAN_DATE_TIME_FORMAT);
  return dateFormat.format(dateTime);
}

DateTime getDate(String date, String format) {
  final rawFormat = DateFormat(format);
  return rawFormat.parse(date);
}

String formatDate(String unformattedDate,
    {String fromFormat = API_DATE_FORMAT,
    String toFormat = HUMAN_DATE_FORMAT}) {
  final rawFormat = DateFormat(fromFormat);
  final dateFormat = DateFormat(toFormat);
  return dateFormat.format(rawFormat.parse(unformattedDate));
}
