import 'dart:convert';

import 'package:map_with_objects/models/supplier.dart';

class MapMarker {
  final double latitude;
  final double longitude;
  final List<Supplier> suppliers;

  MapMarker({
    required this.latitude,
    required this.longitude,
    required this.suppliers,
  });

  factory MapMarker.fromMap(Map<String, dynamic> map) {
    final List unparsedSuppliers = map['suppliers'];
    final suppliers = unparsedSuppliers.map((e) => Supplier.fromMap(e));

    return MapMarker(
      latitude: map['lat'] ?? 0.0,
      longitude: map['lng'] ?? 0.0,
      suppliers: suppliers.toList(),
    );
  }

  factory MapMarker.fromJson(String source) {
    return MapMarker.fromMap(json.decode(source));
  }
}
