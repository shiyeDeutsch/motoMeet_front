import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/services/events_service.dart';
import 'package:motomeetfront/services/service_locator.dart';

class EventDetailsState {
  final Event? event;
  final bool isLoading;
  final String? error;
  final bool isCreator;
  final bool isParticipant;
  final String? creatorName;
  final int participantCount;
  
  bool get hasStages => event?.eventStages.isNotEmpty ?? false;
  bool get hasRequiredItems => event?.requiredItems.isNotEmpty ?? false;
  bool get hasActivities => event?.eventActivities.isNotEmpty ?? false;

  EventDetailsState({
    this.event,
    this.isLoading = false,
    this.error,
    this.isCreator = false,
    this.isParticipant = false,
    this.creatorName,
    this.participantCount = 0,
  });

  EventDetailsState copyWith({
    Event? event,
    bool? isLoading,
    String? error,
    bool? isCreator,
    bool? isParticipant,
    String? creatorName,
    int? participantCount,
  }) {
    return EventDetailsState(
      event: event ?? this.event,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isCreator: isCreator ?? this.isCreator,
      isParticipant: isParticipant ?? this.isParticipant,
      creatorName: creatorName ?? this.creatorName,
      participantCount: participantCount ?? this.participantCount,
    );
  }
}

class EventDetailsNotifier extends StateNotifier<EventDetailsState> {
  final String eventId;
  final EventsService _eventsService;

  EventDetailsNotifier({
    required this.eventId,
    EventsService? eventsService,
  })  : _eventsService = eventsService ?? getIt<EventsService>(),
        super(EventDetailsState(isLoading: true)) {
    loadEventDetails();
  }

  Future<void> loadEventDetails({bool refresh = false}) async {
    if (!refresh && state.event != null) {
      return;
    }
    
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final event = await _eventsService.getEventById(eventId);
      final isCreator = await _eventsService.isEventCreator(eventId);
      final isParticipant = await _eventsService.isEventParticipant(eventId);
      final creatorName = await _eventsService.getEventCreatorName(eventId);
      final participantCount = await _eventsService.getEventParticipantCount(eventId);
      
      state = state.copyWith(
        event: event,
        isLoading: false,
        isCreator: isCreator,
        isParticipant: isParticipant,
        creatorName: creatorName,
        participantCount: participantCount,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> joinEvent() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final success = await _eventsService.joinEvent(eventId);
      if (success) {
        await loadEventDetails(refresh: true);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to join event',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> leaveEvent() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final success = await _eventsService.leaveEvent(eventId);
      if (success) {
        await loadEventDetails(refresh: true);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to leave event',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> cancelEvent() async {
    if (!state.isCreator) {
      state = state.copyWith(
        error: 'Only the creator can cancel this event',
      );
      return;
    }
    
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final success = await _eventsService.cancelEvent(eventId);
      if (!success) {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to cancel event',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final eventDetailsProvider = StateNotifierProvider.family<EventDetailsNotifier, EventDetailsState, String>(
  (ref, eventId) => EventDetailsNotifier(eventId: eventId),
);
