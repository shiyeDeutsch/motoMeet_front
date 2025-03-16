import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../models/route.dart' as app_models;
import '../services/distanceFormatter.dart';
import '../utilities/duration_formatter.dart';
import '../services/userRouteService.dart';
import '../services/bottomSheetServices.dart';
import '../widgets/wayPointBottomSheet.dart';

class ActiveRouteDetails extends ConsumerWidget {
  final app_models.UserRoute currentUserRoute;
  final app_models.Route? baseRoute;
  final Position? currentPosition;
  final VoidCallback onStopPressed;

  const ActiveRouteDetails({
    Key? key,
    required this.currentUserRoute,
    this.baseRoute,
    this.currentPosition,
    required this.onStopPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 120.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
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
        children: [
          // Handle for dragging
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailItem(
                    icon: Icons.speed,
                    title: 'Speed',
                    value: '${currentPosition?.speed != null ? (currentPosition!.speed * 3.6).toStringAsFixed(0) : 'N/A'} km/h',
                    color: const Color(0xFF3E6C51),
                  ),
                  _buildDetailItem(
                    icon: Icons.terrain,
                    title: 'Elevation',
                    value: '${currentPosition?.altitude?.toStringAsFixed(0) ?? 'N/A'} m',
                    color: const Color(0xFFD59F33),
                  ),
                  _buildDetailItem(
                    icon: Icons.timer,
                    title: 'Duration',
                    value: DurationFormatter.formatDuration(ref.read(userRouteServiceProvider.notifier).routeDuration),
                    color: const Color(0xFFE76F51),
                  ),
                  _buildDetailItem(
                    icon: Icons.alt_route,
                    title: 'Distance',
                    value: DistanceFormatter.formatDistance(ref.read(userRouteServiceProvider.notifier).distance),
                    color: const Color(0xFF1976D2),
                  ),
                ],
              ),
            ),
          ),
          _buildRouteActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 10,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildRouteActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.add_location,
            label: 'Add Waypoint',
            onPressed: () {
              BottomSheetService.showLargeBottomSheet(
                context: context,
                content: WayPointBottomSheet(),
              );
            },
            color: const Color(0xFF3E6C51),
          ),
          _buildActionButton(
            icon: Icons.share,
            label: 'Share',
            onPressed: () {
              // Implement share route
            },
            color: const Color(0xFF1976D2),
          ),
          _buildActionButton(
            icon: Icons.stop,
            label: 'Stop',
            onPressed: onStopPressed,
            color: const Color(0xFFE76F51),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}