import 'package:motomeetfront/models/enum.dart';
import 'package:motomeetfront/models/route.dart';

/// Class containing sample routes for testing purposes
class SampleRoutes {
  /// Get list of 5 sample routes
  static Future<List<Route> >getSampleRoutes() async{
    return [
      _alpineAdventureRoute(),
      _coastalCruiseRoute(),
      _mountainPassRoute(),
      _desertTrailRoute(),
      _forestExpeditionRoute(),
    ];
  }

  /// Alpine Adventure - A challenging motorcycle route through mountain passes
  static Route _alpineAdventureRoute() {
    final route = Route(
      id: 1,
      name: 'Alpine Adventure',
      description: 'A thrilling ride through scenic mountain passes with breathtaking views of alpine lakes and meadows. Perfect for experienced riders looking for a challenge.',
      startPoint: GeoPoint(latitude: 46.5197, longitude: 13.6396, altitude: 1200),
      endPoint: GeoPoint(latitude: 47.0121, longitude: 13.8569, altitude: 950),
      routeType: RouteType.motorcycle,
      difficultyLevel: DifficultyLevel(level: 'Advanced', description: 'Technical curves and elevation changes'),
      length: 175.5,
      durationMinutes: 240,
      elevationGain: 2450,
      rating: 4.8,
      isLoop: false,
      country: 'Austria',
      region: 'Carinthia Alps',
      imageUrl: 'https://images.unsplash.com/photo-1596123068611-c89d922a0f0a',
      startDate: DateTime(2023, 6, 15),
      endDate: DateTime(2023, 6, 15),
    );
    
    // Add route points
    final routePoints = [
      RoutePoint(id: 101, sequenceNumber: 1, point: GeoPoint(latitude: 46.5197, longitude: 13.6396, altitude: 1200)),
      RoutePoint(id: 102, sequenceNumber: 2, point: GeoPoint(latitude: 46.6103, longitude: 13.6612, altitude: 1350)),
      RoutePoint(id: 103, sequenceNumber: 3, point: GeoPoint(latitude: 46.7225, longitude: 13.7125, altitude: 1650)),
      RoutePoint(id: 104, sequenceNumber: 4, point: GeoPoint(latitude: 46.8392, longitude: 13.7856, altitude: 1420)),
      RoutePoint(id: 105, sequenceNumber: 5, point: GeoPoint(latitude: 46.9158, longitude: 13.8129, altitude: 1200)),
      RoutePoint(id: 106, sequenceNumber: 6, point: GeoPoint(latitude: 47.0121, longitude: 13.8569, altitude: 950)),
    ];
    
    // Add points of interest
    final pointsOfInterest = [
      PointOfInterest(
        id: 201, 
        location: GeoPoint(latitude: 46.6103, longitude: 13.6612, altitude: 1350),
        name: 'Alpine View Restaurant',
        description: 'Perfect stop for refreshments with panoramic mountain views',
        waypointType: WaypointType.VisitorCenter,
        imageUrl: 'https://images.unsplash.com/photo-1539183204366-63a0589187ab'
      ),
      PointOfInterest(
        id: 202, 
        location: GeoPoint(latitude: 46.8392, longitude: 13.7856, altitude: 1420),
        name: 'Crystal Lake',
        description: 'Beautiful alpine lake with crystal clear waters',
        waypointType: WaypointType.Lake,
        imageUrl: 'https://images.unsplash.com/photo-1511516412963-801b050c92aa'
      ),
      PointOfInterest(
        id: 203, 
        location: GeoPoint(latitude: 46.9158, longitude: 13.8129, altitude: 1200),
        name: 'Mountain Pass Lookout',
        description: 'Breathtaking viewpoint overlooking the valley',
        waypointType: WaypointType.Viewpoint,
        imageUrl: 'https://images.unsplash.com/photo-1486870591958-9b9d0d1dda99'
      ),
    ];
    
    // Add reviews
    final reviews = [
      Review(
        id: 301,
        username: 'AlpineRider',
        rating: 5.0,
        comment: 'One of the most beautiful routes I\'ve ever ridden! The views are spectacular and the road conditions are perfect.',
        date: DateTime(2023, 6, 20)
      ),
      Review(
        id: 302,
        username: 'MotoExplorer',
        rating: 4.5,
        comment: 'Great route with amazing scenery. Some technical sections require experience but worth it.',
        date: DateTime(2023, 7, 5)
      ),
    ];
    
    // Add tags
    final tags = [
      Tag(id: 401, name: 'Scenic'),
      Tag(id: 402, name: 'Mountain'),
      Tag(id: 403, name: 'Technical'),
      Tag(id: 404, name: 'Alps'),
    ];
    
    // Assign collections to the route
    route.routePoints.addAll(routePoints);
    route.pointsOfInterest.addAll(pointsOfInterest);
    route.reviews.addAll(reviews);
    route.tags.addAll(tags);
    
    return route;
  }

  /// Coastal Cruise - A scenic motorcycle route along the coast
  static Route _coastalCruiseRoute() {
    final route = Route(
      id: 2,
      name: 'Coastal Cruise',
      description: 'A relaxing ride along the coastline featuring stunning ocean views, charming seaside villages, and plenty of stops for refreshment.',
      startPoint: GeoPoint(latitude: 43.7102, longitude: 10.4222, altitude: 5),
      endPoint: GeoPoint(latitude: 43.8429, longitude: 10.5059, altitude: 3),
      routeType: RouteType.motorcycle,
      difficultyLevel: DifficultyLevel(level: 'Beginner', description: 'Mostly straight roads with gentle curves'),
      length: 120.2,
      durationMinutes: 180,
      elevationGain: 350,
      rating: 4.5,
      isLoop: true,
      country: 'Italy',
      region: 'Tuscany',
      imageUrl: 'https://images.unsplash.com/photo-1622987437805-5c6f7c2609d7',
      startDate: DateTime(2023, 7, 10),
      endDate: DateTime(2023, 7, 10),
    );
    
    // Add route points (create a loop)
    final routePoints = [
      RoutePoint(id: 107, sequenceNumber: 1, point: GeoPoint(latitude: 43.7102, longitude: 10.4222, altitude: 5)),
      RoutePoint(id: 108, sequenceNumber: 2, point: GeoPoint(latitude: 43.7405, longitude: 10.4501, altitude: 10)),
      RoutePoint(id: 109, sequenceNumber: 3, point: GeoPoint(latitude: 43.7812, longitude: 10.4789, altitude: 8)),
      RoutePoint(id: 110, sequenceNumber: 4, point: GeoPoint(latitude: 43.8429, longitude: 10.5059, altitude: 3)),
      RoutePoint(id: 111, sequenceNumber: 5, point: GeoPoint(latitude: 43.8201, longitude: 10.4702, altitude: 15)),
      RoutePoint(id: 112, sequenceNumber: 6, point: GeoPoint(latitude: 43.7653, longitude: 10.4355, altitude: 12)),
      RoutePoint(id: 113, sequenceNumber: 7, point: GeoPoint(latitude: 43.7102, longitude: 10.4222, altitude: 5)),
    ];
    
    // Add points of interest
    final pointsOfInterest = [
      PointOfInterest(
        id: 204, 
        location: GeoPoint(latitude: 43.7405, longitude: 10.4501, altitude: 10),
        name: 'Seaside Café',
        description: 'Charming café with sea views and excellent espresso',
        waypointType: WaypointType.VisitorCenter,
        imageUrl: 'https://images.unsplash.com/photo-1559925393-8be0ec4767c8'
      ),
      PointOfInterest(
        id: 205, 
        location: GeoPoint(latitude: 43.8201, longitude: 10.4702, altitude: 15),
        name: 'Ancient Harbor',
        description: 'Historical harbor with traditional fishing boats and seafood restaurants',
        waypointType: WaypointType.HistoricalSite,
        imageUrl: 'https://images.unsplash.com/photo-1527824404775-dce343118ebc'
      ),
    ];
    
    // Add reviews
    final reviews = [
      Review(
        id: 303,
        username: 'CoastalRider',
        rating: 4.5,
        comment: 'Beautiful views throughout the entire route. Perfect for a relaxing day ride.',
        date: DateTime(2023, 7, 15)
      ),
      Review(
        id: 304,
        username: 'SunsetCruiser',
        rating: 4.0,
        comment: 'Lovely coastal views but can be busy during tourist season. Early morning is best.',
        date: DateTime(2023, 8, 3)
      ),
    ];
    
    // Add tags
    final tags = [
      Tag(id: 405, name: 'Coastal'),
      Tag(id: 406, name: 'Beginner'),
      Tag(id: 407, name: 'Scenic'),
      Tag(id: 408, name: 'Beach'),
    ];
    
    // Assign collections to the route
    route.routePoints.addAll(routePoints);
    route.pointsOfInterest.addAll(pointsOfInterest);
    route.reviews.addAll(reviews);
    route.tags.addAll(tags);
    
    return route;
  }

  /// Mountain Pass - A challenging jeep trail through mountain ranges
  static Route _mountainPassRoute() {
    final route = Route(
      id: 3,
      name: 'Rocky Mountain Pass',
      description: 'An off-road adventure through rugged mountain terrain, featuring river crossings, steep ascents, and panoramic ridge-top views.',
      startPoint: GeoPoint(latitude: 39.7392, longitude: -104.9903, altitude: 1609),
      endPoint: GeoPoint(latitude: 39.9783, longitude: -105.2755, altitude: 2195),
      routeType: RouteType.jeep,
      difficultyLevel: DifficultyLevel(level: 'Expert', description: 'Technical off-road with obstacles'),
      length: 85.3,
      durationMinutes: 300,
      elevationGain: 1800,
      rating: 4.9,
      isLoop: false,
      country: 'United States',
      region: 'Colorado',
      imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
      startDate: DateTime(2023, 8, 5),
      endDate: DateTime(2023, 8, 5),
    );
    
    // Add route points
    final routePoints = [
      RoutePoint(id: 114, sequenceNumber: 1, point: GeoPoint(latitude: 39.7392, longitude: -104.9903, altitude: 1609)),
      RoutePoint(id: 115, sequenceNumber: 2, point: GeoPoint(latitude: 39.7804, longitude: -105.0559, altitude: 1750)),
      RoutePoint(id: 116, sequenceNumber: 3, point: GeoPoint(latitude: 39.8255, longitude: -105.1124, altitude: 1920)),
      RoutePoint(id: 117, sequenceNumber: 4, point: GeoPoint(latitude: 39.8729, longitude: -105.1876, altitude: 2050)),
      RoutePoint(id: 118, sequenceNumber: 5, point: GeoPoint(latitude: 39.9231, longitude: -105.2315, altitude: 2150)),
      RoutePoint(id: 119, sequenceNumber: 6, point: GeoPoint(latitude: 39.9783, longitude: -105.2755, altitude: 2195)),
    ];
    
    // Add points of interest
    final pointsOfInterest = [
      PointOfInterest(
        id: 206, 
        location: GeoPoint(latitude: 39.8255, longitude: -105.1124, altitude: 1920),
        name: 'River Crossing',
        description: 'Technical river crossing requiring 4x4 and good ground clearance',
        waypointType: WaypointType.WildlifeSighting,
        imageUrl: 'https://images.unsplash.com/photo-1516822669470-7f8f1bdbbe4a'
      ),
      PointOfInterest(
        id: 207, 
        location: GeoPoint(latitude: 39.9231, longitude: -105.2315, altitude: 2150),
        name: 'Eagle\'s Nest Viewpoint',
        description: 'Panoramic view of the entire mountain range and valley below',
        waypointType: WaypointType.Viewpoint,
        imageUrl: 'https://images.unsplash.com/photo-1471978445661-ad6ec1f5ba50'
      ),
      PointOfInterest(
        id: 208, 
        location: GeoPoint(latitude: 39.8729, longitude: -105.1876, altitude: 2050),
        name: 'Rockfall Warning',
        description: 'Area prone to loose rocks - proceed with caution',
        waypointType: WaypointType.Rockfall,
        imageUrl: 'https://images.unsplash.com/photo-1503422051650-edd38c76d89d'
      ),
    ];
    
    // Add reviews
    final reviews = [
      Review(
        id: 305,
        username: 'OffRoadEnthusiast',
        rating: 5.0,
        comment: 'Incredible trail that tests your driving skills and rewards with amazing views. Not for beginners!',
        date: DateTime(2023, 8, 10)
      ),
      Review(
        id: 306,
        username: 'JeepExplorer',
        rating: 4.8,
        comment: 'One of the best off-road experiences in Colorado. Challenging but doable with proper equipment.',
        date: DateTime(2023, 9, 2)
      ),
      Review(
        id: 307,
        username: 'MountainDriver',
        rating: 5.0,
        comment: 'Worth every minute! The river crossing was tricky but the views at Eagle\'s Nest are unbeatable.',
        date: DateTime(2023, 8, 15)
      ),
    ];
    
    // Add tags
    final tags = [
      Tag(id: 409, name: 'OffRoad'),
      Tag(id: 410, name: 'Technical'),
      Tag(id: 411, name: 'Mountain'),
      Tag(id: 412, name: '4x4Required'),
      Tag(id: 413, name: 'RiverCrossing'),
    ];
    
    // Assign collections to the route
    route.routePoints.addAll(routePoints);
    route.pointsOfInterest.addAll(pointsOfInterest);
    route.reviews.addAll(reviews);
    route.tags.addAll(tags);
    
    return route;
  }

  /// Desert Trail - A moderate biking route through desert landscapes
  static Route _desertTrailRoute() {
    final route = Route(
      id: 4,
      name: 'Desert Discovery',
      description: 'A scenic biking route through unique desert landscapes featuring red rock formations, cactus gardens, and spectacular sunset views.',
      startPoint: GeoPoint(latitude: 33.5722, longitude: -112.0901, altitude: 340),
      endPoint: GeoPoint(latitude: 33.4484, longitude: -111.9431, altitude: 410),
      routeType: RouteType.biking,
      difficultyLevel: DifficultyLevel(level: 'Intermediate', description: 'Some technical sections but mostly smooth trail'),
      length: 42.5,
      durationMinutes: 150,
      elevationGain: 520,
      rating: 4.3,
      isLoop: true,
      country: 'United States',
      region: 'Arizona',
      imageUrl: 'https://images.unsplash.com/photo-1542662565-7e4b66bae529',
      startDate: DateTime(2023, 9, 20),
      endDate: DateTime(2023, 9, 20),
    );
    
    // Add route points (making a loop)
    final routePoints = [
      RoutePoint(id: 120, sequenceNumber: 1, point: GeoPoint(latitude: 33.5722, longitude: -112.0901, altitude: 340)),
      RoutePoint(id: 121, sequenceNumber: 2, point: GeoPoint(latitude: 33.5423, longitude: -112.0456, altitude: 375)),
      RoutePoint(id: 122, sequenceNumber: 3, point: GeoPoint(latitude: 33.5102, longitude: -112.0123, altitude: 390)),
      RoutePoint(id: 123, sequenceNumber: 4, point: GeoPoint(latitude: 33.4784, longitude: -111.9743, altitude: 425)),
      RoutePoint(id: 124, sequenceNumber: 5, point: GeoPoint(latitude: 33.4484, longitude: -111.9431, altitude: 410)),
      RoutePoint(id: 125, sequenceNumber: 6, point: GeoPoint(latitude: 33.4891, longitude: -111.9825, altitude: 380)),
      RoutePoint(id: 126, sequenceNumber: 7, point: GeoPoint(latitude: 33.5267, longitude: -112.0401, altitude: 350)),
      RoutePoint(id: 127, sequenceNumber: 8, point: GeoPoint(latitude: 33.5722, longitude: -112.0901, altitude: 340)),
    ];
    
    // Add points of interest
    final pointsOfInterest = [
      PointOfInterest(
        id: 209, 
        location: GeoPoint(latitude: 33.5102, longitude: -112.0123, altitude: 390),
        name: 'Red Rock Formation',
        description: 'Stunning natural rock formation with unique color patterns',
        waypointType: WaypointType.Viewpoint,
        imageUrl: 'https://images.unsplash.com/photo-1515789259361-de3c1dd3abf3'
      ),
      PointOfInterest(
        id: 210, 
        location: GeoPoint(latitude: 33.4784, longitude: -111.9743, altitude: 425),
        name: 'Cactus Garden',
        description: 'Dense collection of various native cactus species',
        waypointType: WaypointType.MountainPeak,
        imageUrl: 'https://images.unsplash.com/photo-1549986860-c73512281d46'
      ),
      PointOfInterest(
        id: 211, 
        location: GeoPoint(latitude: 33.4891, longitude: -111.9825, altitude: 380),
        name: 'Desert Oasis',
        description: 'Small water source with shade and resting area',
        waypointType: WaypointType.WaterSpring,
        imageUrl: 'https://images.unsplash.com/photo-1545579133-99bb5ab189bd'
      ),
    ];
    
    // Add reviews
    final reviews = [
      Review(
        id: 308,
        username: 'DesertBiker',
        rating: 4.5,
        comment: 'Beautiful trail with amazing scenery. Bring plenty of water as it gets hot!',
        date: DateTime(2023, 9, 25)
      ),
      Review(
        id: 309,
        username: 'ArizonaRider',
        rating: 4.0,
        comment: 'Great intermediate trail. Some sandy sections are challenging but overall very enjoyable.',
        date: DateTime(2023, 10, 5)
      ),
    ];
    
    // Add tags
    final tags = [
      Tag(id: 414, name: 'Desert'),
      Tag(id: 415, name: 'Biking'),
      Tag(id: 416, name: 'ScenicViews'),
      Tag(id: 417, name: 'Intermediate'),
    ];
    
    // Assign collections to the route
    route.routePoints.addAll(routePoints);
    route.pointsOfInterest.addAll(pointsOfInterest);
    route.reviews.addAll(reviews);
    route.tags.addAll(tags);
    
    return route;
  }

  /// Forest Expedition - A hiking route through dense forests
  static Route _forestExpeditionRoute() {
    final route = Route(
      id: 5,
      name: 'Forest Expedition',
      description: 'A tranquil hiking path through ancient forests with streams, waterfalls, and abundant wildlife. Perfect for nature photography and peaceful reflection.',
      startPoint: GeoPoint(latitude: 48.9567, longitude: 13.4358, altitude: 850),
      endPoint: GeoPoint(latitude: 49.0124, longitude: 13.3079, altitude: 1200),
      routeType: RouteType.hiking,
      difficultyLevel: DifficultyLevel(level: 'Moderate', description: 'Some steep sections but well-marked trails'),
      length: 18.2,
      durationMinutes: 210,
      elevationGain: 620,
      rating: 4.6,
      isLoop: false,
      country: 'Germany',
      region: 'Bavarian Forest',
      imageUrl: 'https://images.unsplash.com/photo-1520962880247-cfaf541c8724',
      startDate: DateTime(2023, 5, 12),
      endDate: DateTime(2023, 5, 12),
    );
    
    // Add route points
    final routePoints = [
      RoutePoint(id: 128, sequenceNumber: 1, point: GeoPoint(latitude: 48.9567, longitude: 13.4358, altitude: 850)),
      RoutePoint(id: 129, sequenceNumber: 2, point: GeoPoint(latitude: 48.9678, longitude: 13.4201, altitude: 910)),
      RoutePoint(id: 130, sequenceNumber: 3, point: GeoPoint(latitude: 48.9789, longitude: 13.4015, altitude: 980)),
      RoutePoint(id: 131, sequenceNumber: 4, point: GeoPoint(latitude: 48.9912, longitude: 13.3782, altitude: 1050)),
      RoutePoint(id: 132, sequenceNumber: 5, point: GeoPoint(latitude: 49.0034, longitude: 13.3421, altitude: 1120)),
      RoutePoint(id: 133, sequenceNumber: 6, point: GeoPoint(latitude: 49.0124, longitude: 13.3079, altitude: 1200)),
    ];
    
    // Add points of interest
    final pointsOfInterest = [
      PointOfInterest(
        id: 212, 
        location: GeoPoint(latitude: 48.9678, longitude: 13.4201, altitude: 910),
        name: 'Ancient Oak',
        description: 'Estimated to be over 500 years old, this oak is the largest in the region',
        waypointType: WaypointType.Forest,
        imageUrl: 'https://images.unsplash.com/photo-1542273917363-3b1817f69a2d'
      ),
      PointOfInterest(
        id: 213, 
        location: GeoPoint(latitude: 48.9912, longitude: 13.3782, altitude: 1050),
        name: 'Hidden Waterfall',
        description: 'Beautiful 15-meter waterfall with natural swimming pool',
        waypointType: WaypointType.Waterfall,
        imageUrl: 'https://images.unsplash.com/photo-1546587348-d12660c30c50'
      ),
      PointOfInterest(
        id: 214, 
        location: GeoPoint(latitude: 49.0034, longitude: 13.3421, altitude: 1120),
        name: 'Wildlife Viewing Platform',
        description: 'Excellent spot for viewing deer, foxes, and various bird species',
        waypointType: WaypointType.Viewpoint,
        imageUrl: 'https://images.unsplash.com/photo-1444464666168-49d633b86797'
      ),
      PointOfInterest(
        id: 215, 
        location: GeoPoint(latitude: 48.9789, longitude: 13.4015, altitude: 980),
        name: 'Slippery Path Warning',
        description: 'Trail can become very slippery after rain - use caution',
        waypointType: WaypointType.SlipperyPath,
        imageUrl: 'https://images.unsplash.com/photo-1465189684280-6a8fa9b19a7a'
      ),
    ];
    
    // Add reviews
    final reviews = [
      Review(
        id: 310,
        username: 'ForestHiker',
        rating: 5.0,
        comment: 'Absolutely magical hike through pristine forest. Saw deer and countless birds. The waterfall is a must-see!',
        date: DateTime(2023, 5, 18)
      ),
      Review(
        id: 311,
        username: 'NaturePhotographer',
        rating: 4.7,
        comment: 'Perfect for photography enthusiasts. The morning light filtering through the trees is spectacular.',
        date: DateTime(2023, 6, 3)
      ),
      Review(
        id: 312,
        username: 'BavarianTrekker',
        rating: 4.2,
        comment: 'Beautiful hike but some sections were quite steep. Take good hiking boots and poles if needed.',
        date: DateTime(2023, 7, 12)
      ),
    ];
    
    // Add tags
    final tags = [
      Tag(id: 418, name: 'Forest'),
      Tag(id: 419, name: 'Hiking'),
      Tag(id: 420, name: 'Nature'),
      Tag(id: 421, name: 'Wildlife'),
      Tag(id: 422, name: 'Photography'),
      Tag(id: 423, name: 'Waterfall'),
    ];
    
    // Assign collections to the route
    route.routePoints.addAll(routePoints);
    route.pointsOfInterest.addAll(pointsOfInterest);
    route.reviews.addAll(reviews);
    route.tags.addAll(tags);
    
    return route;
  }
}