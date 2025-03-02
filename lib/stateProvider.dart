// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get_it/get_it.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:motomeetfront/services/routeService.dart';

// import 'models/enum.dart';
// import 'models/route.dart';

// final markerListProvider =
//     StateNotifierProvider<MarkerListState, List<Marker>>((ref) {
//   return MarkerListState();
// });

// class MarkerListState extends StateNotifier<List<Marker>> {
//   MarkerListState() : super([]);

//   List<Marker> getState() {
//     return state;
//   }

//   void addMarker(Marker marker) {
//     state = [...state, marker];
//     print("marker added");
//   }

//   void removeMarker(Marker marker) {
//     state = state.where((m) => m != marker).toList();
//   }

//   void clearMarkers() {
//     state = [];
//   }
// }

// final routeStateProvider = StateNotifierProvider<RouteState, NewRoute?>((ref) {
//   return RouteState();
// });

// class RouteState extends StateNotifier<NewRoute?> {
//   RouteState() : super(null);
//   var routeService = GetIt.I<RouteService>();

//   NewRoute? saveRoute(String name, String? description,List<TagEnum>? tags) {
//     state = state!.copyWith(
//       routeTags: tags,
//       name: name,
//       description: description,
//      // isActive: false,
//       isComplited: true,
//     );
//     return state;
//   }

//   // void startNewRoute(GeoPoint startPoint, RouteTypeEnum routeType) {
//   //   final newRoute = NewRoute(
//   //     isarId: null,
//   //     startDate: DateTime.now().toUtc(),
//   //     endDate: null,
//   //     name: '',
//   //     description: '',
//   //     startPoint: startPoint,
//   //     endPoint: null,
//   //     routeType: RouteType(type: routeType),
//   //     length:
//   //         null, // Initial length is 0, will be updated as new points are added
//   //     durationMinutes: 0, // Starts with zero duration
//   //     //   difficultyLevel: DifficultyLevel (), // Initialize with a default value, or modify as needed
//   //     routePoints: [], // Starts with an empty list of route points
//   //     routeTags: [], // Starts with an empty list of tags, modify as needed
//   //     isActive: true, // A new route starts as active
//   //     isComplited: false, // Since it's a new route, it's not completed
//   //    pointOfInterest: null,
//   //   );

//   //   state = newRoute; // Update the state with the new route
//   // }

//   NewRoute addRoutePoints(
//       List<GeoPoint> newPoints, Duration routeDuration, double pathLength) {
//     final updatedPoints = List<GeoPoint>.from(state?.routePoints ?? [])
//       ..addAll(newPoints);

//     state = state!.copyWith(
//       routePoints: updatedPoints,
//       duration: routeDuration,
//       length: pathLength,
//       endPoint: updatedPoints.last,
//       endDate: DateTime.now().toUtc(),
//     );
//     return state!;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
