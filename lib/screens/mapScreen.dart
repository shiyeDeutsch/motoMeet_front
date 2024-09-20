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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import '../main.dart';
import '../models/enum.dart';
import '../models/route.dart';
import '../models/route.dart';
import '../routing/routes.dart';
import '../services/MapMarkerService.dart';
import '../services/bottomSheetServices.dart';
import '../services/isar/reposetory_provider.dart';
import '../services/loctionService.dart';
import '../services/routeService.dart';
import '../stateProvider.dart';
import '../widgets/ExpandablePanel.dart';
import '../widgets/bottomNavigation.dart';
import '../widgets/dialogs/chooseRouteTypeDialog.dart';
import '../widgets/expandableFAB.dart';
import '../widgets/mapButtons.dart';
import '../widgets/selecetMapProvider.dart';
import '../widgets/dialogs/stopRoutedialog.dart';
import '../widgets/wayPointBottomSheet.dart';

class MapMarkerScreen extends ConsumerStatefulWidget {
  const MapMarkerScreen({super.key});

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
  List<LatLng> routePoints = <LatLng>[];
  LatLng? lastLocation;
  final routeService = GetIt.I<RouteService>();
  final isarService = GetIt.I<RepositoryProvider>().userInfoRepository;
  NewRoute? newRoute;
  List<Marker> markers = [];
  Marker? userLocationMarker;

  AnimationController? _animationController;
  Animation<double>? _animation;
  bool isExpanded = false;
  StreamSubscription<Position>? locationUpdatesSubscription;
  // for gps data purpose
  Position? currentPosition;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var location = await LocationService.getCurrentLocation();
      userLocationMarker = Marker(
        point: location ?? LatLng(0.0, 0.0),
        width: 80.0,
        height: 80.0,
        child: const Tooltip(
          message: 'Current location',
          child: Icon(Icons.location_on_rounded, color: Colors.red),
        ),
      );
      _animatedMapController.animateTo(dest: location, zoom: 13.5, rotation: 0);

      setState(() {});
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _animation = Tween(begin: 10.0, end: 14.0).animate(_animationController!);
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen<List<Marker>>(markerListProvider, (_, newMarkers) {
    //   if (newMarkers.isNotEmpty) {
    //     mapController.move(newMarkers[0].point, mapController.zoom);
    //   }
    // });

    newRoute = ref.watch(routeStateProvider);
    markers = ref.watch(markerListProvider);
    // print(_animatedMapController.mapController.zoom);
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      // fit: StackFit.expand,
      children: [
        FlutterMap(
          mapController: _animatedMapController.mapController,
          options: MapOptions(
              initialCenter:
                  markers.isNotEmpty ? markers[0].point : const LatLng(0, 0),
              initialZoom: 13.0,
              initialRotation: rotation),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: lastLocation == null
                      ? routePoints
                      : [...routePoints, lastLocation!],
                  strokeWidth: 8.0,
                  color: Colors.green,
                ),
              ],
            ),
            MarkerLayer(
              markers: userLocationMarker == null
                  ? markers
                  : [userLocationMarker!, ...markers],
            ),
          ],
        ),
        MapButtons(
          onChangeMapType: () => {},
          onShowRouteDetails: () => {},
          onRecordNewRoute: _startNewRoute,
          onLiveTrackingShare: () => {},
          onPauseStopRecording: () => {},
          onAddWaypoints: () => {},
          onSearch: () => {},
          onZoomIn: _zoomIn,
          onZoomOut: _zoomOut,
          onCurrentLocation: () => {_goToCurrentLocation(null)},
          onRouteOptions: () => {},
          onBackToDiscover: () => {},
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: BottomNavigation(),
        // ),

        (newRoute?.isActive ?? false) == false ? startNewRoute() : Container(),

        activeRouteDetails(context),
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

  void _goToCurrentLocation(double? zoom) async {
    // Dummy location - replace with actual location data, e.g., from a GPS sensor
    LatLng? currentLocation = await LocationService.getCurrentLocation();
    if (currentLocation != null) {
      _animatedMapController.animateTo(
          dest: currentLocation, zoom: zoom ?? 13.5, rotation: 0);
    }
  }

  void _startNewRoute() async {
    RouteTypeEnum? selectedRouteType = await showRouteTypeEnumDialog(context);
    if (selectedRouteType != null) {
      _goToCurrentLocation(19);
      LocationService.startListening();
      routeService.startNewRoute(selectedRouteType,
          GeoPoint.fromLatLng(userLocationMarker!.point, null));

      // Subscribe to the global location updates stream from LocationService
      locationUpdatesSubscription = LocationService.locationUpdates.listen(
        (Position newLocation) {
          currentPosition = newLocation;
          double distance = 0;
          if (routePoints.isNotEmpty) {
            distance = routeService.calculateDistanceInMeters(routePoints.last,
                LatLng(newLocation.latitude, newLocation.longitude));
          }
          if (routePoints.isEmpty || (distance > 1.5)) {
            setState(() {
              if (distance > routeService.distanceFactor ||
                  routePoints.isEmpty) {
                routePoints
                    .add(LatLng(newLocation.latitude, newLocation.longitude));
                lastLocation = null;
              } else {
                lastLocation =
                    LatLng(newLocation.latitude, newLocation.longitude);
              }
              userLocationMarker = Marker(
                point: LatLng(newLocation.latitude, newLocation.longitude),
                child: const Icon(Icons.location_pin, color: Colors.red),
              );
            });
            print("tate has been updated");
          }
        },
        onError: (error) {
          // Handle any errors that occur during listening
          print('Error listening to location updates: $error');
        },
      );
    }
  }

  Widget activeRouteDetails(BuildContext context) {
    return (newRoute?.isActive ?? false) == false
        ? Container()
        : Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
        //     WayPointBottomSheet(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: routeActionButtons(),
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            // blurRadius: 4,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onVerticalDragUpdate: (DragUpdateDetails details) {
                              if (details.primaryDelta! < 0 && !isExpanded) {
                                _toggleExpanded();
                              }
                              if (details.primaryDelta! > 0 && isExpanded) {
                                _toggleExpanded();
                              }
                            },
                            child: Container(
                              height: 4.0,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2),
                              ),
                              margin: EdgeInsets.only(bottom: 8),
                            ),
                          ),
                          _buildMainDetails(),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: isExpanded ? 110 : 0,
                            width: double.infinity,
                            curve: Curves.fastOutSlowIn,
                            child: SingleChildScrollView(
                              child: _buildExpandedDetails(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildMainDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDetailColumn(
            Icons.speed, 'Speed', '${currentPosition?.speed ?? 'non'} km/h'),
        _buildDetailColumn(Icons.terrain, 'Elevation',
            '${currentPosition?.altitude ?? 'non'} m'),
        _buildDetailColumn(Icons.timer, 'Duration',
            '${(newRoute!.routeDuration?.inHours ?? 0) > 0 ? "${newRoute!.routeDuration?.inHours}h," : ""}${(newRoute!.routeDuration?.inMinutes ?? 0 % 60).toString().padLeft(2, '0')}m'),
        _buildDetailColumn(Icons.alt_route, 'Distance',
            '${((newRoute!.length ?? 0) / 1000).toStringAsFixed(3)} km'),
      ],
    );
  }

  Widget _buildDetailColumn(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey[700]),
        SizedBox(height: 4),
        Text(title, style: TextStyle(color: Colors.grey[700])),
        Text(value, style: TextStyle(color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildExpandedDetails() {
    return Column(
      children: [
        // Row(
        //   children: [
        //     Flexible(
        //       child: ListTile(
        //         leading: const Icon(Icons.speed),
        //         title: Text('Speed'),
        //         subtitle: Text('${currentPosition?.speed ?? 'non'} km/h'),
        //         dense: true,
        //       ),
        //     ),
        //     Flexible(
        //       child: ListTile(
        //         leading: const Icon(Icons.terrain),
        //         title: const Text('Elevation'),
        //         subtitle: Text('${currentPosition?.altitude ?? 'non'} m'),
        //         dense: true,
        //       ),
        //     ),
        //   ],
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () async {
                bool? stop = await showStopDialog(context);
                if (stop ?? false) {
                  Navigator.of(context).pushNamed(
                    Routes.saveRoute,
                    arguments: {
                      'newRoute': newRoute,
                    },
                  );
                  // locationUpdatesSubscription?.cancel();
                }
              },
              icon: Icon(Icons.pause),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
            ),
            IconButton(
              onPressed: () {
                // Handle add waypoint
              },
              icon: Icon(Icons.add_location),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onChangeMapType() {}
  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  Widget startNewRoute() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: _startNewRoute,
              child: Text("start new route")),
        ));
  }

  Widget routeActionButtons() {
    return SizedBox(
      height: 50,
      child: ExpandablePanel(
        isOpen: true,
        alignment: Alignment.topRight,
        buttons: <Widget>[
          IconButton(
            icon: Icon(Icons.add_location, color: Colors.black),
            onPressed: () {
              BottomSheetService.showLargeBottomSheet(
                  context: context, content: WayPointBottomSheet( ));
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.pause, color: Colors.black),
            onPressed: () async {
              bool? stop = await showStopDialog(context);
              if (stop ?? false) {
                Navigator.of(context).pushNamed(
                  Routes.saveRoute,
                  arguments: {
                    'newRoute': newRoute,
                  },
                );
                // locationUpdatesSubscription?.cancel();
              }
            },
          ),
        ],
      ),
    );
    // return ExpandableFab(
    //   distance: 100,
    //   children: [
    //     IconButton(
    //       onPressed: () async {
    //         bool? stop = await showStopDialog(context);
    //         if (stop ?? false) {
    //           Navigator.of(context).pushNamed(
    //             Routes.saveRoute,
    //             arguments: {
    //               'newRoute': newRoute,
    //             },
    //           );
    //           // locationUpdatesSubscription?.cancel();
    //         }
    //       },
    //       icon: Icon(Icons.pause),
    //       style: ElevatedButton.styleFrom(
    //         shape: StadiumBorder(),
    //       ),
    //     ),
    //     IconButton(
    //       onPressed: () {},
    //       icon: Icon(Icons.share),
    //       style: ElevatedButton.styleFrom(
    //         shape: StadiumBorder(),
    //       ),
    //     ),
    //     IconButton(
    //       onPressed: () {
    //         // Handle add waypoint
    //       },
    //       icon: Icon(Icons.add_location),
    //       style: ElevatedButton.styleFrom(
    //         shape: StadiumBorder(),
    //       ),
    //     ),
    //   ],
    // );
  }
}
