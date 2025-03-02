import 'package:flutter/material.dart';
import 'package:motomeetfront/common/theme/colors.dart';
import 'package:motomeetfront/models/newRoute.dart';
import 'package:motomeetfront/utilities/duration_formatter.dart';

class RouteCard extends StatelessWidget {
  final NewRoute route;
  final VoidCallback? onTap;
  final bool showCreator;

  const RouteCard({
    Key? key,
    required this.route,
    this.onTap,
    this.showCreator = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Route thumbnail or map preview
              Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: route.thumbnailUrl != null
                        ? Image.network(
                            route.thumbnailUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholderImage(),
                          )
                        : _buildPlaceholderImage(),
                  ),
                  // Route type indicator
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getRouteTypeIcon(route.routeType),
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            route.routeType ?? 'Unknown',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Difficulty indicator
                  if (route.difficultyLevel != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(route.difficultyLevel!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          route.difficultyLevel!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              
              // Route details
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      route.name ?? 'Unnamed Route',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    
                    // Location info
                    if (route.locationName != null)
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              route.locationName!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    
                    const SizedBox(height: 8),
                    
                    // Route stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Distance
                        _buildStat(
                          Icons.straighten,
                          '${route.distance != null ? (route.distance! / 1000).toStringAsFixed(1) : '?'} km',
                        ),
                        
                        // Duration
                        _buildStat(
                          Icons.timer,
                          route.duration != null
                              ? formatDuration(Duration(seconds: route.duration!))
                              : '?',
                        ),
                        
                        // Elevation
                        _buildStat(
                          Icons.terrain,
                          route.elevationGain != null
                              ? '${route.elevationGain!.round()} m'
                              : '?',
                        ),
                      ],
                    ),
                    
                    // Creator info (optional)
                    if (showCreator && route.creatorName != null) ...[
                      const SizedBox(height: 8),
                      const Divider(height: 1),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: route.creatorImageUrl != null
                                ? NetworkImage(route.creatorImageUrl!)
                                : null,
                            child: route.creatorImageUrl == null
                                ? Text(
                                    route.creatorName![0].toUpperCase(),
                                    style: const TextStyle(fontSize: 8),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'by ${route.creatorName}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.map, color: Colors.grey, size: 40),
      ),
    );
  }

  Widget _buildStat(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.primaryDark),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  IconData _getRouteTypeIcon(String? routeType) {
    switch (routeType?.toLowerCase()) {
      case 'motorcycle':
        return Icons.motorcycle;
      case 'bicycle':
        return Icons.pedal_bike;
      case 'hiking':
        return Icons.directions_walk;
      case 'driving':
        return Icons.directions_car;
      case 'off-road':
        return Icons.terrain;
      default:
        return Icons.route;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'moderate':
        return Colors.orange;
      case 'difficult':
        return Colors.red;
      case 'expert':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
}
