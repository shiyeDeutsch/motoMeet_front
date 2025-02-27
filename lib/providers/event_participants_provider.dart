import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/models/userModel.dart';
import 'package:motomeetfront/services/events_service.dart';
import 'package:motomeetfront/services/service_locator.dart';

final eventsServiceProvider = Provider<EventsService>((ref) {
  return getIt<EventsService>();
});

final eventParticipantsProvider = FutureProvider.family<List<UserModel>, String>((ref, eventId) async {
  final eventsService = ref.read(eventsServiceProvider);
  return await eventsService.getEventParticipants(eventId);
});

final pendingParticipantsProvider = FutureProvider.family<List<UserModel>, String>((ref, eventId) async {
  final eventsService = ref.read(eventsServiceProvider);
  return await eventsService.getPendingParticipants(eventId);
});

final eventParticipantCountProvider = FutureProvider.family<int, String>((ref, eventId) async {
  final participants = await ref.watch(eventParticipantsProvider(eventId).future);
  return participants.length;
});

class ParticipantManagementNotifier extends StateNotifier<AsyncValue<void>> {
  final EventsService _eventsService;
  final String eventId;
  
  ParticipantManagementNotifier({
    required this.eventId,
    EventsService? eventsService,
  }) : _eventsService = eventsService ?? getIt<EventsService>(),
       super(const AsyncValue.data(null));
  
  Future<void> approveParticipant(String userId) async {
    state = const AsyncValue.loading();
    try {
      await _eventsService.approveParticipant(eventId, userId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
  
  Future<void> rejectParticipant(String userId) async {
    state = const AsyncValue.loading();
    try {
      await _eventsService.rejectParticipant(eventId, userId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
  
  Future<void> removeParticipant(String userId) async {
    state = const AsyncValue.loading();
    try {
      await _eventsService.removeParticipant(eventId, userId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final participantManagementProvider = StateNotifierProvider.family<ParticipantManagementNotifier, AsyncValue<void>, String>(
  (ref, eventId) => ParticipantManagementNotifier(eventId: eventId),
);
