import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uhk_events/common/service_locator.dart';

import 'bloc/bloc.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => injector<MapBloc>(),
      child: _MapView(),
    );
  }
}

class _MapView extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (BuildContext context, MapState state) {
        return Scaffold(
          body: GoogleMap(
            myLocationEnabled: true,
            compassEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(50.2087608, 15.8354045),
              zoom: 13.5,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              context
                  .bloc<MapBloc>()
                  .add(LoadFaculties(platform: Theme.of(context).platform));
            },
            markers: state.markers,
          ),
        );
      },
    );
  }
}
