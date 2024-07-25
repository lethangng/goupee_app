import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SearchHistory {
  final int? id;
  final String content;

  SearchHistory({
    this.id,
    required this.content,
  });

  SearchHistory copyWith({
    int? id,
    String? content,
  }) {
    return SearchHistory(
      id: id ?? this.id,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
    };
  }

  factory SearchHistory.fromMap(Map<String, dynamic> map) {
    return SearchHistory(
      id: map['id'] != null ? map['id'] as int : null,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchHistory.fromJson(String source) =>
      SearchHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SearchHistory(id: $id, content: $content)';

  @override
  bool operator ==(covariant SearchHistory other) {
    if (identical(this, other)) return true;

    return other.id == id && other.content == content;
  }

  @override
  int get hashCode => id.hashCode ^ content.hashCode;
}
