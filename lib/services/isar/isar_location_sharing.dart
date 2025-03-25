import 'package:isar/isar.dart';
import 'package:motomeetfront/models/locationShare.dart';
import 'package:motomeetfront/services/isar/isar_repository.dart';

/// Repository for handling SharedLocation local storage operations
class IsarSharedLocationRepository extends BaseRepository<SharedLocation> {
  IsarSharedLocationRepository(Isar isar) : super(isar, isar.sharedLocations);

  /// Get all locations for a specific sharing session
  Future<List<SharedLocation>> getLocationsForSession(String sessionId) async {
    return await read((isar) async {
      return await isar.sharedLocations
          .filter()
          .sharingSessionIdEqualTo(sessionId)
          .findAll();
    });
  }

  /// Save a list of shared locations to the database
  Future<void> saveLocations(List<SharedLocation> locations) async {
    await write((isar) async {
      await isar.sharedLocations.putAll(locations);
    });
  }

  /// Delete all shared locations for a session
  Future<void> deleteLocationsForSession(String sessionId) async {
    await write((isar) async {
      final locationIds = await isar.sharedLocations
          .filter()
          .sharingSessionIdEqualTo(sessionId)
          .idProperty()
          .findAll();
      
      await isar.sharedLocations.deleteAll(locationIds);
    });
  }

  /// Get most recent shared locations for each user in a session
  Future<List<SharedLocation>> getLatestLocationsForSession(String sessionId) async {
    return await read((isar) async {
      // Get unique user IDs in the session
      final userIds = await isar.sharedLocations
          .filter()
          .sharingSessionIdEqualTo(sessionId)
          .userIdProperty()
          .findAll();
      
      final uniqueUserIds = userIds.toSet();
      final latestLocations = <SharedLocation>[];
      
      // For each user ID, get the most recent location
      for (final userId in uniqueUserIds) {
        if (userId == null) continue;
        
        final location = await isar.sharedLocations
            .filter()
            .sharingSessionIdEqualTo(sessionId)
            .and()
            .userIdEqualTo(userId)
            .sortByLastUpdatedDesc()
            .findFirst();
        
        if (location != null) {
          latestLocations.add(location);
        }
      }
      
      return latestLocations;
    });
  }
}

/// Repository for handling LocationSharingSession local storage operations
class IsarLocationSharingSessionRepository extends BaseRepository<LocationSharingSession> {
  IsarLocationSharingSessionRepository(Isar isar) : super(isar, isar.locationSharingSessions);

  /// Get all active sharing sessions
  Future<List<LocationSharingSession>> getActiveSessions() async {
    return await read((isar) async {
      return await isar.locationSharingSessions
          .filter()
          .isActiveEqualTo(true)
          .findAll();
    });
  }

  /// Get a session by its session ID
  Future<LocationSharingSession?> getBySessionId(String sessionId) async {
    return await read((isar) async {
      return await isar.locationSharingSessions
          .filter()
          .sessionIdEqualTo(sessionId)
          .findFirst();
    });
  }

  /// Get sharing sessions for a specific route
  Future<List<LocationSharingSession>> getSessionsForRoute(String routeId) async {
    return await read((isar) async {
      return await isar.locationSharingSessions
          .filter()
          .routeIdEqualTo(routeId)
          .findAll();
    });
  }

  /// End a sharing session
  Future<void> endSession(String sessionId) async {
    await write((isar) async {
      final session = await isar.locationSharingSessions
          .filter()
          .sessionIdEqualTo(sessionId)
          .findFirst();
      
      if (session != null) {
        session.isActive = false;
        session.endTime = DateTime.now();
        await isar.locationSharingSessions.put(session);
      }
    });
  }

  /// Save a list of sharing sessions
  Future<void> saveSessions(List<LocationSharingSession> sessions) async {
    await write((isar) async {
      await isar.locationSharingSessions.putAll(sessions);
    });
  }
} 