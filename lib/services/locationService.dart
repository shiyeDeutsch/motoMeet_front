import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  // StreamController to broadcast location updates
  static final StreamController<Position> _locationUpdatesController =
      StreamController<Position>.broadcast();

  // Public stream to listen for location updates
  static Stream<Position> get locationUpdates =>
      _locationUpdatesController.stream;

  // Subscription for the location updates stream
  static StreamSubscription<Position>? _positionSubscription;

  /// Starts listening to location updates
  static Future<void> startListening() async {
    try {
      // Ensure location services are enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw Exception('Location services are disabled.');
      }

      // Check and request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      // Start listening to location updates
      _positionSubscription = Geolocator.getPositionStream().listen(
        (position) {
          print("Speed: ${position.speed} m/s");
          _locationUpdatesController.add(position);
        },
        onError: (error) {
          _locationUpdatesController.addError(error);
        },
      );
    } catch (e) {
      print("Error starting location updates: $e");
      _locationUpdatesController.addError(e);
    }
  }

  /// Retrieves the current location of the user
  static Future<LatLng?> getCurrentLocation() async {
    try {
      // Ensure location services are enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw Exception('Location services are disabled.');
      }

      // Check and request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      // Fetch the current position
      Position position = await Geolocator.getCurrentPosition();
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Disposes of resources used by the service
  static void dispose() {
    _positionSubscription?.cancel();
    _locationUpdatesController.close();
  }
}
