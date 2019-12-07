
import 'package:uhk_events/io/model/event_item.dart';

abstract class Api {

  Future<List<EventItem>> getEventList();
}