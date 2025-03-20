import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../models/route.dart' as app_models;
import '../providers/route_creation_provider.dart';
import '../services/distanceFormatter.dart';
import '../utilities/duration_formatter.dart';
 import '../services/bottomSheetServices.dart';
import '../widgets/wayPointBottomSheet.dart';
import 'ExpandablePanel.dart';
import 'expandableFAB.dart';

class ActiveRouteDetails extends ConsumerWidget {
  final app_models.UserRoute currentUserRoute;
  final app_models.Route? baseRoute;
  final Position? currentPosition;
  final VoidCallback onStopPressed;
  final BuildContext context;
  const ActiveRouteDetails({
    Key? key,
    required this.currentUserRoute,
    this.baseRoute,
    this.currentPosition,
    required this.onStopPressed,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    if (currentUserRoute == null) {
      return const SizedBox.shrink();
    }

    // Removed the outer Positioned widget to avoid nesting with AnimatedPositioned
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildRouteActionButtons(context, onStopPressed),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMainDetails(context, ref, currentPosition),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainDetails(BuildContext context, WidgetRef ref, Position? currentPosition) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDetailColumn(
            context: context,
            icon: Icons.speed,
            title: 'Speed',
            value: '${currentPosition?.speed?.toStringAsFixed(0) ?? 'N/A'} km/h',
          ),
        _buildDetailColumn(
          context: context,
          icon: Icons.terrain,
          title: 'Elevation',
          value: '${currentPosition?.altitude?.toStringAsFixed(1) ?? 'N/A'} m',
        ),
        _buildDetailColumn(
          context: context,
          icon: Icons.timer,
          title: 'Duration',
          value: DurationFormatter.formatDuration(ref.read(routeCreationProvider.notifier).routeDuration),
        ),
        _buildDetailColumn(
          context: context,
          icon: Icons.alt_route,
          title: 'Distance',
          value: DistanceFormatter.formatDistance(ref.read(routeCreationProvider.notifier).distance),
        ),
      ],
    );
  }

  Widget _buildDetailColumn({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      children: [
        Icon(icon, color: colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          title, 
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface,
          )
        ),
        Text(
          value, 
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          )
        ),
      ],
    );
  }

  Widget _buildRouteActionButtons(BuildContext context, VoidCallback onStopPressed) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return SizedBox(
      height: 50,
      child: ExpandableButtons(
        isOpen: true,
        alignment: Alignment.topRight,
        buttons: [
          IconButton(
            icon: Icon(Icons.add_location, color: colorScheme.primary),
            onPressed: () {
              BottomSheetService.showLargeBottomSheet(
                context: context,
                content: WayPointBottomSheet(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: colorScheme.primary),
            onPressed: () {
              // Implement share route
            },
          ),
          IconButton(
            icon: Icon(Icons.pause, color: colorScheme.error),
            onPressed: onStopPressed,
          ),
        ],
      ),
    );
  }
}


