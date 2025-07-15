import 'package:isar/isar.dart';
import '../../models/enum.dart';
import '../../models/route.dart';
import 'isar_repository.dart';

/// Repository for Route entities
class IsarRouteRepository extends BaseRepository<Route> {
  IsarRouteRepository(Isar isar) : super(isar, isar.routes);

  // Find routes by name (partial match)
  Future<List<Route>> findByName(String name) async {
    final routes = await getAll();
    return routes.where((route) => 
      route.name.toLowerCase().contains(name.toLowerCase())).toList();
  }

  // Find routes by type
  Future<List<Route>> findByType(RouteType type) async {
    final routes = await getAll();
    return routes.where((route) => route.routeType == type).toList();
  }

  // Find routes by country
  Future<List<Route>> findByCountry(String country) async {
    final routes = await getAll();
    return routes.where((route) => route.country == country).toList();
  }

  // Find routes by region
  Future<List<Route>> findByRegion(String region) async {
    final routes = await getAll();
    return routes.where((route) => route.region == region).toList();
  }

  // Find routes with rating greater than or equal to a value
  Future<List<Route>> findByMinRating(double minRating) async {
    final routes = await getAll();
    return routes.where((route) => 
      route.rating != null && route.rating! >= minRating).toList();
  }

  // Find routes that are loops
  Future<List<Route>> findLoops() async {
    final routes = await getAll();
    return routes.where((route) => 
      route.isLoop != null && route.isLoop!).toList();
  }

  // Find routes with points of interest
  Future<List<Route>> findWithPointsOfInterest() async {
    final routes = await getAll();
    return routes.where((route) => 
      route.pointsOfInterest.isNotEmpty).toList();
  }
}

/// Repository for UserRoute entities
class IsarUserRouteRepository extends BaseRepository<UserRoute> {
  IsarUserRouteRepository(Isar isar) : super(isar, isar.userRoutes);

  // Find user routes by date traveled
  Future<List<UserRoute>> findByDateTraveled(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    
    final userRoutes = await getAll();
    return userRoutes.where((userRoute) => 
      userRoute.dateTraveled != null && 
      userRoute.dateTraveled!.isAfter(startOfDay) && 
      userRoute.dateTraveled!.isBefore(endOfDay)).toList();
  }

  // Find user routes by type
  Future<List<UserRoute>> findByType(RouteType type) async {
    final userRoutes = await getAll();
    return userRoutes.where((userRoute) => 
      userRoute.routeType == type).toList();
  }

  // Find user routes by minimum distance
  Future<List<UserRoute>> findByMinDistance(double minDistance) async {
    final userRoutes = await getAll();
    return userRoutes.where((userRoute) => 
      userRoute.distance != null && 
      userRoute.distance! >= minDistance).toList();
  }

  // Find user routes by maximum duration (in minutes)
  Future<List<UserRoute>> findByMaxDuration(int maxDurationMinutes) async {
    final userRoutes = await getAll();
    return userRoutes.where((userRoute) => 
      userRoute.durationMinutes != null && 
      userRoute.durationMinutes! <= maxDurationMinutes).toList();
  }

  // Find user routes with route points
  Future<List<UserRoute>> findWithRoutePoints() async {
    final userRoutes = await getAll();
    return userRoutes.where((userRoute) => 
      userRoute.routePoints.isNotEmpty).toList();
  }
}

/// Repository for RoutePoint entities
class IsarRoutePointRepository extends BaseRepository<RoutePoint> {
  IsarRoutePointRepository(Isar isar) : super(isar, isar.routePoints);
  
  // Find route points by sequence range
  Future<List<RoutePoint>> findBySequenceRange(int start, int end) async {
    final routePoints = await getAll();
    return routePoints.where((routePoint) => 
      routePoint.sequenceNumber != null && 
      routePoint.sequenceNumber! >= start && 
      routePoint.sequenceNumber! <= end).toList();
  }
}

/// Repository for UserRoutePoint entities
class IsarUserRoutePointRepository extends BaseRepository< RoutePoint> {
  IsarUserRoutePointRepository(Isar isar) : super(isar, isar.routePoints);
  
  // Find user route points by sequence range
  Future<List< RoutePoint>> findBySequenceRange(int start, int end) async {
    final userRoutePoints = await getAll();
    return userRoutePoints.where((userRoutePoint) => 
      userRoutePoint.sequenceNumber != null && 
      userRoutePoint.sequenceNumber! >= start && 
      userRoutePoint.sequenceNumber! <= end).toList();
  }
}

/// Repository for PointOfInterest entities
class IsarPointOfInterestRepository extends BaseRepository<PointOfInterest> {
  IsarPointOfInterestRepository(Isar isar) : super(isar, isar.pointOfInterests);
  
  // Find points of interest by name
  Future<List<PointOfInterest>> findByName(String name) async {
    final pointsOfInterest = await getAll();
    return pointsOfInterest.where((poi) => 
      poi.name != null && 
      poi.name!.toLowerCase().contains(name.toLowerCase())).toList();
  }
  
  // Find points of interest by type
  Future<List<PointOfInterest>> findByType(WaypointType type) async {
    final pointsOfInterest = await getAll();
    return pointsOfInterest.where((poi) => 
      poi.waypointType == type).toList();
  }
} 