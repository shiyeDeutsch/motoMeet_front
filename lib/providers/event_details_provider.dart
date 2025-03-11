import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/services/events_service.dart';

class EventDetailsNotifier extends StateNotifier<Event> {
  final EventsService _eventsService;

  EventDetailsNotifier({
    required Event event,
    EventsService? eventsService,
  })  : _eventsService = eventsService ?? GetIt.instance.get<EventsService>(),
        super(event);

  Future<void> joinEvent() async {
    try {
      final success = await _eventsService.joinEvent(state.id!);
      if (success) {
        // Update the state with the new event details
        final updatedEvent = await _eventsService.getEventById(state.id!);
        state = updatedEvent;
      } else {
        // Handle failure
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> leaveEvent() async {
    try {
      final success = await _eventsService.leaveEvent(state.id!);
      if (success) {
        // Update the state with the new event details
        final updatedEvent = await _eventsService.getEventById(state.id!);
        state = updatedEvent;
      } else {
        // Handle failure
      }
    } catch (e) {
      // Handle error
    }
  }
}

final eventDetailsProvider = StateNotifierProvider.family<EventDetailsNotifier, Event, Event>(
  (ref, event) => EventDetailsNotifier(event: event),
);


