import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:motomeetfront/services/routeService.dart';

import 'models/route.dart';



final markerListProvider =
    StateNotifierProvider<MarkerList, List<Marker>>((ref) {
  return MarkerList();
});

 
class MarkerList extends StateNotifier<List<Marker>> {
  MarkerList() : super([]);

  void addMarker(Marker marker) {
    state = [...state, marker];
  }

  void removeMarker(Marker marker) {
    state = state.where((m) => m != marker).toList();
  }

  void clearMarkers() {
    state = [];
  }
}
 


final routeStateProvider = StateNotifierProvider<RouteState, NewRoute?>((ref) {
  return RouteState();
});

class RouteState extends StateNotifier<NewRoute?> {
  // final Reader read;

  RouteState( ) : super(null);
  var routeService = GetIt.I<RouteService>();

  Future<void> createRoute(NewRoute newRoute) async {
 
    final result = await routeService.createNewRoute(newRoute);
    if (result != null) {
      state = result; // Update the state with the new route
    }
    // Handle errors or validation failures as needed
  }
}
