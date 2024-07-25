// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MascotInfo {
  final int id;
  final String title;
  final String user_fullname;
  final int favourite_point;
  final int g_point;
  final int total_exams;
  final int current_level;
  final int current_percent;

  MascotInfo({
    required this.id,
    required this.title,
    required this.user_fullname,
    required this.favourite_point,
    required this.g_point,
    required this.total_exams,
    required this.current_level,
    required this.current_percent,
  });

  MascotInfo copyWith({
    int? id,
    String? title,
    String? user_fullname,
    int? favourite_point,
    int? g_point,
    int? total_exams,
    int? current_level,
    int? current_percent,
  }) {
    return MascotInfo(
      id: id ?? this.id,
      title: title ?? this.title,
      user_fullname: user_fullname ?? this.user_fullname,
      favourite_point: favourite_point ?? this.favourite_point,
      g_point: g_point ?? this.g_point,
      total_exams: total_exams ?? this.total_exams,
      current_level: current_level ?? this.current_level,
      current_percent: current_percent ?? this.current_percent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'user_fullname': user_fullname,
      'favourite_point': favourite_point,
      'g_point': g_point,
      'total_exams': total_exams,
      'current_level': current_level,
      'current_percent': current_percent,
    };
  }

  factory MascotInfo.fromMap(Map<String, dynamic> map) {
    return MascotInfo(
      id: map['id'] as int,
      title: map['title'] as String,
      user_fullname: map['user_fullname'] as String,
      favourite_point: map['favourite_point'] as int,
      g_point: map['g_point'] as int,
      total_exams: map['total_exams'] as int,
      current_level: map['current_level'] as int,
      current_percent: map['current_percent'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MascotInfo.fromJson(String source) =>
      MascotInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MascotInfo(id: $id, title: $title, user_fullname: $user_fullname, favourite_point: $favourite_point, g_point: $g_point, total_exams: $total_exams, current_level: $current_level, current_percent: $current_percent)';
  }

  @override
  bool operator ==(covariant MascotInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.user_fullname == user_fullname &&
        other.favourite_point == favourite_point &&
        other.g_point == g_point &&
        other.total_exams == total_exams &&
        other.current_level == current_level &&
        other.current_percent == current_percent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        user_fullname.hashCode ^
        favourite_point.hashCode ^
        g_point.hashCode ^
        total_exams.hashCode ^
        current_level.hashCode ^
        current_percent.hashCode;
  }
}
