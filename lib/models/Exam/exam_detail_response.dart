// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../home_models/hashtag.dart';
import 'mascot_info.dart';
import 'user_info.dart';

class ExamDetailResponse {
  final ExamDetail exam_detail;
  final UserInfo user_info;
  final MascotInfo mascot_info;
  final List<Hashtag> hashtags;
  final int? has_history;
  final int? is_favourited;

  ExamDetailResponse({
    required this.exam_detail,
    required this.user_info,
    required this.mascot_info,
    required this.hashtags,
    this.has_history,
    this.is_favourited,
  });

  ExamDetailResponse copyWith({
    ExamDetail? exam_detail,
    UserInfo? user_info,
    MascotInfo? mascot_info,
    List<Hashtag>? hashtags,
    int? has_history,
    int? is_favourited,
  }) {
    return ExamDetailResponse(
      exam_detail: exam_detail ?? this.exam_detail,
      user_info: user_info ?? this.user_info,
      mascot_info: mascot_info ?? this.mascot_info,
      hashtags: hashtags ?? this.hashtags,
      has_history: has_history ?? this.has_history,
      is_favourited: is_favourited ?? this.is_favourited,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exam_detail': exam_detail.toMap(),
      'user_info': user_info.toMap(),
      'mascot_info': mascot_info.toMap(),
      'hashtags': hashtags.map((x) => x.toMap()).toList(),
      'has_history': has_history,
      'is_favourited': is_favourited,
    };
  }

  // hashtags: List<Hashtag>.from(
  //       (map['hashtags'] as List).map<Hashtag>(
  //         (x) => Hashtag.fromMap(x as Map<String, dynamic>),
  //       ),
  //     ),
  factory ExamDetailResponse.fromMap(Map<String, dynamic> map) {
    return ExamDetailResponse(
      exam_detail:
          ExamDetail.fromMap(map['exam_detail'] as Map<String, dynamic>),
      user_info: UserInfo.fromMap(map['user_info'] as Map<String, dynamic>),
      mascot_info:
          MascotInfo.fromMap(map['mascot_info'] as Map<String, dynamic>),
      hashtags: List<Hashtag>.from(
        (map['hashtags'] as List).map<Hashtag>(
          (x) => Hashtag.fromMap(x as Map<String, dynamic>),
        ),
      ),
      has_history:
          map['has_history'] != null ? map['has_history'] as int : null,
      is_favourited:
          map['is_favourited'] != null ? map['is_favourited'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamDetailResponse.fromJson(String source) =>
      ExamDetailResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExamDetailResponse(exam_detail: $exam_detail, user_info: $user_info, mascot_info: $mascot_info, hashtags: $hashtags, has_history: $has_history, is_favourited: $is_favourited)';
  }

  @override
  bool operator ==(covariant ExamDetailResponse other) {
    if (identical(this, other)) return true;

    return other.exam_detail == exam_detail &&
        other.user_info == user_info &&
        other.mascot_info == mascot_info &&
        listEquals(other.hashtags, hashtags) &&
        other.has_history == has_history &&
        other.is_favourited == is_favourited;
  }

  @override
  int get hashCode {
    return exam_detail.hashCode ^
        user_info.hashCode ^
        mascot_info.hashCode ^
        hashtags.hashCode ^
        has_history.hashCode ^
        is_favourited.hashCode;
  }
}

class ExamDetail {
  final int id;
  final String title;
  final String? description;
  final String? image;
  final int type;
  final int total_attempts;
  final int total_gpoints;
  final int total_favourites;
  final int total_shares;
  final int total_copies;
  final int total_rates;
  final int total_views;
  final int? comment_question_total;
  final num star_avg;
  final String created;
  final int total_question;
  final List<String> list_question;
  ExamDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.type,
    required this.total_attempts,
    required this.total_gpoints,
    required this.total_favourites,
    required this.total_shares,
    required this.total_copies,
    required this.total_rates,
    required this.total_views,
    required this.comment_question_total,
    required this.star_avg,
    required this.created,
    required this.total_question,
    required this.list_question,
  });

  ExamDetail copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    int? type,
    int? total_attempts,
    int? total_gpoints,
    int? total_favourites,
    int? total_shares,
    int? total_copies,
    int? total_rates,
    int? total_views,
    int? comment_question_total,
    num? star_avg,
    String? created,
    int? total_question,
    List<String>? list_question,
  }) {
    return ExamDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      type: type ?? this.type,
      total_attempts: total_attempts ?? this.total_attempts,
      total_gpoints: total_gpoints ?? this.total_gpoints,
      total_favourites: total_favourites ?? this.total_favourites,
      total_shares: total_shares ?? this.total_shares,
      total_copies: total_copies ?? this.total_copies,
      total_rates: total_rates ?? this.total_rates,
      total_views: total_views ?? this.total_views,
      comment_question_total:
          comment_question_total ?? this.comment_question_total,
      star_avg: star_avg ?? this.star_avg,
      created: created ?? this.created,
      total_question: total_question ?? this.total_question,
      list_question: list_question ?? this.list_question,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'type': type,
      'total_attempts': total_attempts,
      'total_gpoints': total_gpoints,
      'total_favourites': total_favourites,
      'total_shares': total_shares,
      'total_copies': total_copies,
      'total_rates': total_rates,
      'total_views': total_views,
      'comment_question_total': comment_question_total,
      'star_avg': star_avg,
      'created': created,
      'total_question': total_question,
      'list_question': list_question,
    };
  }

  // list_question: map['list_question']?.cast<String>(),
  factory ExamDetail.fromMap(Map<String, dynamic> map) {
    return ExamDetail(
      id: map['id'] as int,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      type: map['type'] as int,
      total_attempts: map['total_attempts'] as int,
      total_gpoints: map['total_gpoints'] as int,
      total_favourites: map['total_favourites'] as int,
      total_shares: map['total_shares'] as int,
      total_copies: map['total_copies'] as int,
      total_rates: map['total_rates'] as int,
      total_views: map['total_views'] as int,
      comment_question_total: map['comment_question_total'] != null
          ? map['comment_question_total'] as int
          : null,
      star_avg: map['star_avg'] as num,
      created: map['created'] as String,
      total_question: map['total_question'] as int,
      list_question: map['list_question']?.cast<String>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamDetail.fromJson(String source) =>
      ExamDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExamDetail(id: $id, title: $title, description: $description, image: $image, type: $type, total_attempts: $total_attempts, total_gpoints: $total_gpoints, total_favourites: $total_favourites, total_shares: $total_shares, total_copies: $total_copies, total_rates: $total_rates, total_views: $total_views, comment_question_total: $comment_question_total, star_avg: $star_avg, created: $created, total_question: $total_question, list_question: $list_question)';
  }

  @override
  bool operator ==(covariant ExamDetail other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.image == image &&
        other.type == type &&
        other.total_attempts == total_attempts &&
        other.total_gpoints == total_gpoints &&
        other.total_favourites == total_favourites &&
        other.total_shares == total_shares &&
        other.total_copies == total_copies &&
        other.total_rates == total_rates &&
        other.total_views == total_views &&
        other.comment_question_total == comment_question_total &&
        other.star_avg == star_avg &&
        other.created == created &&
        other.total_question == total_question &&
        listEquals(other.list_question, list_question);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        image.hashCode ^
        type.hashCode ^
        total_attempts.hashCode ^
        total_gpoints.hashCode ^
        total_favourites.hashCode ^
        total_shares.hashCode ^
        total_copies.hashCode ^
        total_rates.hashCode ^
        total_views.hashCode ^
        comment_question_total.hashCode ^
        star_avg.hashCode ^
        created.hashCode ^
        total_question.hashCode ^
        list_question.hashCode;
  }
}
