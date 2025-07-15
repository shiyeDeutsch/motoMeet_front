import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:rxdart/rxdart.dart';

class LocationService {
  // Use BehaviorSubject to broadcast location updates and retain the last value
  static final BehaviorSubject<Position> _locationUpdatesController =
      BehaviorSubject<Position>();

  // Public stream to listen for location updates
  static Stream<Position> get locationUpdates =>
      _locationUpdatesController.stream;

  // Subscription for the location updates stream
  static StreamSubscription<Position>? _positionSubscription;
  static bool _isListening = false;

  /// Starts listening to location updates
  static Future<void> startListening() async {
    if (_isListening) {
      return;
    }
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

      // Configure location settings for more frequent updates
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 2, // Update every 2 meters (instead of default 5)
      //  timeLimit: Duration(seconds: 1), // Ensure we get updates at least once per second
      );

      // Start listening to location updates with the custom settings
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: locationSettings
      ).listen(
        (position) {
          _locationUpdatesController.add(position);
        },
        onError: (error) {
          _locationUpdatesController.addError(error);
        },
      );
      _isListening = true;
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
      _locationUpdatesController.add(position);
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Disposes of resources used by the service
  static void dispose() {
    _positionSubscription?.cancel();
    _locationUpdatesController.close();
    _isListening = false;
  }

  static Position? getLastKnownPosition() {
    return _locationUpdatesController.valueOrNull;
  }

  static Future<Position?> getCurrentPosition() async {
    try {
      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
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

      // Retrieve the current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _locationUpdatesController.add(position);
      return position;
    } catch (e) {
      print('Error retrieving current position: $e');
      return null;
    }
  }
}