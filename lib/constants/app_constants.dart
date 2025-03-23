// App-wide constants

// Mapbox configuration
class MapboxConfig {
  static const String ACCESS_TOKEN = 'pk.eyJ1Ijoiam9zaGRldXRzY2giLCJhIjoiY204Ymt4bDFhMWh1aTJsczVzNDNlcTRpbSJ9.dzh1waA8zdT90jwmyOzpiQ';
  static const String STYLE_OUTDOORS = 'mapbox://styles/mapbox/outdoors-v12';
  static const String STYLE_SATELLITE = 'mapbox://styles/mapbox/satellite-streets-v12';
  static const String STYLE_STANDARD = 'mapbox://styles/mapbox/streets-v12';
  static const String STYLE_NAVIGATION = 'mapbox://styles/mapbox/navigation-day-v1';
}

// Speed thresholds for zoom levels (in meters per second)
class SpeedThresholds {
  static const double STATIONARY = 0.0;
  static const double WALKING = 2.8;
  static const double RUNNING = 8.3;
  static const double BIKING = 13.9;
  static const double SLOW_DRIVING = 19.4;
  static const double MEDIUM_DRIVING = 27.8;
  static const double FAST_DRIVING = 33.3;
}

// Map UI configuration
class MapConfig {
  // Default camera settings
  static const double DEFAULT_ZOOM = 15.0;
  static const double DEFAULT_TILT = 0.0;
  static const double NAVIGATION_TILT = 45.0;
  
  // Route path styling
  static const String ROUTE_COLOR = "#3E6C51";
  static const double ROUTE_WIDTH = 5.0;
  static const double ROUTE_OPACITY = 0.8;
  
  // Traveled path styling
  static const String TRAVELED_PATH_COLOR = "#FF4500";
  static const double TRAVELED_PATH_WIDTH = 4.0;
  static const double TRAVELED_PATH_OPACITY = 1.0;
  
  // Distance thresholds for adding new points (in meters)
  static const double HIKING_THRESHOLD = 5.0;
  static const double BIKING_THRESHOLD = 10.0;
  static const double MOTORCYCLE_THRESHOLD = 20.0;
  static const double JEEP_THRESHOLD = 30.0;
} 