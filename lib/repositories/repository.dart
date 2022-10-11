import 'package:latlong2/latlong.dart';
import 'package:map_with_objects/models/map_marker.dart';
import 'package:map_with_objects/providers/markers_provider.dart';

class Repository {
  final _markersProvider = MarkersProvider();

  Future<List<MapMarker>> getAllMarkers(
      LatLng leftTopPoint, LatLng centerPoint) {
    return _markersProvider.getMarkers(leftTopPoint, centerPoint);
  }
}
