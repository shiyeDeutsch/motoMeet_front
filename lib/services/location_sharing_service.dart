import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:motomeetfront/models/locationShare.dart';
import 'package:motomeetfront/models/userModel.dart';
import 'package:motomeetfront/services/httpClient.dart';
import 'package:motomeetfront/services/isar/repository_provider.dart';
import 'package:motomeetfront/services/locationService.dart';
import 'package:motomeetfront/utilities/apiEndPoints.dart';

/// A service to handle location sharing between users
class LocationSharingService {
  final _repositoryProvider = GetIt.I<RepositoryProvider>();
  final _locationService = GetIt.I<LocationService>();
  
  // Stream controllers for new shared locations and session changes
  final _sharedLocationsController = StreamController<List<SharedLocation>>.broadcast();
  final _sessionsController = StreamController<List<LocationSharingSession>>.broadcast();
  
  // Stream to listen for new shared locations and active sessions
  Stream<List<SharedLocation>> get sharedLocations => _sharedLocationsController.stream;
  Stream<List<LocationSharingSession>> get activeSessions => _sessionsController.stream;
  
  // Keep track of active sharing
  bool _isSharingLocation = false;
  String? _activeSharingSessionId;
  
  // Keep track of updaters
  Timer? _locationUpdateTimer;
  Timer? _locationFetchTimer;
  
  // Default update interval in seconds
  int _updateIntervalSeconds = 5;
  
  /// Get repository shortcuts
  IsarSharedLocationRepository get _sharedLocationRepository => 
      _repositoryProvider.sharedLocationRepository;
  
  IsarLocationSharingSessionRepository get _locationSharingSessionRepository => 
      _repositoryProvider.locationSharingSessionRepository;
  
  /// Start sharing your location in a session
  /// Returns the session ID if successful, null otherwise
  Future<String?> startSharing({
    String? name,
    String? routeId,
    bool isPublic = true,
  }) async {
    if (_isSharingLocation) {
      debugPrint('Already sharing location in a session');
      return _activeSharingSessionId;
    }
    
    try {
      final user = await _repositoryProvider.userInfoRepository.getCurrentUser();
      if (user == null) {
        debugPrint('No user found. Cannot start sharing location.');
        return null;
      }
      
      // Create a session
      final session = LocationSharingSession(
        sessionId: const Uuid().v4(),
        createdById: user.id,
        name: name ?? '${user.displayName}\'s Route',
        routeId: routeId,
        startTime: DateTime.now(),
        isActive: true,
        isPublic: isPublic,
        shareCode: _generateShareCode(),
      );
      
      // Send to server
      final response = await HttpClient.post(
        uri: ApiEndpoints.createSharingSession,
        body: jsonEncode(session.toJson()),
      );
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        // Parse the session from response
        final responseData = jsonDecode(response.body);
        final createdSession = LocationSharingSession.fromJson(responseData);
        
        // Save locally
        await _locationSharingSessionRepository.add(createdSession);
        
        // Start sharing location updates
        _activeSharingSessionId = createdSession.sessionId;
        _isSharingLocation = true;
        _startLocationUpdates();
        
        // Fetch other users' locations
        _startFetchingLocations();
        
        return createdSession.sessionId;
      } else {
        debugPrint('Failed to create sharing session: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error starting location sharing: $e');
      return null;
    }
  }
  
  /// Stop sharing your location
  Future<bool> stopSharing() async {
    if (!_isSharingLocation || _activeSharingSessionId == null) {
      return true; // Already not sharing
    }
    
    try {
      // Stop the update timers
      _stopLocationUpdates();
      _stopFetchingLocations();
      
      // Update session on server
      if (_activeSharingSessionId != null) {
        final response = await HttpClient.post(
          uri: ApiEndpoints.leaveSharingSession(_activeSharingSessionId!),
          body: '{}', // Empty body for POST request
        );
        
        if (response.statusCode == 200) {
          // Update session locally
          await _locationSharingSessionRepository.endSession(_activeSharingSessionId!);
          
          _isSharingLocation = false;
          _activeSharingSessionId = null;
          return true;
        } else {
          debugPrint('Failed to leave sharing session: ${response.statusCode}');
          return false;
        }
      }
      
      return true;
    } catch (e) {
      debugPrint('Error stopping location sharing: $e');
      _isSharingLocation = false;
      _activeSharingSessionId = null;
      return false;
    }
  }
  
  /// Join an existing sharing session
  Future<bool> joinSession(String sessionId) async {
    if (_isSharingLocation) {
      await stopSharing(); // Stop any current sharing
    }
    
    try {
      final user = await _repositoryProvider.userInfoRepository.getCurrentUser();
      if (user == null) {
        debugPrint('No user found. Cannot join sharing session.');
        return false;
      }
      
      // Join session on server
      final response = await HttpClient.post(
        uri: ApiEndpoints.joinSharingSession(sessionId),
        body: '{}', // Empty body for POST request
      );
      
      if (response.statusCode == 200) {
        // Get session details
        final sessionResponse = await HttpClient.get(ApiEndpoints.getSharedLocations(sessionId));
        
        if (sessionResponse.statusCode == 200) {
          final data = jsonDecode(sessionResponse.body);
          
          // Get session info
          if (data['session'] != null) {
            final session = LocationSharingSession.fromJson(data['session']);
            await _locationSharingSessionRepository.add(session);
          }
          
          // Start sharing location
          _activeSharingSessionId = sessionId;
          _isSharingLocation = true;
          _startLocationUpdates();
          
          // Start fetching locations
          _startFetchingLocations();
          
          return true;
        } else {
          debugPrint('Failed to get session details: ${sessionResponse.statusCode}');
          return false;
        }
      } else {
        debugPrint('Failed to join sharing session: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error joining location sharing session: $e');
      return false;
    }
  }
  
  /// Get all active sharing sessions
  Future<List<LocationSharingSession>> getActiveSessions() async {
    try {
      // Try to get from API first
      final response = await HttpClient.get(ApiEndpoints.getSharingSessions());
      
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final sessions = data.map((json) => LocationSharingSession.fromJson(json)).toList();
        
        // Save locally
        await _locationSharingSessionRepository.saveSessions(sessions);
        
        // Notify listeners
        _sessionsController.add(sessions);
        
        return sessions;
      } else {
        // Fallback to local data
        return await _locationSharingSessionRepository.getActiveSessions();
      }
    } catch (e) {
      debugPrint('Error fetching active sharing sessions: $e');
      // Fallback to local data
      return await _locationSharingSessionRepository.getActiveSessions();
    }
  }
  
  /// Get shared locations for a session
  Future<List<SharedLocation>> getSharedLocations(String sessionId) async {
    try {
      // Try to get from API first
      final response = await HttpClient.get(ApiEndpoints.getSharedLocations(sessionId));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['locations'] != null) {
          final List<dynamic> locationsData = data['locations'];
          final locations = locationsData.map((json) => SharedLocation.fromJson(json)).toList();
          
          // Save locally
          await _sharedLocationRepository.saveLocations(locations);
          
          // Calculate distances from user if we have user's position
          _calculateDistancesFromUser(locations);
          
          // Notify listeners
          _sharedLocationsController.add(locations);
          
          return locations;
        }
        return [];
      } else {
        // Fallback to local data
        final locations = await _sharedLocationRepository.getLatestLocationsForSession(sessionId);
        
        // Calculate distances from user
        _calculateDistancesFromUser(locations);
        
        return locations;
      }
    } catch (e) {
      debugPrint('Error fetching shared locations: $e');
      // Fallback to local data
      return await _sharedLocationRepository.getLatestLocationsForSession(sessionId);
    }
  }
  
  /// Helper to calculate distances from user for all shared locations
  Future<void> _calculateDistancesFromUser(List<SharedLocation> locations) async {
    try {
      if (locations.isEmpty) return;
      
      final userPos = await _locationService.getCurrentPosition(useCacheIfAvailable: true);
      
      for (final location in locations) {
        if (location.latitude != null && location.longitude != null) {
          final distance = Geolocator.distanceBetween(
            userPos.latitude,
            userPos.longitude,
            location.latitude!,
            location.longitude!,
          );
          
          location.distanceFromUser = distance;
        }
      }
    } catch (e) {
      debugPrint('Error calculating distances from user: $e');
    }
  }
  
  /// Start sending periodic location updates
  void _startLocationUpdates() {
    _stopLocationUpdates(); // Stop any existing updates
    
    // Start a timer to update location periodically
    _locationUpdateTimer = Timer.periodic(Duration(seconds: _updateIntervalSeconds), (timer) {
      _sendLocationUpdate();
    });
    
    // Send an initial update immediately
    _sendLocationUpdate();
  }
  
  /// Stop sending location updates
  void _stopLocationUpdates() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = null;
  }
  
  /// Start fetching other users' locations periodically
  void _startFetchingLocations() {
    _stopFetchingLocations(); // Stop any existing fetches
    
    if (_activeSharingSessionId == null) return;
    
    // Start a timer to fetch locations periodically
    _locationFetchTimer = Timer.periodic(Duration(seconds: _updateIntervalSeconds), (timer) {
      getSharedLocations(_activeSharingSessionId!);
    });
    
    // Fetch immediately
    getSharedLocations(_activeSharingSessionId!);
  }
  
  /// Stop fetching locations
  void _stopFetchingLocations() {
    _locationFetchTimer?.cancel();
    _locationFetchTimer = null;
  }
  
  /// Send current location to the server
  Future<void> _sendLocationUpdate() async {
    if (!_isSharingLocation || _activeSharingSessionId == null) return;
    
    try {
      final user = await _repositoryProvider.userInfoRepository.getCurrentUser();
      if (user == null) return;
      
      // Get current position
      final position = await _locationService.getCurrentPosition();
      
      // Create shared location object
      final sharedLocation = SharedLocation.fromPosition(
        userId: user.id ?? '',
        userName: user.displayName ?? user.userName ?? 'Unknown user',
        latitude: position.latitude,
        longitude: position.longitude,
        altitude: position.altitude,
        heading: position.heading,
        speed: position.speed,
        accuracy: position.accuracy,
        sharingSessionId: _activeSharingSessionId,
      );
      
      // Send to server
      final response = await HttpClient.post(
        uri: ApiEndpoints.updateSharedLocation,
        body: jsonEncode(sharedLocation.toJson()),
      );
      
      if (response.statusCode == 200) {
        // Save locally
        await _sharedLocationRepository.add(sharedLocation);
      } else {
        debugPrint('Failed to update location: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error sending location update: $e');
    }
  }
  
  /// Generate a short share code for easy sharing
  String _generateShareCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = const Uuid().v4().replaceAll('-', '');
    
    // Use the first 6 characters of the UUID to create a code
    final code = StringBuffer();
    for (var i = 0; i < 6; i++) {
      final index = int.parse(random[i], radix: 16) % chars.length;
      code.write(chars[index]);
    }
    
    return code.toString();
  }
  
  /// Update location sharing settings
  void updateSettings({int? updateIntervalSeconds}) {
    if (updateIntervalSeconds != null && updateIntervalSeconds > 0) {
      _updateIntervalSeconds = updateIntervalSeconds;
      
      // Restart timers if active
      if (_isSharingLocation) {
        _startLocationUpdates();
        _startFetchingLocations();
      }
    }
  }
  
  /// Check if currently sharing location
  bool get isSharingLocation => _isSharingLocation;
  
  /// Get active sharing session ID
  String? get activeSharingSessionId => _activeSharingSessionId;
  
  /// Dispose of resources
  void dispose() {
    _stopLocationUpdates();
    _stopFetchingLocations();
    _sharedLocationsController.close();
    _sessionsController.close();
  }
} 