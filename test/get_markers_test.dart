import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_with_objects/models/map_marker.dart';
import 'package:map_with_objects/providers/markers_provider.dart';

void main() {
  test('get price list', () async {
    List<MapMarker> markers;
    try {
      final leftTopPoint = LatLng(53.93365935325979, 27.539634704589847);
      final centerPoint = LatLng(54.917104089366696, 28.57602691650391);
      markers = await MarkersProvider().getMarkers(leftTopPoint, centerPoint);
    } on GetMarkersException catch (e) {
      print(e.message);
      rethrow;
    }

    expect(markers.length, isPositive);

    for (final marker in markers) {
      expect(marker.latitude, isPositive);
      expect(marker.longitude, isPositive);
      expect(marker.suppliers.length, isPositive);
    }
  });
}
