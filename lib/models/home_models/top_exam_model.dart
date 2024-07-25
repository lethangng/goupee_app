// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TopExamModel {
  final int id;
  final String title;
  final int total_favourites;

  TopExamModel({
    required this.id,
    required this.title,
    required this.total_favourites,
  });

  TopExamModel copyWith({
    int? id,
    String? title,
    int? total_favourites,
  }) {
    return TopExamModel(
      id: id ?? this.id,
      title: title ?? this.title,
      total_favourites: total_favourites ?? this.total_favourites,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'total_favourites': total_favourites,
    };
  }

  factory TopExamModel.fromMap(Map<String, dynamic> map) {
    return TopExamModel(
      id: map['id'] as int,
      title: map['title'] as String,
      total_favourites: map['total_favourites'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopExamModel.fromJson(String source) =>
      TopExamModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TopExamModel(id: $id, title: $title, total_favourites: $total_favourites)';

  @override
  bool operator ==(covariant TopExamModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.total_favourites == total_favourites;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ total_favourites.hashCode;
}
