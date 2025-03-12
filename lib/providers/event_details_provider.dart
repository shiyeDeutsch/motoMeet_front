import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/models/userModel.dart';
import 'package:motomeetfront/services/events_service.dart';

class EventDetailsNotifier extends StateNotifier<Event> {
  final EventsService _eventsService;

  // Create with a default empty event
  EventDetailsNotifier({
    EventsService? eventsService,
  })  : _eventsService = eventsService ?? GetIt.instance.get<EventsService>(),
        super(Event()); // Initialize with an empty Event
  
  Future<void> loadEventById(Event event) async {
    state = event;
  }

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
  
  // Added participant management functionality
  Future<void> approveParticipant(String userId) async {
    try {
      final success = await _eventsService.approveParticipant(state.id.toString(), userId);
      if (success) {
        // Update the state with the new event details
        final updatedEvent = await _eventsService.getEventById(state.id!);
        state = updatedEvent;
      }
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> rejectParticipant(String userId) async {
    try {
      final success = await _eventsService.rejectParticipant(state.id.toString(), userId);
      if (success) {
        // Update the state with the new event details
        final updatedEvent = await _eventsService.getEventById(state.id!);
        state = updatedEvent;
      }
    } catch (e) {
      // Handle error
    }
  }
  
  Future<void> removeParticipant(String userId) async {
    try {
      final success = await _eventsService.removeParticipant(state.id.toString(), userId);
      if (success) {
        // Update the state with the new event details
        final updatedEvent = await _eventsService.getEventById(state.id!);
        state = updatedEvent;
      }
    } catch (e) {
      // Handle error
    }
  }
  
  // Helper methods to work with participants locally
  List<UserInfo> getParticipants() {
    final participants = <UserInfo>[];
    for (final participant in state.participants) {
      final user = participant.person.value;
      if (user != null) {
        participants.add(user);
      }
    }
    return participants;
  }
  
  List<UserInfo> getPendingParticipants() {
    final pendingParticipants = <UserInfo>[];
    for (final participant in state.participants) {
      if (participant.isApproved == false && participant.person.value != null) {
        pendingParticipants.add(participant.person.value!);
      }
    }
    return pendingParticipants;
  }
  
  int getParticipantCount() {
    return state.participants.length;
  }
}

final eventDetailsProvider = StateNotifierProvider<EventDetailsNotifier, Event>(
  (ref) => EventDetailsNotifier(),
);

// Convenience providers for UI components that need direct access to participants
final eventParticipantsProvider = Provider.family<List<UserInfo>, Event>(
  (ref, event) {
    final participants = <UserInfo>[];
    for (final participant in event.participants) {
      final user = participant.person.value;
      if (user != null) {
        participants.add(user);
      }
    }
    return participants;
  },
);

final pendingParticipantsProvider = Provider.family<List<UserInfo>, Event>(
  (ref, event) {
    final pendingParticipants = <UserInfo>[];
    for (final participant in event.participants) {
      if (participant.isApproved == false && participant.person.value != null) {
        pendingParticipants.add(participant.person.value!);
      }
    }
    return pendingParticipants;
  },
);
