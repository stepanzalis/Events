import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uhk_events/io/entities/faculty_marker.dart';

abstract class MapRepository {
  Future<Set<Marker>> loadMarkers(TargetPlatform platform);
}

class MapRepositoryImp extends MapRepository {
  @override
  Future<Set<Marker>> loadMarkers(TargetPlatform platform) async {
    final markers = Set<Marker>();

    final String jsonString = await _loadFacultiesAsset();
    final jsonResponse = json.decode(jsonString).cast<Map<String, dynamic>>();
    final List<FacultyMarker> faculties = jsonResponse
        .map<FacultyMarker>((json) => FacultyMarker.fromJson(json))
        .toList();

    await faculties
        .map(
          (faculty) async => markers.add(
            Marker(
                markerId: MarkerId(faculty.name),
                position: LatLng(faculty.lat, faculty.lon),
                icon: await BitmapDescriptor.fromAssetImage(
                    ImageConfiguration(),
                    platform == TargetPlatform.android
                        ? faculty.androidAssetPath
                        : faculty.iOsAssetPath)),
          ),
        )
        .toList();

    return markers;
  }

  Future<String> _loadFacultiesAsset() async =>
      await rootBundle.loadString('assets/json/faculties.json');
}
