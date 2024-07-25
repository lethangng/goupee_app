// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Comment {
  final int id;
  final int? parent_id;
  final String content;
  final String? images;
  final int total_replies;
  final int g_points;
  final int favourite_points;
  final String created;
  final int user_id;
  final String user_fullname;
  final String? user_image;
  final int? user_refer;
  final String? user_refer_fullname;
  final String? user_refer_image;
  final List<Comment> child;

  Comment({
    required this.id,
    this.parent_id,
    required this.content,
    this.images,
    required this.total_replies,
    required this.g_points,
    required this.favourite_points,
    required this.created,
    required this.user_id,
    required this.user_fullname,
    this.user_image,
    this.user_refer,
    this.user_refer_fullname,
    this.user_refer_image,
    required this.child,
  });

  Comment copyWith({
    int? id,
    int? parent_id,
    String? content,
    String? images,
    int? total_replies,
    int? g_points,
    int? favourite_points,
    String? created,
    int? user_id,
    String? user_fullname,
    String? user_image,
    int? user_refer,
    String? user_refer_fullname,
    String? user_refer_image,
    List<Comment>? child,
  }) {
    return Comment(
      id: id ?? this.id,
      parent_id: parent_id ?? this.parent_id,
      content: content ?? this.content,
      images: images ?? this.images,
      total_replies: total_replies ?? this.total_replies,
      g_points: g_points ?? this.g_points,
      favourite_points: favourite_points ?? this.favourite_points,
      created: created ?? this.created,
      user_id: user_id ?? this.user_id,
      user_fullname: user_fullname ?? this.user_fullname,
      user_image: user_image ?? this.user_image,
      user_refer: user_refer ?? this.user_refer,
      user_refer_fullname: user_refer_fullname ?? this.user_refer_fullname,
      user_refer_image: user_refer_image ?? this.user_refer_image,
      child: child ?? this.child,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'parent_id': parent_id,
      'content': content,
      'images': images,
      'total_replies': total_replies,
      'g_points': g_points,
      'favourite_points': favourite_points,
      'created': created,
      'user_id': user_id,
      'user_fullname': user_fullname,
      'user_image': user_image,
      'user_refer': user_refer,
      'user_refer_fullname': user_refer_fullname,
      'user_refer_image': user_refer_image,
      'child': child.map((x) => x.toMap()).toList(),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as int,
      parent_id: map['parent_id'] != null ? map['parent_id'] as int : null,
      content: map['content'] as String,
      images: map['images'] != null ? map['images'] as String : null,
      total_replies: map['total_replies'] as int,
      g_points: map['g_points'] as int,
      favourite_points: map['favourite_points'] as int,
      created: map['created'] as String,
      user_id: map['user_id'] as int,
      user_fullname: map['user_fullname'] as String,
      user_image:
          map['user_image'] != null ? map['user_image'] as String : null,
      user_refer: map['user_refer'] != null ? map['user_refer'] as int : null,
      user_refer_fullname: map['user_refer_fullname'] != null
          ? map['user_refer_fullname'] as String
          : null,
      user_refer_image: map['user_refer_image'] != null
          ? map['user_refer_image'] as String
          : null,
      child: List<Comment>.from(
        (map['child']).map<Comment>(
          (x) => Comment.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Comment(id: $id, parent_id: $parent_id, content: $content, images: $images, total_replies: $total_replies, g_points: $g_points, favourite_points: $favourite_points, created: $created, user_id: $user_id, user_fullname: $user_fullname, user_image: $user_image, user_refer: $user_refer, user_refer_fullname: $user_refer_fullname, user_refer_image: $user_refer_image, child: $child)';
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.parent_id == parent_id &&
        other.content == content &&
        other.images == images &&
        other.total_replies == total_replies &&
        other.g_points == g_points &&
        other.favourite_points == favourite_points &&
        other.created == created &&
        other.user_id == user_id &&
        other.user_fullname == user_fullname &&
        other.user_image == user_image &&
        other.user_refer == user_refer &&
        other.user_refer_fullname == user_refer_fullname &&
        other.user_refer_image == user_refer_image &&
        listEquals(other.child, child);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        parent_id.hashCode ^
        content.hashCode ^
        images.hashCode ^
        total_replies.hashCode ^
        g_points.hashCode ^
        favourite_points.hashCode ^
        created.hashCode ^
        user_id.hashCode ^
        user_fullname.hashCode ^
        user_image.hashCode ^
        user_refer.hashCode ^
        user_refer_fullname.hashCode ^
        user_refer_image.hashCode ^
        child.hashCode;
  }
}

class CommentModel {
  final List<Comment> comments;
  final int? total_result;

  CommentModel({
    required this.comments,
    this.total_result,
  });

  CommentModel copyWith({
    List<Comment>? comments,
    int? total_result,
  }) {
    return CommentModel(
      comments: comments ?? this.comments,
      total_result: total_result ?? this.total_result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comments': comments.map((x) => x.toMap()).toList(),
      'total_result': total_result,
    };
  }

  // comments: List<Comment>.from(
  //       (map['comments'] as List).map<Comment>(
  //         (x) => Comment.fromMap(x as Map<String, dynamic>),
  //       ),
  //     ),
  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comments: List<Comment>.from(
        (map['comments'] as List).map<Comment>(
          (x) => Comment.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total_result:
          map['total_result'] != null ? map['total_result'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CommentModel(comments: $comments, total_result: $total_result)';

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.comments, comments) &&
        other.total_result == total_result;
  }

  @override
  int get hashCode => comments.hashCode ^ total_result.hashCode;
}
