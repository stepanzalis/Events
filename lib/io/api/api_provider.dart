import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:uhk_events/io/api/api.dart';

class ApiProvider with Api {
  final String url = 'https://www.uhk.cz/cs/kalendar-akci/json/udalosti-uhk.js';

  final http.Client client;

  ApiProvider({@required this.client});

  @override
  Future<List<dynamic>> getEventList() async {
    final Response response = await client.get('$url');
    final List<dynamic> list = jsonDecode(response.body)['data'];
    return list;
  }
}
