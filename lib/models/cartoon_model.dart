import 'dart:convert';

class CartoonModel {
  final String name;
  final String cover;
  final String pdf;
  CartoonModel({
    this.name,
    this.cover,
    this.pdf,
  });

  CartoonModel copyWith({
    String name,
    String cover,
    String pdf,
  }) {
    return CartoonModel(
      name: name ?? this.name,
      cover: cover ?? this.cover,
      pdf: pdf ?? this.pdf,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cover': cover,
      'pdf': pdf,
    };
  }

  factory CartoonModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CartoonModel(
      name: map['name'],
      cover: map['cover'],
      pdf: map['pdf'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartoonModel.fromJson(String source) => CartoonModel.fromMap(json.decode(source));

  @override
  String toString() => 'CartoonModel(name: $name, cover: $cover, pdf: $pdf)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CartoonModel &&
      o.name == name &&
      o.cover == cover &&
      o.pdf == pdf;
  }

  @override
  int get hashCode => name.hashCode ^ cover.hashCode ^ pdf.hashCode;
}
