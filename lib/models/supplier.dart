import 'dart:convert';

class Supplier {
  final String id;
  final String name;

  Supplier({
    required this.id,
    required this.name,
  });

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  factory Supplier.fromJson(String source) {
    return Supplier.fromMap(json.decode(source));
  }
}
