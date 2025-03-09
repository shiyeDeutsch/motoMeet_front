import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/services/httpClient.dart';
import 'package:motomeetfront/services/isar/isar_event.dart';
import 'package:motomeetfront/services/isar/repository_provider.dart';
import 'package:motomeetfront/utilities/apiEndPoints.dart';
import 'package:motomeetfront/models/userModel.dart';

class EventsService {
  final _repositoryProvider = GetIt.I<RepositoryProvider>();

  EventRepository get _eventRepository => _repositoryProvider.eventRepository;

  // Get event by ID
  Future<Event> getEventById(int eventId) async {
    try {
      // Try to get from API first
      final response = await HttpClient.get(
        Uri(
          scheme: ApiEndpoints.scheme,
          host: ApiEndpoints.host,
          port: ApiEndpoints.port,
          path: 'api/events/$eventId',
        ),
      );

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final event = Event.fromJson(data);

        // Save to local database
        await _eventRepository.saveEvents([event]);

        return event;
      }

      // If API fails, try to get from local database
      return await _getEventByIdFromLocal(eventId);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching event by ID: $e');
      }

      // On error, try to get from local database
      return await _getEventByIdFromLocal(eventId);
    }
  }

  Future<Event> _getEventByIdFromLocal(int eventId) async {
    final event = await _eventRepository.getById(eventId);
    if (event == null) {
      throw Exception('Event not found with ID: $eventId');
    }
    return event;
  }

  Future<List<Event>> getUpcomingEvents() async {
    try {
      // Try to get from API first
      final response = await HttpClient.get(
        ApiEndpoints.upcomingEvents,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final events = data.map((json) => Event.fromJson(json)).toList();

        // Save to local database
        await _saveEventsToLocal(events);

        return events;
      }

      // If API fails or we're offline, get from local database
      return await _getEventsFromLocal();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching events: $e');
      }

      // On error, try to get from local database
      return await _getEventsFromLocal();
    }
  }

  Future<List<Event>> _getEventsFromLocal() async {
    final now = DateTime.now();
    return await _eventRepository.getUpcomingEvents(now);
  }

  Future<void> _saveEventsToLocal(List<Event> events) async {
    await _eventRepository.saveEvents(events);
  }

  // Join an event
  Future<bool> joinEvent(int eventId) async {
    try {
      final response = await HttpClient.post(
        uri: Uri(
          scheme: ApiEndpoints.scheme,
          host: ApiEndpoints.host,
          port: ApiEndpoints.port,
          path: 'api/events/$eventId/join',
        ),
        body: '{}', // Empty JSON body or could include user ID if needed
      );

      if (response.statusCode == 200) {
        // Update local database to reflect the change
        final event = await getEventById(eventId);
        await _eventRepository.addParticipant(
          eventId,
          0, // Will use currently authenticated user ID
          approved: !event.requiresApproval!,
        );
        return true;
      } else {
        if (kDebugMode) {
          print('Failed to join event: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error joining event: $e');
      }
      return false;
    }
  }

  // Leave an event
  Future<bool> leaveEvent(int eventId) async {
    try {
      final response = await HttpClient.post(
        uri: Uri(
          scheme: ApiEndpoints.scheme,
          host: ApiEndpoints.host,
          port: ApiEndpoints.port,
          path: 'api/events/$eventId/leave',
        ),
        body: '{}', // Empty JSON body
      );

      if (response.statusCode == 200) {
        // Update local database to reflect the change
        await _eventRepository.removeParticipant(
          eventId,
          0, // Will use currently authenticated user ID
        );
        return true;
      } else {
        if (kDebugMode) {
          print('Failed to leave event: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error leaving event: $e');
      }
      return false;
    }
  }

  // // Cancel an event (only for creator)
  // Future<bool> cancelEvent(int eventId) async {
  //   try {
  //     final response = await HttpClient.post(
  //       uri: Uri(
  //         scheme: ApiEndpoints.scheme,
  //         host: ApiEndpoints.host,
  //         port: ApiEndpoints.port,
  //         path: 'api/events/$eventId/cancel',
  //       ),
  //       body: '{}', // Empty JSON body
  //     );

  //     if (response.statusCode == 200) {
  //       // Update local database to reflect the change
  //       final event = await _eventRepository.getById(eventId);
  //       if (event != null) {
  //         event.isCancelled = true;
  //         await _eventRepository.saveEvents([event]);
  //       }
  //       return true;
  //     } else {
  //       if (kDebugMode) {
  //         print('Failed to cancel event: ${response.statusCode}');
  //       }
  //       return false;
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error cancelling event: $e');
  //     }
  //     return false;
  //   }
 // }

  // Get event participants
  Future<List<UserInfo>> getEventParticipants(String eventId) async {
    try {
      final response =
          await HttpClient.get(ApiEndpoints.getEventParticipants(eventId));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((userJson) => UserInfo.fromJson(userJson)).toList();
      } else {
        throw Exception('Failed to load participants: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading event participants: $e');
      }
      throw Exception('Failed to load event participants: $e');
    }
  }

  // Get pending participants (for events with approval)
  Future<List<UserInfo>> getPendingParticipants(String eventId) async {
    try {
      final response =
          await HttpClient.get(ApiEndpoints.getPendingParticipants(eventId));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((userJson) => UserInfo.fromJson(userJson)).toList();
      } else {
        throw Exception(
            'Failed to load pending participants: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading pending participants: $e');
      }
      throw Exception('Failed to load pending participants: $e');
    }
  }

  // Get event participant count
  Future<int> getEventParticipantCount(int eventId) async {
    try {
      final response =
          await HttpClient.get(ApiEndpoints.getParticipantCount(eventId));

      if (response.statusCode == 200) {
        return json.decode(response.body) as int;
      } else {
        throw Exception(
            'Failed to load participant count: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading participant count: $e');
      }
      throw Exception('Failed to load participant count: $e');
    }
  }

  // Approve participant (for events with approval)
  Future<bool> approveParticipant(String eventId, String userId) async {
    try {
      final response = await HttpClient.post(
        uri: ApiEndpoints.approveParticipant(eventId, userId),
        body: '{}', // Empty JSON body
      );

      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error approving participant: $e');
      }
      throw Exception('Failed to approve participant: $e');
    }
  }

  // Reject participant (for events with approval)
  Future<bool> rejectParticipant(String eventId, String userId) async {
    try {
      final response = await HttpClient.post(
        uri: ApiEndpoints.rejectParticipant(eventId, userId),
        body: '{}', // Empty JSON body
      );

      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error rejecting participant: $e');
      }
      throw Exception('Failed to reject participant: $e');
    }
  }

  // Remove participant
  Future<bool> removeParticipant(String eventId, String userId) async {
    try {
      // Using the static method
      final response = await HttpClient.client.delete(
        ApiEndpoints.removeParticipant(eventId, userId),
        headers: {
          'Content-Type': 'application/json',
          // Auth token will be added by HttpClient._getAuthToken if available
        },
      );

      return response.statusCode == 204;
    } catch (e) {
      if (kDebugMode) {
        print('Error removing participant: $e');
      }
      throw Exception('Failed to remove participant: $e');
    }
  }

  // Check if the current user is the creator of the event
  Future<bool> isEventCreator(int eventId) async {
    try {
      final response =
          await HttpClient.get(ApiEndpoints.isEventCreator(eventId));

      if (response.statusCode == 200) {
        return json.decode(response.body) as bool;
      } else {
        throw Exception(
            'Failed to check creator status: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking creator status: $e');
      }
      throw Exception('Failed to check creator status: $e');
    }
  }

  // Check if the current user is a participant in the event
  Future<bool> isEventParticipant(int eventId) async {
    try {
      final response =
          await HttpClient.get(ApiEndpoints.isEventParticipant(eventId));

      if (response.statusCode == 200) {
        return json.decode(response.body) as bool;
      } else {
        throw Exception(
            'Failed to check participant status: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking participant status: $e');
      }
      throw Exception('Failed to check participant status: $e');
    }
  }

  // Get the name of the event creator
  Future<String> getEventCreatorName(int eventId) async {
    try {
      final response =
          await HttpClient.get(ApiEndpoints.getEventCreatorName(eventId));

      if (response.statusCode == 200) {
        return json.decode(response.body) as String;
      } else {
        throw Exception('Failed to get creator name: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting creator name: $e');
      }
      throw Exception('Failed to get creator name: $e');
    }
  }
}