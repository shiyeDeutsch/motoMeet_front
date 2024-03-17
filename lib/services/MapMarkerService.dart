import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// import '../models/mapMarker.dart';
import '../stateProvider.dart';
import 'loctionService.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
 
class MapMarkerService {
  MapMarkerService( ) {
  //  getMarkers(ref);
  }


  void getMarkers(WidgetRef ref) async {
    var location = await LocationService.getCurrentLocation();
    
    var locationMarker = Marker(
      point: location ?? LatLng(0.0, 0.0),
      width: 80.0,
      height: 80.0,
      child:  const Tooltip(
        message: 'Current location',
        child: Icon(Icons.location_on_rounded, color: Colors.red),
      ),
    );
    
   print ("marker added");
    ref.read(markerListProvider.notifier).addMarker(locationMarker);
  }
}

