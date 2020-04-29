import 'package:flutter/cupertino.dart';

@immutable
class FacultyMarker {
  final String name;
  final double lat;
  final double lon;
  final String androidAssetPath;
  final String iOsAssetPath;

  FacultyMarker({
    @required this.name,
    @required this.lat,
    @required this.lon,
    @required this.androidAssetPath,
    @required this.iOsAssetPath,
  });

  factory FacultyMarker.fromJson(Map<String, dynamic> map) {
    return FacultyMarker(
      name: map['name'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      androidAssetPath: map['android_icon_path'] as String,
      iOsAssetPath: map['ios_icon_path'] as String,
    );
  }
}
