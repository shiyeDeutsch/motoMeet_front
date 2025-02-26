import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/models/activity.dart';
import 'package:motomeetfront/services/activity_service.dart';
import 'package:get_it/get_it.dart';

class ActivityNotifier extends StateNotifier<List<UserActivity>> {
  final ActivityService _activityService = GetIt.I<ActivityService>();
  int _page = 1;
  bool _hasMore = true;

  ActivityNotifier() : super([]);

  Future<void> loadActivities({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
    }
    
    if (!_hasMore && !refresh) return;

    try {
      final activities = await _activityService.getRecentActivities(
        page: _page,
        limit: 10,
      );

      if (refresh) {
        state = activities;
      } else {
        state = [...state, ...activities];
      }

      _hasMore = activities.length == 10;
      if (_hasMore) _page++;
    } catch (e) {
      // Handle error but don't change state
      rethrow;
    }
  }

  Future<void> loadMoreActivities() async {
    if (!_hasMore) return;
    return loadActivities();
  }

  void addActivity(UserActivity activity) {
    state = [activity, ...state];
  }
}

final activityProvider = StateNotifierProvider<ActivityNotifier, List<UserActivity>>((ref) {
  return ActivityNotifier();
});
