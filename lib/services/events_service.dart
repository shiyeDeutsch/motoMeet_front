import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/services/httpClient.dart';
import 'package:motomeetfront/services/isar/isar_event.dart';
import 'package:motomeetfront/services/isar/repository_provider.dart';
import 'package:motomeetfront/utilities/apiEndPoints.dart';

class EventsService {
  final _repositoryProvider = GetIt.I<RepositoryProvider>();
  
  EventRepository get _eventRepository =>
    _repositoryProvider.eventRepository;

  Future<List<Event>> getUpcomingEvents() async {
    try {
      // Try to get from API first
      final response = await HttpClient.get(
        EndPoints.upcomingEvents,
        headers: await _getAuthHeaders(),
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

  Future<Map<String, String>> _getAuthHeaders() async {
    // Implementation depends on your auth service
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer yourAuthTokenHere'
    };
  }

  // Get event participants
  Future<List<UserModel>> getEventParticipants(String eventId) async {
    try {
      final response = await _httpClient.get(
        '${ApiEndpoints.events}/$eventId/participants',
      );

      return (response.data as List)
          .map((userJson) => UserModel.fromJson(userJson))
          .toList();
    } catch (e) {
      throw Exception('Failed to load event participants: $e');
    }
  }

  // Get pending participants (for events with approval)
  Future<List<UserModel>> getPendingParticipants(String eventId) async {
    try {
      final response = await _httpClient.get(
        '${ApiEndpoints.events}/$eventId/pending-participants',
      );

      return (response.data as List)
          .map((userJson) => UserModel.fromJson(userJson))
          .toList();
    } catch (e) {
      throw Exception('Failed to load pending participants: $e');
    }
  }

  // Get event participant count
  Future<int> getEventParticipantCount(String eventId) async {
    try {
      final response = await _httpClient.get(
        '${ApiEndpoints.events}/$eventId/participants/count',
      );

      return response.data as int;
    } catch (e) {
      throw Exception('Failed to load participant count: $e');
    }
  }

  // Approve participant (for events with approval)
  Future<bool> approveParticipant(String eventId, String userId) async {
    try {
      final response = await _httpClient.post(
        '${ApiEndpoints.events}/$eventId/participants/$userId/approve',
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to approve participant: $e');
    }
  }

  // Reject participant (for events with approval)
  Future<bool> rejectParticipant(String eventId, String userId) async {
    try {
      final response = await _httpClient.post(
        '${ApiEndpoints.events}/$eventId/participants/$userId/reject',
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to reject participant: $e');
    }
  }

  // Remove participant
  Future<bool> removeParticipant(String eventId, String userId) async {
    try {
      final response = await _httpClient.delete(
        '${ApiEndpoints.events}/$eventId/participants/$userId',
      );

      return response.statusCode == 204;
    } catch (e) {
      throw Exception('Failed to remove participant: $e');
    }
  }

  // Check if the current user is the creator of the event
  Future<bool> isEventCreator(String eventId) async {
    try {
      final response = await _httpClient.get(
        '${ApiEndpoints.events}/$eventId/is-creator',
      );

      return response.data as bool;
    } catch (e) {
      throw Exception('Failed to check creator status: $e');
    }
  }

  // Check if the current user is a participant in the event
  Future<bool> isEventParticipant(String eventId) async {
    try {
      final response = await _httpClient.get(
        '${ApiEndpoints.events}/$eventId/is-participant',
      );

      return response.data as bool;
    } catch (e) {
      throw Exception('Failed to check participant status: $e');
    }
  }

  // Get the name of the event creator
  Future<String> getEventCreatorName(String eventId) async {
    try {
      final response = await _httpClient.get(
        '${ApiEndpoints.events}/$eventId/creator-name',
      );

      return response.data as String;
    } catch (e) {
      throw Exception('Failed to get creator name: $e');
    }
  }
}
