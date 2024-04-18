import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  static final StreamController<Position> _locationUpdatesController =
      StreamController<Position>.broadcast();
  static Stream<Position> get locationUpdates =>
      _locationUpdatesController.stream;
  static StreamSubscription<Position>? _positionSubscription;
  // Start listening to location updates
  static void startListening() {
    _positionSubscription = Geolocator.getPositionStream(
            // locationSettings:const LocationSettings(
            //   accuracy: LocationAccuracy.bestForNavigation,
            //    distanceFilter:  1, // Set to 0 to ignore distance changes, focus on time.

            // //  timeLimit: Duration(seconds:1 ), // Receive updates every 5 seconds.
            // ),
            )
        .listen(
      (position) {
        print("Speed: ${position.speed} m/s");
        _locationUpdatesController.add(position);
      },
      onError: (e) {
        _locationUpdatesController.addError(e);
      },
    );
  }

  // Method to get the current location of the user
  static Future<LatLng?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  static void dispose() {
    _locationUpdatesController.close();
    _positionSubscription?.cancel();
    // _positionSubscription = null;
  }
}
