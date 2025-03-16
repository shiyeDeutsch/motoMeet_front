import 'package:isar/isar.dart';
import '../../models/newRoute.dart';
import 'isar_repository.dart';

/// Repository for Route entities
class IsarRouteRepository extends BaseRepository<Route> {
  IsarRouteRepository(Isar isar) : super(isar, isar.routes);

  // Find routes by name (partial match)
  Future<List<Route>> findByName(String name) async {
    return await collection.filter()
        .nameContains(name, caseSensitive: false)
        .findAll();
  }

  // Find routes by type
  Future<List<Route>> findByType(RouteType type) async {
    return await collection.filter()
        .routeTypeEqualTo(type)
        .findAll();
  }

  // Find routes by country
  Future<List<Route>> findByCountry(String country) async {
    return await collection.filter()
        .countryEqualTo(country)
        .findAll();
  }

  // Find routes by region
  Future<List<Route>> findByRegion(String region) async {
    return await collection.filter()
        .regionEqualTo(region)
        .findAll();
  }

  // Find routes with rating greater than or equal to a value
  Future<List<Route>> findByMinRating(double minRating) async {
    return await collection.filter()
        .ratingGreaterThanOrEqualTo(minRating)
        .findAll();
  }

  // Find routes that are loops
  Future<List<Route>> findLoops() async {
    return await collection.filter()
        .isLoopEqualTo(true)
        .findAll();
  }

  // Find routes with points of interest
  Future<List<Route>> findWithPointsOfInterest() async {
    return await collection.filter()
        .pointsOfInterest.isNotEmpty()
        .findAll();
  }
}

/// Repository for UserRoute entities
class IsarUserRouteRepository extends BaseRepository<UserRoute> {
  IsarUserRouteRepository(Isar isar) : super(isar, isar.userRoutes);

  // Find user routes by date traveled
  Future<List<UserRoute>> findByDateTraveled(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    
    return await collection.filter()
        .dateTraveledBetween(startOfDay, endOfDay)
        .findAll();
  }

  // Find user routes by type
  Future<List<UserRoute>> findByType(RouteType type) async {
    return await collection.filter()
        .routeTypeEqualTo(type)
        .findAll();
  }

  // Find user routes by minimum distance
  Future<List<UserRoute>> findByMinDistance(double minDistance) async {
    return await collection.filter()
        .distanceGreaterThanOrEqualTo(minDistance)
        .findAll();
  }

  // Find user routes by maximum duration (in minutes)
  Future<List<UserRoute>> findByMaxDuration(int maxDurationMinutes) async {
    return await collection.filter()
        .durationMinutesLessThanOrEqualTo(maxDurationMinutes)
        .findAll();
  }

  // Find user routes with route points
  Future<List<UserRoute>> findWithRoutePoints() async {
    return await collection.filter()
        .userRoutePoints.isNotEmpty()
        .findAll();
  }
}

/// Repository for RoutePoint entities
class IsarRoutePointRepository extends BaseRepository<RoutePoint> {
  IsarRoutePointRepository(Isar isar) : super(isar, isar.routePoints);
  
  // Find route points by sequence range
  Future<List<RoutePoint>> findBySequenceRange(int start, int end) async {
    return await collection.filter()
        .sequenceNumberBetween(start, end)
        .findAll();
  }
}

/// Repository for UserRoutePoint entities
class IsarUserRoutePointRepository extends BaseRepository<UserRoutePoint> {
  IsarUserRoutePointRepository(Isar isar) : super(isar, isar.userRoutePoints);
  
  // Find user route points by sequence range
  Future<List<UserRoutePoint>> findBySequenceRange(int start, int end) async {
    return await collection.filter()
        .sequenceNumberBetween(start, end)
        .findAll();
  }
}

/// Repository for PointOfInterest entities
class IsarPointOfInterestRepository extends BaseRepository<PointOfInterest> {
  IsarPointOfInterestRepository(Isar isar) : super(isar, isar.pointOfInterests);
  
  // Find points of interest by name
  Future<List<PointOfInterest>> findByName(String name) async {
    return await collection.filter()
        .nameContains(name, caseSensitive: false)
        .findAll();
  }
  
  // Find points of interest by type
  Future<List<PointOfInterest>> findByType(WaypointType type) async {
    return await collection.filter()
        .waypointTypeEqualTo(type)
        .findAll();
  }
} 