import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'selecetMapProvider.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildCustomButton(
                icon: Icons.arrow_back,
                tooltip: 'Change Map Type',
                onPressed: onChangeMapType,
              ),
              SizedBox(height: 8),
              _buildCustomButton(
                icon: Icons.details,
                tooltip: 'Show Route Details',
                onPressed: onShowRouteDetails,
              ),
              SizedBox(height: 8),
              _buildCustomButton(
                icon: Icons.add_location_alt,
                tooltip: 'Record New Route',
                onPressed: onRecordNewRoute,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildCustomButton(
                icon: Icons.my_location,
                tooltip: 'Current Location',
                onPressed: onCurrentLocation,
              ),
              // SizedBox(height: 8),
              // _buildCustomButton(
              //   icon: Icons.zoom_in,
              //   tooltip: 'Zoom In',
              //   onPressed: onZoomIn,
              // ),
              // SizedBox(height: 8),
              // _buildCustomButton(
              //   icon: Icons.zoom_out,
              //   tooltip: 'Zoom Out',
              //   onPressed: onZoomOut,
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5), // Semi-transparent
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        //  tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}
