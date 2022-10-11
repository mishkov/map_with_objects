import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import 'package:map_with_objects/models/map_marker.dart';

class MarkersProvider {
  Future<List<MapMarker>> getMarkers(LatLng leftTopPoint, LatLng centerPoint) async {
    final uri = Uri.parse('https://xn--k1aahcehedi.xn--90ais/graphql');
    final headers = {'Content-Type': 'application/json'};
    final query = {
      'query':
          '\n        {\n  map_markers(general:{language:"by",city:"minsk",country:"by",subscription:"platinum"\n  ,activity:[],tag:[]},\n  leftTopPoint: { lat: ${leftTopPoint.latitude}, lng: ${leftTopPoint.longitude}},\n    centerPoint:{lat: ${centerPoint.latitude}, lng: ${centerPoint.longitude}}) {\n    lat\n    lng\n    suppliers {\n      id\n      name\n    }\n  }\n}\n    '
    };

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(query),
    );

    if (response.statusCode == 200) {
      final mapResponse = jsonDecode(response.body);
      final List mapMarkers = mapResponse['data']['map_markers'];

      return mapMarkers.map((e) => MapMarker.fromMap(e)).toList();
    } else {
      throw GetMarkersException(
          'Status code of respose is ${response.statusCode}. Body: ${response.body}');
    }
  }
}

class GetMarkersException implements Exception {
  final String message;

  GetMarkersException(this.message);
}
