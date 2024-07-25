import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MascotItem {
  final int id;
  final String title;
  final String? image;
  final int user_id;
  final String user_fullname;
  final int g_point;
  final int favourite_point;
  final int total_exams;
  final int current_level;
  final int current_percent;

  MascotItem({
    required this.id,
    required this.title,
    this.image,
    required this.user_id,
    required this.user_fullname,
    required this.g_point,
    required this.favourite_point,
    required this.total_exams,
    required this.current_level,
    required this.current_percent,
  });

  MascotItem copyWith({
    int? id,
    String? title,
    String? image,
    int? user_id,
    String? user_fullname,
    int? g_point,
    int? favourite_point,
    int? total_exams,
    int? current_level,
    int? current_percent,
  }) {
    return MascotItem(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      user_id: user_id ?? this.user_id,
      user_fullname: user_fullname ?? this.user_fullname,
      g_point: g_point ?? this.g_point,
      favourite_point: favourite_point ?? this.favourite_point,
      total_exams: total_exams ?? this.total_exams,
      current_level: current_level ?? this.current_level,
      current_percent: current_percent ?? this.current_percent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'user_id': user_id,
      'user_fullname': user_fullname,
      'g_point': g_point,
      'favourite_point': favourite_point,
      'total_exams': total_exams,
      'current_level': current_level,
      'current_percent': current_percent,
    };
  }

  factory MascotItem.fromMap(Map<String, dynamic> map) {
    return MascotItem(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      user_id: map['user_id'] as int,
      user_fullname: map['user_fullname'] as String,
      g_point: map['g_point'] as int,
      favourite_point: map['favourite_point'] as int,
      total_exams: map['total_exams'] as int,
      current_level: map['current_level'] as int,
      current_percent: map['current_percent'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MascotItem.fromJson(String source) =>
      MascotItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LinhVatItemModel(id: $id, title: $title, image: $image, user_id: $user_id, user_fullname: $user_fullname, g_point: $g_point, favourite_point: $favourite_point, total_exams: $total_exams, current_level: $current_level, current_percent: $current_percent)';
  }

  @override
  bool operator ==(covariant MascotItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.image == image &&
        other.user_id == user_id &&
        other.user_fullname == user_fullname &&
        other.g_point == g_point &&
        other.favourite_point == favourite_point &&
        other.total_exams == total_exams &&
        other.current_level == current_level &&
        other.current_percent == current_percent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        image.hashCode ^
        user_id.hashCode ^
        user_fullname.hashCode ^
        g_point.hashCode ^
        favourite_point.hashCode ^
        total_exams.hashCode ^
        current_level.hashCode ^
        current_percent.hashCode;
  }
}
