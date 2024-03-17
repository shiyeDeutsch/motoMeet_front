// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart' as latLng;
// import 'package:vector_map_tiles/vector_map_tiles.dart';
// //  import 'package:vector_tile_renderer/vector_tile_renderer.dart' hide TileLayer;
//  import 'package:vector_tile_renderer/vector_tile_renderer.dart' as vtr;

// class Mapscreen extends StatefulWidget {
//   @override
//   State<Mapscreen> createState() => _MapscreenState();
// }

// class _MapscreenState extends State<Mapscreen> {final MapController _controller = MapController();
//   List<double> sliderValues = [0.0, 0.0, 0.0]; // Corresponds to X, Y, Z
//   Style? _style;
//   Future<Style> _readStyle() => StyleReader(
//           uri: 'mapbox://styles/mapbox/streets-v12?access_token=pk.eyJ1Ijoiam9zaGRldXRzY2giLCJhIjoiY2xpZWc0bHEyMDk1bDNrb2M0OHdpYnh3ZSJ9.UBR9J6gRFfkhMt24ubRi9g',
//           // ignore: undefined_identifier
//           apiKey: "pk.eyJ1Ijoiam9zaGRldXRzY2giLCJhIjoiY2xpZWc0bHEyMDk1bDNrb2M0OHdpYnh3ZSJ9.UBR9J6gRFfkhMt24ubRi9g",
//           logger: const vtr.Logger.console())
//       .read();
//  @override
//   void initState() {
//     super.initState();
//     _initStyle();
//   }
//   void _initStyle() async {
//     try {
//       _style = await _readStyle();
//     } catch (e, stack) {
//       // ignore: avoid_print
//       print(e);
//       // ignore: avoid_print
//       print(stack);
//    //   _error = e;
//     }
//     setState(() {});
//   }

//  @override
// Widget build(BuildContext context) {
//   return FlutterMap(
//     options: MapOptions(
//       center: latLng.LatLng(51.509364, -0.128928),
//       zoom: 9.2,
//     ),
//     children: [
//       TileLayer(
//         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//         userAgentPackageName: 'com.example.app',
//       ),

//     ],
//   );
// }

//   Widget slider(String label, int index) {
//     return Column(
//       children: [
//         Text(label),
//         Slider(
//           value: sliderValues[index],
//           min: -2.0,
//           max: 5.0,
//           divisions: 70,
//           label: sliderValues[index].toStringAsFixed(1),
//           onChanged: (newValue) {
//             setState(() {
//               sliderValues[index] =
//                   newValue; // Update the correct value in the array.
//             });
//           },
//         ),
//         Text('$label Value: ${sliderValues[index].toStringAsFixed(1)}'),
//       ],
//     );
//   }

//   Matrix4 _perspectiveMatrix() {
//     // Set up the perspective matrix
//     final Matrix4 matrix = Matrix4.identity();
//     final double depth = 0.003; // Adjust the depth for more or less perspective
//     matrix.setEntry(3, 2, depth);
//     matrix.rotateX(sliderValues[0]);
//     matrix.rotateY(sliderValues[1]);
//     matrix.rotateZ(sliderValues[2]);

//     return matrix;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import '../services/MapMarkerService.dart';
import '../services/loctionService.dart';
import '../stateProvider.dart';
import '../widgets/bottomNavigation.dart';
import '../widgets/mapButtons.dart';

class MapMarkerScreen extends ConsumerStatefulWidget {
  @override
  _MapMarkerScreenState createState() => _MapMarkerScreenState();
}

class _MapMarkerScreenState extends ConsumerState<MapMarkerScreen>
    with TickerProviderStateMixin {
  MapController mapController = MapController();
  late final _animatedMapController =
      AnimatedMapController(vsync: this, mapController: mapController);
  double rotation = 0;
  bool _useTransformer = true;
  static const _useTransformerId = 'useTransformerId';

  @override
  void initState() {
    super.initState();

    // Delay the marker fetching slightly to avoid issues with context and ref not being fully ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mapMarkerService = GetIt.I<MapMarkerService>();
      mapMarkerService.getMarkers(ref);
      setState(() {});
    });

    // Geolocator.getPositionStream().listen((Position position) {
    //   // rotation=rotation+20;
    //   setState(() {
    //     // Rotate the map based on the heading
    //     //  rotation = position.heading ;

    //     print(rotation);
    //     // Update the map center to the new position
    //     mapController.moveAndRotate(
    //         LatLng(position.latitude, position.longitude),
    //         mapController.zoom,
    //         rotation);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen<List<Marker>>(markerListProvider, (_, newMarkers) {
    //   if (newMarkers.isNotEmpty) {
    //     mapController.move(newMarkers[0].point, mapController.zoom);
    //   }
    // });
    final markers = ref.watch(markerListProvider);

    return Stack(fit : StackFit.expand,
      children: [
        FlutterMap(
          mapController: _animatedMapController.mapController,
          options: MapOptions(
              //center: markers.isNotEmpty ? markers[0].point : LatLng(0, 0),
              zoom: 13.0,
              rotation: rotation),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              markers: markers,
            ),
          ],
        ),
        MapButtons(
          onChangeMapType: () => {},
          onShowRouteDetails: () => {},
          onRecordNewRoute: () => {},
          onLiveTrackingShare: () => {},
          onPauseStopRecording: () => {},
          onAddWaypoints: () => {},
          onSearch: () => {},
          onZoomIn: _zoomIn,
          onZoomOut: _zoomOut,
          onCurrentLocation: _goToCurrentLocation,
          onRouteOptions: () => {},
          onBackToDiscover: () => {},
        ),
        Align(alignment : Alignment.bottomCenter,child: BottomNavigation(),)
      ],
    );
  }

  void _zoomIn() {
    _animatedMapController.animatedZoomIn(
      customId: _useTransformer ? _useTransformerId : null,
    );
  }

  void _zoomOut() {
    _animatedMapController.animatedZoomOut(
      customId: _useTransformer ? _useTransformerId : null,
    );
  }

  void _goToCurrentLocation() async {
    // Dummy location - replace with actual location data, e.g., from a GPS sensor
    LatLng? currentLocation = await LocationService.getCurrentLocation();
    if (currentLocation != null) {
      _animatedMapController.animateTo(
        dest: currentLocation,
        zoom: 13.5,
      );
    }
  }
}
