import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/route.dart' as app_models;
import '../models/enum.dart';
import '../providers/routes_provider.dart';
import '../common/widgets/route_card.dart';
import '../widgets/loading_indicator.dart';

class DiscoverRoutesScreen extends ConsumerStatefulWidget {
  const DiscoverRoutesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DiscoverRoutesScreen> createState() => _DiscoverRoutesScreenState();
}

class _DiscoverRoutesScreenState extends ConsumerState<DiscoverRoutesScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isMapView = false;
  RouteType? _selectedRouteType;
  String _sortBy = 'Popular';

  // Map string display names to RouteType enum values
  final Map<String, RouteType?> _routeTypeMap = {
    'All': null,
    'Motorcycle': RouteType.motorcycle,
    'Hiking': RouteType.hiking,
    'Biking': RouteType.biking,
    'Jeep': RouteType.jeep,
  };

  // Get the display names for the UI
  List<String> get _categories => _routeTypeMap.keys.toList();

  final List<String> _sortOptions = [
    'Popular',
    'Distance',
    'Rating',
    'Recent',
  ];

  @override
  void initState() {
    super.initState();
    // Refresh routes when the screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(routesProvider.notifier).fetchRoutes();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(theme),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildSearchBar(),
                _buildFilters(),
              ],
            ),
          ),
          _isMapView ? _buildMapView() : _buildListView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isMapView = !_isMapView;
          });
        },
        child: Icon(_isMapView ? Icons.list : Icons.map),
      ),
    );
  }

  Widget _buildSliverAppBar(ThemeData theme) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Discover Routes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1520531158340-44015069e78e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1272&q=80',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search routes...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
        onChanged: (value) {
          ref.read(routesProvider.notifier).searchRoutes(value);
        },
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: _categories.map((category) {
              final routeType = _routeTypeMap[category];
              final isSelected = _selectedRouteType == routeType;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : null,
                      fontWeight: isSelected ? FontWeight.bold : null,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedRouteType = routeType;
                    });
                    ref.read(routesProvider.notifier).filterByRouteType(routeType);
                  },
                  backgroundColor: Theme.of(context).cardColor,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  elevation: 3,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Text(
                'Sort by: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: _sortBy,
                  items: _sortOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        _sortBy = newValue;
                      });
                      ref.read(routesProvider.notifier).sortRoutes(newValue);
                    }
                  },
                  underline: const SizedBox(),
                  icon: const Icon(Icons.arrow_drop_down),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return Consumer(
      builder: (context, ref, child) {
        final routesAsync = ref.watch(routesProvider);

        return routesAsync.when(
          data: (routes) {
            if (routes.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.route_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No routes found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final route = routes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: RouteCard(route: route),
                    );
                  },
                  childCount: routes.length,
                ),
              ),
            );
          },
          loading: () => const SliverFillRemaining(
            child: Center(
              child: LoadingIndicator(),
            ),
          ),
          error: (error, stack) => SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: $error',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMapView() {
    return SliverFillRemaining(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.map_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'Map View Coming Soon',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}