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
}
