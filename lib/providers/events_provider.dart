import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/services/events_service.dart';

class UpcomingEventsNotifier extends StateNotifier<List<Event>> {
  final EventsService _eventsService = GetIt.I<EventsService>();

  UpcomingEventsNotifier() : super([]);

  Future<void> loadUpcomingEvents({bool refresh = false}) async {
    if (state.isNotEmpty && !refresh) return;

    try {
      final events = await _eventsService.getUpcomingEvents();
      state = events;
    } catch (e) {
      // Handle error
      rethrow;
    }
  }
}

final upcomingEventsProvider = StateNotifierProvider<UpcomingEventsNotifier, List<Event>>((ref) {
  return UpcomingEventsNotifier();
});
