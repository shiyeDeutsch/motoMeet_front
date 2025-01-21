class DistanceFormatter {
  /// Formats a distance in meters according to dynamic rounding rules:
  /// - Below 100 meters: update every 5 (e.g., 5 m, 10 m, 15 m).
  /// - 100 to 999 meters: update every 10 (e.g., 100 m, 110 m, 120 m).
  /// - Above 1000 meters: update every 100 (e.g., 1.0 km, 1.1 km).
  static String formatDistance(double? meters) {
    if (meters == null || meters <= 0) {
      return "0 m";
    }

    if (meters < 100) {
      // Round to the nearest 5 meters
      final rounded = (meters / 5).round() * 5;
      return "$rounded m";
    } else if (meters < 1000) {
      // Round to the nearest 10 meters
      final rounded = (meters / 10).round() * 10;
      return "$rounded m";
    } else {
      // Convert to kilometers and round to one decimal place
      final kilometers = meters / 1000;
      return "${kilometers.toStringAsFixed(1)} km";
    }
  }
}
