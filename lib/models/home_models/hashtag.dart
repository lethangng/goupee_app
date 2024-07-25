// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Hashtag {
  final int id;
  final String title;
  final int? total_linked_exams;

  Hashtag({
    required this.id,
    required this.title,
    required this.total_linked_exams,
  });

  Hashtag copyWith({
    int? id,
    String? title,
    int? total_linked_exams,
  }) {
    return Hashtag(
      id: id ?? this.id,
      title: title ?? this.title,
      total_linked_exams: total_linked_exams ?? this.total_linked_exams,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'total_linked_exams': total_linked_exams,
    };
  }

  factory Hashtag.fromMap(Map<String, dynamic> map) {
    return Hashtag(
      id: map['id'] as int,
      title: map['title'] as String,
      total_linked_exams: map['total_linked_exams'] != null
          ? map['total_linked_exams'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hashtag.fromJson(String source) =>
      Hashtag.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Hashtag(id: $id, title: $title, total_linked_exams: $total_linked_exams)';

  @override
  bool operator ==(covariant Hashtag other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.total_linked_exams == total_linked_exams;
  }

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ total_linked_exams.hashCode;
}
