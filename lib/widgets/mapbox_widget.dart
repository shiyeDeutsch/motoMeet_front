import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../models/route.dart' as app_models;
import 'package:geolocator/geolocator.dart';

// You'll need to get a Mapbox access token from https://account.mapbox.com/
const String MAPBOX_ACCESS_TOKEN = 'pk.eyJ1Ijoiam9zaGRldXRzY2giLCJhIjoiY204Ymt4bDFhMWh1aTJsczVzNDNlcTRpbSJ9.dzh1waA8zdT90jwmyOzpiQ';

class MapboxWidget extends StatelessWidget {
  final List<app_models.GeoPoint> committedPoints;
  final Position? userPos;
  final app_models.Route? baseRoute;
  final Function(MapboxMapController) onMapCreated;
  final Function() onStyleLoaded;
  final Function(dynamic, LatLng) onMapClick;
  final String styleString;

  const MapboxWidget({
    Key? key,
    required this.committedPoints,
    this.userPos,
    this.baseRoute,
    required this.onMapCreated,
    required this.onStyleLoaded,
    required this.onMapClick,
    required this.styleString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      accessToken: MAPBOX_ACCESS_TOKEN,
      styleString: styleString,
      initialCameraPosition: CameraPosition(
        target: userPos != null 
            ? LatLng(userPos!.latitude, userPos!.longitude) 
            : const LatLng(0, 0), // Will be updated once we get user location
        zoom: 13.0,
      ),
      onMapCreated: onMapCreated,
      onStyleLoadedCallback: onStyleLoaded,
      // IMPORTANT: Disable built-in location tracking to avoid the crash
      myLocationEnabled: false,
      myLocationTrackingMode: MyLocationTrackingMode.None,
      myLocationRenderMode: MyLocationRenderMode.NORMAL,
      compassEnabled: true,
      compassViewPosition: CompassViewPosition.TopRight,
      attributionButtonPosition: AttributionButtonPosition.BottomLeft,
      onMapClick: onMapClick,
    );
  }
}