import 'dart:convert';

import 'package:http/http.dart';
import 'package:uhk_events/io/api/api.dart';
import 'package:uhk_events/io/entities/event_item_entity.dart';
import 'package:uhk_events/io/model/event_item.dart';

class ApiProvider with Api {

  final String _url = 'https://www.uhk.cz/cs/kalendar-akci/json/udalosti-uhk.js';

  @override
  Future<List<EventItem>> getEventList() async {
    final Response response = await get('$_url');
    final List<dynamic> list = jsonDecode(response.body)['data'];
    return list
        .map((item) => EventItem.fromEntity(EventItemEntity.fromJson(item)))
        .where((item) => item.eventTag.isNotEmpty)
        .toList();
  }
}
