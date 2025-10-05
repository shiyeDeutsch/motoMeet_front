import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import '../services/routesService.dart';
import '../models/route.dart' as app_models;
import '../models/enum.dart';
// import '../providers/route_creation_provider.dart';
import '../services/distanceFormatter.dart';
import '../routing/routes.dart';

// -------------- Route Screen --------------
class RouteDetailsScreen extends ConsumerStatefulWidget {
  final app_models.Route route;

  const RouteDetailsScreen({
    Key? key,
    required this.route,
  }) : super(key: key);

  @override
  ConsumerState<RouteDetailsScreen> createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends ConsumerState<RouteDetailsScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  // Keys to identify each section
  final GlobalKey _detailsKey = GlobalKey();
  final GlobalKey _weatherKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _mediaKey = GlobalKey();

  // Store the top offsets for each section (we'll calculate after the layout)
  final List<double> _sectionOffsets = [0, 0, 0, 0];

  // Adjust this if you want to account for pinned heights (AppBar, Tab bar).
  // The pinned SliverAppBar collapses, so we only have a pinned 50px tab bar
  // once scrolled. This example approximates, but you can tweak as desired.
  final double _pinOffset = 50.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _tabController = TabController(length: 4, vsync: this);

    // Once the layout is rendered, measure and store each section's offset
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateSectionOffsets();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Calculate the Y-offset for each section by using context
  void _calculateSectionOffsets() {
    _sectionOffsets[0] = _getOffsetForKey(_detailsKey);
    _sectionOffsets[1] = _getOffsetForKey(_weatherKey);
    _sectionOffsets[2] = _getOffsetForKey(_reviewsKey);
    _sectionOffsets[3] = _getOffsetForKey(_mediaKey);
  }

  double _getOffsetForKey(GlobalKey key) {
    final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return 0;
    // Convert the box's local offset to the global coordinate system
    final position = box.localToGlobal(Offset.zero);
    // Then we add the current scroll offset so we have a stable reference.
    // For pinned bars, you might subtract their heights from this value.
    return position.dy + _scrollController.offset;
  }

  // Listener for the ScrollController
  void _onScroll() {
    final currentOffset = _scrollController.offset + _pinOffset;

    // Determine which section is visible
    // (This logic can be refined to handle partial overlaps.)
    for (int i = 0; i < _sectionOffsets.length; i++) {
      final start = _sectionOffsets[i];
      final end = (i == _sectionOffsets.length - 1)
          ? double.infinity
          : _sectionOffsets[i + 1] - 1;

      if (currentOffset >= start && currentOffset < end) {
        if (_tabController.index != i) {
          _tabController.animateTo(i);
        }
        break;
      }
    }
  }

  // Called when user taps on a tab
  void _onTabTapped(int index) {
    // Smoothly scroll to the chosen section
    _scrollController.animateTo(
      _sectionOffsets[index] - _pinOffset, 
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Start a trip on this route
  void _startTrip() {
    // Navigate to the map screen with this route as argument
    Navigator.of(context).pushReplacementNamed(
      Routes.map,
      arguments: {'baseRoute': widget.route},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // 1) Pinned Hero Image
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.route.name,
                style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
              background: widget.route.imageUrl != null && widget.route.imageUrl!.isNotEmpty
                ? Image.network(
                    widget.route.imageUrl!,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    'https://images.unsplash.com/photo-1520531158340-44015069e78e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1272&q=80',
                    fit: BoxFit.cover,
                  ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // share logic
                },
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_outline),
                onPressed: () {
                  // bookmark logic
                },
              ),
            ],
          ),

          // 2) Pinned Tab Header
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverTabHeaderDelegate(
              TabBar(
                controller: _tabController,
                onTap: _onTabTapped,
                // Make tabs fit the screen width
                tabs: const [
                  Tab(text: 'Details'),
                  Tab(text: 'Weather'),
                  Tab(text: 'Reviews'),
                  Tab(text: 'Media'),
                ],
                labelColor: colorScheme.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: colorScheme.secondary,
              ),
              theme.scaffoldBackgroundColor,
            ),
          ),

          // 3) Four continuous sections (one scroll)
          _buildDetailsSection(),
          _buildWeatherSection(),
          _buildReviewsSection(),
          _buildMediaSection(),

          // Optional bottom space
          SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      // FAB for "Start Trip" action
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'startTrip',
            onPressed: _startTrip,
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
            icon: const Icon(Icons.navigation),
            label: const Text('Start Trip'),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'downloadOffline',
            onPressed: () async {
              try {
                final routeId = widget.route.id;
                if (routeId != null) {
                  final service = GetIt.I<RoutesService>();
                  await service.downloadRouteForOffline(routeId);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Route saved for offline use')),
                  );
                } else {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cannot save: route has no ID')),
                  );
                }
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Offline save failed: $e')),
                );
              }
            },
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            icon: const Icon(Icons.download_for_offline),
            label: const Text('Download'),
          ),
        ],
      ),
    );
  }

  // SECTION: DETAILS
  Widget _buildDetailsSection() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = theme.brightness == Brightness.light 
        ? colorScheme.background 
        : theme.scaffoldBackgroundColor;
    
    return SliverToBoxAdapter(
      key: _detailsKey,
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Route Details',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Route type and difficulty
            Row(
              children: [
                _buildInfoChip(
                  icon: Icons.category,
                  label: widget.route.routeType?.toString().split('.').last ?? 'Unknown',
                ),
                const SizedBox(width: 8),
                if (widget.route.difficultyLevel?.level != null)
                  _buildInfoChip(
                    icon: Icons.trending_up,
                    label: widget.route.difficultyLevel!.level!,
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Route stats
            Card(
              elevation: theme.cardTheme.elevation,
              shape: theme.cardTheme.shape,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn(
                      icon: Icons.straighten,
                      value: widget.route.length != null
                          ? DistanceFormatter.formatDistance(widget.route.length!)
                          : 'N/A',
                      label: 'Distance',
                    ),
                    _buildStatColumn(
                      icon: Icons.timer,
                      value: widget.route.durationMinutes != null
                          ? '${(widget.route.durationMinutes! / 60).toStringAsFixed(1)} h'
                          : 'N/A',
                      label: 'Duration',
                    ),
                    _buildStatColumn(
                      icon: Icons.terrain,
                      value: widget.route.elevationGain != null
                          ? '${widget.route.elevationGain!.toStringAsFixed(0)} m'
                          : 'N/A',
                      label: 'Elevation',
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Description
            if (widget.route.description != null && widget.route.description!.isNotEmpty) ...[
              Text(
                'Description',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                widget.route.description!,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
            ],
            
            // Location
            if (widget.route.region != null || widget.route.country != null) ...[
              Text(
                'Location',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: colorScheme.error),
                  const SizedBox(width: 8),
                  Text(
                    [
                      if (widget.route.region != null) widget.route.region,
                      if (widget.route.country != null) widget.route.country,
                    ].where((e) => e != null).join(', '),
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            
            // Points of Interest
            if (widget.route.pointsOfInterest.isNotEmpty) ...[
              Text(
                'Points of Interest',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...widget.route.pointsOfInterest.map((poi) => ListTile(
                leading: Icon(_getPoiIcon(poi.waypointType), color: colorScheme.primary),
                title: Text(poi.name ?? 'Unnamed Point', style: theme.textTheme.bodyLarge),
                subtitle: Text(poi.description ?? '', style: theme.textTheme.bodySmall),
              )),
              const SizedBox(height: 16),
            ],
            
            // Created date
            if (widget.route.startDate != null) ...[
              Text(
                'Created',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat('MMMM d, yyyy').format(widget.route.startDate!),
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // SECTION: WEATHER
  Widget _buildWeatherSection() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final altBackgroundColor = theme.brightness == Brightness.light
        ? colorScheme.background.withOpacity(0.7)
        : theme.canvasColor;
    
    return SliverToBoxAdapter(
      key: _weatherKey,
      child: Container(
        color: altBackgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '5-Day Weather Forecast',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            for (int i = 1; i <= 5; i++)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                shape: theme.cardTheme.shape,
                child: ListTile(
                  leading: Icon(Icons.wb_sunny, color: colorScheme.tertiary),
                  title: Text('Day $i: Sunny, 24°C', style: theme.textTheme.bodyLarge),
                  subtitle: Text('Wind: 5km/h, Humidity: 60%', style: theme.textTheme.bodySmall),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // SECTION: REVIEWS
  Widget _buildReviewsSection() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = theme.brightness == Brightness.light 
        ? colorScheme.background 
        : theme.scaffoldBackgroundColor;
    
    return SliverToBoxAdapter(
      key: _reviewsKey,
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Reviews',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (widget.route.reviews.isEmpty) ...[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No reviews yet. Be the first to review!',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
            ] else ...[
              ...widget.route.reviews.map((review) => 
                _buildReviewCard(
                  review.username ?? 'Anonymous',
                  review.rating?.toInt() ?? 0,
                  review.comment ?? '',
                ),
              ),
            ],
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add review logic
                },
                child: const Text('Add Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(String user, int rating, String text) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: theme.cardTheme.shape,
      elevation: theme.cardTheme.elevation,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.primary,
          child: Text(user[0], style: TextStyle(color: colorScheme.onPrimary)),
        ),
        title: Row(
          children: [
            Text(user, style: theme.textTheme.titleMedium),
            const SizedBox(width: 8),
            Row(
              children: List.generate(5, (index) => 
                Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
        subtitle: Text(text, style: theme.textTheme.bodyMedium),
      ),
    );
  }

  // SECTION: MEDIA
  Widget _buildMediaSection() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final altBackgroundColor = theme.brightness == Brightness.light
        ? colorScheme.background.withOpacity(0.7)
        : theme.canvasColor;
    
    // Build a simple image carousel from route image and POI images
    final List<String> imageUrls = [
      if (widget.route.imageUrl != null && widget.route.imageUrl!.isNotEmpty)
        widget.route.imageUrl!,
      ...widget.route.pointsOfInterest
          .where((poi) => poi.imageUrl != null && poi.imageUrl!.isNotEmpty)
          .map((poi) => poi.imageUrl!),
    ];

    return SliverToBoxAdapter(
      key: _mediaKey,
      child: Container(
        color: altBackgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Photos & Videos',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (imageUrls.isEmpty)
              Container(
                height: 120,
                alignment: Alignment.center,
                child: Text('No media available', style: theme.textTheme.bodyMedium),
              )
            else
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: PageView.builder(
                    itemCount: imageUrls.length,
                    controller: PageController(viewportFraction: 0.92),
                    itemBuilder: (context, index) {
                      final url = imageUrls[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(color: Colors.black12),
                            Image.network(url, fit: BoxFit.cover),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // open camera/gallery logic
                },
                icon: const Icon(Icons.file_upload),
                label: const Text('Upload Photos'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn({
    required IconData icon,
    required String value,
    required String label,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      children: [
        Icon(icon, color: colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  IconData _getPoiIcon(WaypointType? type) {
    if (type == null) return Icons.location_on;
    
    switch (type) {
      case WaypointType.Lake:
      case WaypointType.River:
      case WaypointType.Waterfall:
      case WaypointType.WaterSpring:
      case WaypointType.Beach:
        return Icons.water;
      
      case WaypointType.MountainPeak:
      case WaypointType.Cliff:
      case WaypointType.Valley:
      case WaypointType.Glacier:
      case WaypointType.Volcano:
        return Icons.terrain;
      
      case WaypointType.Forest:
      case WaypointType.Meadow:
        return Icons.nature;
      
      case WaypointType.Cave:
        return Icons.dark_mode;
      
      case WaypointType.HistoricalSite:
      case WaypointType.Museum:
      case WaypointType.CulturalSite:
        return Icons.history_edu;
      
      case WaypointType.VisitorCenter:
      case WaypointType.ParkOffice:
        return Icons.info;
      
      case WaypointType.Viewpoint:
        return Icons.photo_camera;
      
      case WaypointType.EducationalTrail:
        return Icons.school;
      
      case WaypointType.SteepDrop:
      case WaypointType.SlipperyPath:
      case WaypointType.HighTide:
      case WaypointType.FloodingArea:
      case WaypointType.Rockfall:
      case WaypointType.RestrictedArea:
        return Icons.warning;
      
      case WaypointType.WildlifeSighting:
        return Icons.pets;
      
      default:
        return Icons.location_on;
    }
  }
}

// -------------- SliverPersistentHeader Delegate --------------
// This builds a pinned area of fixed height with a TabBar widget.
class _SliverTabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;

  _SliverTabHeaderDelegate(this.tabBar, this.backgroundColor);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor, // Using theme background color
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabHeaderDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar ||
           backgroundColor != oldDelegate.backgroundColor;
  }
}
