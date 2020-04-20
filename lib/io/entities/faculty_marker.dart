import 'package:flutter/cupertino.dart';

@immutable
class FacultyMarker {
  final String name;
  final double lat;
  final double lon;
  final String assetPath;

  FacultyMarker(
      {@required this.name,
      @required this.lat,
      @required this.lon,
      @required this.assetPath});

  factory FacultyMarker.fromJson(Map<String, dynamic> map) {
    return FacultyMarker(
      name: map['name'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      assetPath: map['icon_path'] as String,
    );
  }
}
