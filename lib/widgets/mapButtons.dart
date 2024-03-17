import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MapButtons extends StatelessWidget {
  // Callback functions for each button
  final VoidCallback onChangeMapType;
  final VoidCallback onShowRouteDetails;
  final VoidCallback onRecordNewRoute;
  final VoidCallback onLiveTrackingShare;
  final VoidCallback onPauseStopRecording;
  final VoidCallback onAddWaypoints;
  final VoidCallback onSearch;
  final VoidCallback onCurrentLocation;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onRouteOptions;
  final VoidCallback onBackToDiscover;

  // Constructor to initialize the callback functions
  MapButtons({
    Key? key,
    required this.onChangeMapType,
    required this.onShowRouteDetails,
    required this.onRecordNewRoute,
    required this.onLiveTrackingShare,
    required this.onPauseStopRecording,
    required this.onAddWaypoints,
    required this.onSearch,
    required this.onCurrentLocation,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onRouteOptions,
    required this.onBackToDiscover,
  }) : super(key: key);

  @override
 Widget build(BuildContext context) {
  return Row(   mainAxisAlignment:  MainAxisAlignment.spaceBetween, 
  
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30,
            width: 30,
              child: FloatingActionButton(
                onPressed: onChangeMapType,
                tooltip: 'Change Map Type',
                child: Icon(Icons.map),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(height: 30,
            width: 30,
              child: FloatingActionButton(
                onPressed: onShowRouteDetails,
                tooltip: 'Show Route Details',
                child: Icon(Icons.details),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(height: 30,
            width: 30,
              child: FloatingActionButton(
                onPressed: onRecordNewRoute,
                tooltip: 'Record New Route',
                child: Icon(Icons.add_location_alt),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
         
          children: [
            SizedBox(height: 30,
            width: 30,
              child: FloatingActionButton(
                onPressed: onCurrentLocation,
                tooltip: 'Current Location',
                child: Icon(Icons.my_location),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(height: 30,
            width: 30,
              child: FloatingActionButton(
                onPressed: onZoomIn,
                tooltip: 'Zoom In',
                child: Icon(Icons.zoom_in),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(height: 30,
            width: 30,
              child: FloatingActionButton(
                onPressed: onZoomOut,
                tooltip: 'Zoom Out',
                child: Icon(Icons.zoom_out),
              ),
            ),
          ],
        ),
      ),
      
    ],
  );
}

}
