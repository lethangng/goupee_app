// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExamItemModel {
  final int id;
  final String title;
  final String? user_fullname;
  final String? user_image;
  final String? description;
  final String? image;
  final int total_favourites;
  final int total_views;
  final int total_gpoints;
  final String created;

  ExamItemModel({
    required this.id,
    required this.title,
    required this.user_fullname,
    this.user_image,
    this.description,
    required this.image,
    required this.total_favourites,
    required this.total_views,
    required this.total_gpoints,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'user_fullname': user_fullname,
      'user_image': user_image,
      'description': description,
      'image': image,
      'total_favourites': total_favourites,
      'total_views': total_views,
      'total_gpoints': total_gpoints,
      'created': created,
    };
  }

  factory ExamItemModel.fromMap(Map<String, dynamic> map) {
    return ExamItemModel(
      id: map['id'] as int,
      title: map['title'] as String,
      user_fullname:
          map['user_fullname'] != null ? map['user_fullname'] as String : null,
      user_image:
          map['user_image'] != null ? map['user_image'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      total_favourites: map['total_favourites'] as int,
      total_views: map['total_views'] as int,
      total_gpoints: map['total_gpoints'] as int,
      created: map['created'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamItemModel.fromJson(String source) =>
      ExamItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ExamItemModel copyWith({
    int? id,
    String? title,
    String? user_fullname,
    String? user_image,
    String? description,
    String? image,
    int? total_favourites,
    int? total_views,
    int? total_gpoints,
    String? created,
  }) {
    return ExamItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      user_fullname: user_fullname ?? this.user_fullname,
      user_image: user_image ?? this.user_image,
      description: description ?? this.description,
      image: image ?? this.image,
      total_favourites: total_favourites ?? this.total_favourites,
      total_views: total_views ?? this.total_views,
      total_gpoints: total_gpoints ?? this.total_gpoints,
      created: created ?? this.created,
    );
  }

  @override
  String toString() {
    return 'ExamItemModel(id: $id, title: $title, user_fullname: $user_fullname, user_image: $user_image, description: $description, image: $image, total_favourites: $total_favourites, total_views: $total_views, total_gpoints: $total_gpoints, created: $created)';
  }

  @override
  bool operator ==(covariant ExamItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.user_fullname == user_fullname &&
        other.user_image == user_image &&
        other.description == description &&
        other.image == image &&
        other.total_favourites == total_favourites &&
        other.total_views == total_views &&
        other.total_gpoints == total_gpoints &&
        other.created == created;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        user_fullname.hashCode ^
        user_image.hashCode ^
        description.hashCode ^
        image.hashCode ^
        total_favourites.hashCode ^
        total_views.hashCode ^
        total_gpoints.hashCode ^
        created.hashCode;
  }
}
