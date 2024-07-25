// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PackageModel {
  final int id;
  final String title;
  final int price;
  final int price_off;
  final int g_point;
  final String content;
  final String description;

  PackageModel({
    required this.id,
    required this.title,
    required this.price,
    required this.price_off,
    required this.g_point,
    required this.content,
    required this.description,
  });

  PackageModel copyWith({
    int? id,
    String? title,
    int? price,
    int? price_off,
    int? g_point,
    String? content,
    String? description,
  }) {
    return PackageModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      price_off: price_off ?? this.price_off,
      g_point: g_point ?? this.g_point,
      content: content ?? this.content,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'price_off': price_off,
      'g_point': g_point,
      'content': content,
      'description': description,
    };
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      id: map['id'] as int,
      title: map['title'] as String,
      price: map['price'] as int,
      price_off: map['price_off'] as int,
      g_point: map['g_point'] as int,
      content: map['content'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageModel.fromJson(String source) =>
      PackageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PackageModel(id: $id, title: $title, price: $price, price_off: $price_off, g_point: $g_point, content: $content, description: $description)';
  }

  @override
  bool operator ==(covariant PackageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.price == price &&
        other.price_off == price_off &&
        other.g_point == g_point &&
        other.content == content &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        price.hashCode ^
        price_off.hashCode ^
        g_point.hashCode ^
        content.hashCode ^
        description.hashCode;
  }
}
