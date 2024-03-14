
import 'package:latlong2/latlong.dart';

class MapMarker {
  final LatLng position;
  final String label;
  final String? iconPath; // Optional: Path to the marker icon image

  MapMarker({
    required this.position,
    required this.label,
    this.iconPath,
  });
}
