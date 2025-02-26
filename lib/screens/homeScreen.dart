import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/common/widgets/activity_feed_item.dart';
import 'package:motomeetfront/common/widgets/event_card.dart';
import 'package:motomeetfront/common/widgets/loading_indicator.dart';
import 'package:motomeetfront/common/widgets/route_card.dart';
import 'package:motomeetfront/common/widgets/search_bar.dart';
import 'package:motomeetfront/models/activity.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/models/newRoute.dart';
import 'package:motomeetfront/providers/activity_provider.dart';
import 'package:motomeetfront/providers/events_provider.dart';
import 'package:motomeetfront/providers/home_screen_provider.dart';
import 'package:motomeetfront/providers/routes_provider.dart';
import 'package:motomeetfront/services/isar/repository_provider.dart';
import 'package:motomeetfront/common/theme/colors.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    // Load initial data
    Future.microtask(() {
      ref.read(homeScreenProvider.notifier).initialize();
    });

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= 
          _scrollController.position.maxScrollExtent - 200 &&
          !_isRefreshing) {
        _loadMoreActivities();
      }
    });
  }

  Future<void> _loadMoreActivities() async {
    setState(() => _isRefreshing = true);
    await ref.read(activityProvider.notifier).loadMoreActivities();
    setState(() => _isRefreshing = false);
  }

  Future<void> _handleRefresh() async {
    await ref.read(homeScreenProvider.notifier).refreshAll();
    return;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeScreenProvider);
    final activities = ref.watch(activityProvider);
    final upcomingEvents = ref.watch(upcomingEventsProvider);
    final recommendedRoutes = ref.watch(recommendedRoutesProvider);
    
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // App Bar with search
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.white,
                elevation: 0,
                title: const Text(
                  'MotoMeet',
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: AppColors.primaryDark),
                    onPressed: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline, color: AppColors.primaryDark),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: HomeSearchBar(
                      onTap: () {
                        Navigator.pushNamed(context, '/search');
                      },
                    ),
                  ),
                ),
              ),

              // Error state
              if (homeState.hasError)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            'Something went wrong',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => ref.read(homeScreenProvider.notifier).refreshAll(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Initial loading state
              if (homeState.isInitialLoading && !homeState.hasError)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: Center(
                      child: CustomLoadingIndicator(size: 50),
                    ),
                  ),
                ),

              // Content when loaded
              if (!homeState.isInitialLoading || activities.isNotEmpty)
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recommended Routes Section
                      _buildRecommendedRoutes(recommendedRoutes, context),

                      // Upcoming Events Section
                      _buildUpcomingEvents(upcomingEvents, context),
                    ],
                  ),
                ),

              // Activity feed heading
              if (!homeState.isInitialLoading || activities.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Activity',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/activity');
                              },
                              child: const Text('View All'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              // Activity feed list
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index >= activities.length) {
                      return homeState.isLoadingMore
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(child: CustomLoadingIndicator(size: 30)),
                            )
                          : const SizedBox.shrink();
                    }
                    return ActivityFeedItem(
                      activity: activities[index],
                      onTap: () {
                        _navigateToActivityDetail(context, activities[index]);
                      },
                    );
                  },
                  childCount: activities.isEmpty
                      ? 0
                      : homeState.isLoadingMore
                          ? activities.length + 1
                          : activities.length,
                ),
              ),

              // Empty state
              if (!homeState.isInitialLoading && activities.isEmpty && !homeState.hasError)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(Icons.auto_awesome, size: 48, color: Colors.amber),
                          const SizedBox(height: 16),
                          Text(
                            'No activity yet',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Follow friends or join groups to see their activities here',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/discover');
                            },
                            child: const Text('Discover People & Groups'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToActivityDetail(BuildContext context, UserActivity activity) {
    switch (activity.activityType) {
      case ActivityType.routeCompleted:
      case ActivityType.routeCreated:
        Navigator.pushNamed(context, '/routes/detail', arguments: activity.routeId);
        break;
      case ActivityType.eventJoined:
      case ActivityType.eventCreated:
        Navigator.pushNamed(context, '/events/detail', arguments: activity.eventId);
        break;
      case ActivityType.groupJoined:
      case ActivityType.groupCreated:
        Navigator.pushNamed(context, '/groups/detail', arguments: activity.groupId);
        break;
      default:
        // Handle other activity types or show activity details
        break;
    }
  }

  Widget _buildRecommendedRoutes(List<NewRoute> routes, BuildContext context) {
    if (routes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended Routes',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/routes/discover');
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: routes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RouteCard(
                  route: routes[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context, 
                      '/routes/detail',
                      arguments: routes[index].isarId,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingEvents(List<Event> events, BuildContext context) {
    if (events.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upcoming Events',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/events');
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: EventCard(
                  event: events[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context, 
                      '/events/detail',
                      arguments: events[index].id,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
