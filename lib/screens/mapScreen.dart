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
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latLng;
import '../models/mapMarker.dart';
import '../services/MapMarkerService.dart';
import '../utilities/appIcons.dart';

class MyMapWidget extends StatelessWidget {
//  final LocationService locationService;
  final markerService = GetIt.I<MapMarkerService>();
  MyMapWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // When we have the location, use it as the center for the map.
        FlutterMap(
      options: MapOptions(  
        center: markerService.markers.length > 1
            ? markerService.markers[0].point
            : null,
        zoom: 14.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers: markerService.markers),
      ],
    );
  }
}
