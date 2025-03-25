import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:motomeetfront/models/locationShare.dart';
import 'package:motomeetfront/services/distanceFormatter.dart';

class SharedLocationsLayer extends StatelessWidget {
  final MapboxMapController mapController;
  final List<SharedLocation> sharedLocations;
  final Function(SharedLocation) onLocationTap;
  
  const SharedLocationsLayer({
    Key? key,
    required this.mapController,
    required this.sharedLocations,
    required this.onLocationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is an overlay widget that won't directly render anything
    // Instead, it manages MapboxGL symbols on the map
    _updateMapSymbols();
    
    return const SizedBox.shrink();
  }
  
  // Update symbols on the map
  void _updateMapSymbols() {
    // Remove existing symbols and add new ones
    // This would be handled in a controller with proper caching
    _addSharedLocationSymbols();
  }
  
  // Add symbols for shared locations
  void _addSharedLocationSymbols() {
    for (final location in sharedLocations) {
      if (location.latitude == null || location.longitude == null) continue;
      
      mapController.addSymbol(
        SymbolOptions(
          geometry: LatLng(location.latitude!, location.longitude!),
          iconImage: 'marker-15', // Use a built-in Mapbox icon
          iconSize: 1.5,
          iconColor: '#4B89F0', // Blue color for shared locations
          textField: location.userName ?? 'Unknown user',
          textSize: 12,
          textOffset: const Offset(0, 1.5),
          textColor: '#000000',
          textHaloColor: '#FFFFFF',
          textHaloWidth: 1.0,
        ),
      ).then((symbol) {
        // Add to symbol map for tap handling if needed
      });
    }
  }
}

class SharedLocationBottomSheet extends StatelessWidget {
  final SharedLocation location;
  final VoidCallback onClose;
  final VoidCallback? onNavigateTo;
  
  const SharedLocationBottomSheet({
    Key? key,
    required this.location,
    required this.onClose,
    this.onNavigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with name and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                location.userName ?? 'Unknown user',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onClose,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Location details
          if (location.distanceFromUser != null)
            ListTile(
              leading: const Icon(Icons.social_distance),
              title: Text('Distance from you'),
              subtitle: Text(DistanceFormatter.format(location.distanceFromUser!)),
              dense: true,
            ),
          
          ListTile(
            leading: const Icon(Icons.access_time),
            title: Text('Last updated'),
            subtitle: Text(location.lastUpdated != null
                ? _formatTimestamp(location.lastUpdated!)
                : 'Unknown'),
            dense: true,
          ),
          
          if (location.speed != null)
            ListTile(
              leading: const Icon(Icons.speed),
              title: Text('Speed'),
              subtitle: Text('${(location.speed! * 3.6).toStringAsFixed(1)} km/h'),
              dense: true,
            ),
          
          // Action buttons
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.navigation),
                label: const Text('Navigate to'),
                onPressed: onNavigateTo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Format timestamp relative to now
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    }
  }
} 