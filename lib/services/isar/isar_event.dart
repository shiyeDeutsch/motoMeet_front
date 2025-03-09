import 'package:isar/isar.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/models/userModel.dart';
import 'package:motomeetfront/services/isar/isar_repository.dart';

/// Repository for handling Event local storage operations
class EventRepository extends BaseRepository<Event> {
  EventRepository(Isar isar) : super(isar, isar.events);

  /// Get upcoming events starting from a given date
  Future<List<Event>> getUpcomingEvents(DateTime fromDate) async {
    return await isar.writeTxn(() async {
      return await isar.events
          .filter()
          .startDateTimeGreaterThan(fromDate)
          .sortByStartDateTime()
          .findAll();
    });
  }

  /// Get events the user is participating in
  Future<List<Event>> getUserEvents(int userId) async {
    // Use the link() method to navigate the relationships properly
    final events = await isar.events
        .filter()
        .participants(
            (q) => q.person((p) => UserInfoQueryFilter(p).idEqualTo(userId)))
        .findAll();

    return events;
  }

  /// Get events created by a specific user
  Future<List<Event>> getUserCreatedEvents(int userId) async {
    final events = await isar.events
        .filter()
        .creator((q) => UserInfoQueryFilter(q).idEqualTo(userId))
        .findAll();

    return events;
  }

  /// Get popular events (e.g., events with most participants)
  Future<List<Event>> getPopularEvents({int limit = 10}) async {
    final allEvents = await isar.events.where().findAll();

    // Sort events by number of participants
    allEvents.sort((a, b) {
      final aParticipants =
          (a.participants.loadSync() as List<EventParticipant>).length;
      final bParticipants =
          (b.participants.loadSync() as List<EventParticipant>).length;
      return bParticipants.compareTo(aParticipants); // Descending order
    });

    // Return top events
    return allEvents.take(limit).toList();
  }

  /// Save multiple events
  Future<void> saveEvents(List<Event> events) async {
    await isar.writeTxn(() async {
      for (final event in events) {
        await isar.events.put(event);

        // Save related objects if needed
        if (event.stages.isNotEmpty) {
          for (final stage in event.stages) {
            await isar.eventStages.put(stage);
          }
        }

        if (event.requiredItems.isNotEmpty) {
          for (final item in event.requiredItems) {
            await isar.eventItems.put(item);
          }
        }
      }
    });
  }

  /// Check if user is participant in an event
  Future<bool> isUserParticipant(int eventId, int userId) async {
    final event = await getById(eventId);
    if (event == null) return false;

    final participants =
        await event.participants.load() as List<EventParticipant>;
    return participants
        .any((p) => (p.person.loadSync() as UserInfo?)?.id == userId);
  }

  /// Check if user is creator of an event
  Future<bool> isUserCreator(int eventId, int userId) async {
    final event = await getById(eventId);
    if (event == null) return false;

    final creator = await event.creator.load() as UserInfo?;
    return creator?.id == userId;
  }

  /// Add participant to event
  Future<void> addParticipant(int eventId, int userId,
      {bool approved = false}) async {
    final event = await getById(eventId);
    if (event == null) return;

    await isar.writeTxn(() async {
      // Check if participant already exists
      final existingParticipants =
          await event.participants.load() as List<EventParticipant>;
      final alreadyExists = existingParticipants
          .any((p) => (p.person.loadSync() as UserInfo?)?.id == userId);

      if (!alreadyExists) {
        final participant = EventParticipant()
          ..isApproved = approved
          ..isActive = true
          ..joinedOn = DateTime.now();

        // Link user - requires additional lookup
        final user =
            await isar.userInfos.filter().idEqualTo(userId).findFirst();
        if (user != null) {
          participant.person.value = user;
        }

        // Save participant and link to event
        await isar.eventParticipants.put(participant);
        event.participants.add(participant);
        await event.participants.save();
      }
    });
  }

  /// Remove participant from event
  Future<void> removeParticipant(int eventId, int userId) async {
    final event = await getById(eventId);
    if (event == null) return;

    await isar.writeTxn(() async {
      final participants =
          await event.participants.load() as List<EventParticipant>;
      
      final participantToRemove = participants.where(
        (p) => (p.person.loadSync() as UserInfo?)?.id == userId
      ).firstOrNull;

      if (participantToRemove != null && participantToRemove.id != null) {
        event.participants.remove(participantToRemove);
        await event.participants.save();
        await isar.eventParticipants.delete(participantToRemove.id!);
      }
    });
  }

  /// Approve participant
  Future<void> approveParticipant(int eventId, int userId) async {
    final event = await getById(eventId);
    if (event == null) return;

    await isar.writeTxn(() async {
      final participants = await event.participants.load() as List<EventParticipant>;
      
      final participant = participants.where(
        (p) => (p.person.loadSync() as UserInfo?)?.id == userId
      ).firstOrNull;

      if (participant != null) {
        participant.isApproved = true;
        await isar.eventParticipants.put(participant);
      }
    });
  }

  /// Get event participant count
  Future<int> getParticipantCount(int eventId) async {
    final event = await getById(eventId);
    if (event == null) return 0;

    final participants =
        await event.participants.load() as List<EventParticipant>;
    return participants.length;
  }
}
