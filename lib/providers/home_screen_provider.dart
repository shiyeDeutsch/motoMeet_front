import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/providers/activity_provider.dart';
import 'package:motomeetfront/providers/events_provider.dart';
import 'package:motomeetfront/providers/routes_provider.dart';
import 'package:motomeetfront/services/activity_service.dart';
import 'package:motomeetfront/services/events_service.dart';
import 'package:motomeetfront/services/routeService.dart';
import 'package:motomeetfront/services/userService.dart';
import 'package:get_it/get_it.dart';

class HomeScreenState {
  final bool isInitialLoading;
  final bool isLoadingMore;
  final bool hasError;
  final String? errorMessage;

  HomeScreenState({
    this.isInitialLoading = false, 
    this.isLoadingMore = false,
    this.hasError = false,
    this.errorMessage,
  });

  HomeScreenState copyWith({
    bool? isInitialLoading,
    bool? isLoadingMore,
    bool? hasError,
    String? errorMessage,
  }) {
    return HomeScreenState(
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class HomeScreenNotifier extends StateNotifier<HomeScreenState> {
  final ActivityService _activityService = GetIt.I<ActivityService>();
  final RouteService _routeService = GetIt.I<RouteService>();
  final EventsService _eventsService = GetIt.I<EventsService>();
  final UserServce _userService = GetIt.I<UserServce>();
  final Reader read;

  HomeScreenNotifier(this.read) : super(HomeScreenState());

  Future<void> initialize() async {
    if (state.isInitialLoading) return;
    state = state.copyWith(isInitialLoading: true, hasError: false);

    try {
      // Load all data in parallel
      await Future.wait([
        _loadUserProfile(),
        _loadActivities(),
        _loadRecommendedRoutes(),
        _loadUpcomingEvents(),
      ]);
      
      state = state.copyWith(isInitialLoading: false);
    } catch (e) {
      state = state.copyWith(
        isInitialLoading: false, 
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refreshAll() async {
    state = state.copyWith(hasError: false);

    try {
      // Refresh all data in parallel
      await Future.wait([
        _loadUserProfile(),
        _loadActivities(refresh: true),
        _loadRecommendedRoutes(refresh: true),
        _loadUpcomingEvents(refresh: true),
      ]);
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> _loadUserProfile() async {
    // Get the current auth token from storage
    final token = await _userService.getToken();
    if (token != null) {
      await _userService.fetchUserProfile(token);
    }
  }

  Future<void> _loadActivities({bool refresh = false}) async {
    await read(activityProvider.notifier).loadActivities(refresh: refresh);
  }

  Future<void> _loadRecommendedRoutes({bool refresh = false}) async {
    await read(recommendedRoutesProvider.notifier).loadRecommendedRoutes(refresh: refresh);
  }

  Future<void> _loadUpcomingEvents({bool refresh = false}) async {
    await read(upcomingEventsProvider.notifier).loadUpcomingEvents(refresh: refresh);
  }
}

final homeScreenProvider = StateNotifierProvider<HomeScreenNotifier, HomeScreenState>((ref) {
  return HomeScreenNotifier(ref.read);
});
