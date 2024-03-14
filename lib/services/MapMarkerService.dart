import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// import '../models/mapMarker.dart';
import 'loctionService.dart';

class MapMarkerService {
  MapMarkerService()  {
      getMarkers();
  }
  List<Marker> markers = [];

  Future<List<Marker>> getMarkers( ) async {
    var loction = await LocationService.getCurrentLocation();
    markers.add(
      Marker(
        point: loction ?? LatLng(0.0, 0.0),
        width: 80.0,
        height: 80.0,
        builder: (BuildContext ctx) => const Tooltip(
          message: 'current location ',
          child: Icon(color: Colors.red, Icons.location_on_rounded),
        ),
      ),
    );

    return markers;
  }
}
