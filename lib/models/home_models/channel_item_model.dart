import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'exam_item_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChannelInfo {
  final int id;
  final int user_id;
  final String user_fullname;
  final String title;
  final String? user_image;
  final int total_followers;
  final int total_favourites;
  final int total_attempts;

  ChannelInfo({
    required this.id,
    required this.user_id,
    required this.user_fullname,
    required this.title,
    this.user_image,
    required this.total_followers,
    required this.total_favourites,
    required this.total_attempts,
  });

  ChannelInfo copyWith({
    int? id,
    int? user_id,
    String? user_fullname,
    String? title,
    String? user_image,
    int? total_followers,
    int? total_favourites,
    int? total_attempts,
  }) {
    return ChannelInfo(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      user_fullname: user_fullname ?? this.user_fullname,
      title: title ?? this.title,
      user_image: user_image ?? this.user_image,
      total_followers: total_followers ?? this.total_followers,
      total_favourites: total_favourites ?? this.total_favourites,
      total_attempts: total_attempts ?? this.total_attempts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'user_fullname': user_fullname,
      'title': title,
      'user_image': user_image,
      'total_followers': total_followers,
      'total_favourites': total_favourites,
      'total_attempts': total_attempts,
    };
  }

  factory ChannelInfo.fromMap(Map<String, dynamic> map) {
    return ChannelInfo(
      id: map['id'] as int,
      user_id: map['user_id'] as int,
      user_fullname: map['user_fullname'] as String,
      title: map['title'] as String,
      user_image:
          map['user_image'] != null ? map['user_image'] as String : null,
      total_followers: map['total_followers'] as int,
      total_favourites: map['total_favourites'] as int,
      total_attempts: map['total_attempts'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChannelInfo.fromJson(String source) =>
      ChannelInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChannelInfo(id: $id, user_id: $user_id, user_fullname: $user_fullname, title: $title, user_image: $user_image, total_followers: $total_followers, total_favourites: $total_favourites, total_attempts: $total_attempts)';
  }

  @override
  bool operator ==(covariant ChannelInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user_id == user_id &&
        other.user_fullname == user_fullname &&
        other.title == title &&
        other.user_image == user_image &&
        other.total_followers == total_followers &&
        other.total_favourites == total_favourites &&
        other.total_attempts == total_attempts;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        user_fullname.hashCode ^
        title.hashCode ^
        user_image.hashCode ^
        total_followers.hashCode ^
        total_favourites.hashCode ^
        total_attempts.hashCode;
  }
}

class HighlightExam {
  final int id;
  final String title;
  final String? image;
  final int total_favourites;
  final int total_views;
  final int total_gpoints;
  final String created;

  HighlightExam({
    required this.id,
    required this.title,
    this.image,
    required this.total_favourites,
    required this.total_views,
    required this.total_gpoints,
    required this.created,
  });

  ExamItemModel toExamItemModel() {
    return ExamItemModel(
      id: id,
      title: title,
      user_fullname: '',
      image: image,
      total_favourites: total_favourites,
      total_views: total_views,
      total_gpoints: total_gpoints,
      created: created,
    );
  }

  HighlightExam copyWith({
    int? id,
    String? title,
    String? image,
    int? total_favourites,
    int? total_views,
    int? total_gpoints,
    String? created,
  }) {
    return HighlightExam(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      total_favourites: total_favourites ?? this.total_favourites,
      total_views: total_views ?? this.total_views,
      total_gpoints: total_gpoints ?? this.total_gpoints,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'total_favourites': total_favourites,
      'total_views': total_views,
      'total_gpoints': total_gpoints,
      'created': created,
    };
  }

  factory HighlightExam.fromMap(Map<String, dynamic> map) {
    return HighlightExam(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      total_favourites: map['total_favourites'] as int,
      total_views: map['total_views'] as int,
      total_gpoints: map['total_gpoints'] as int,
      created: map['created'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HighlightExam.fromJson(String source) =>
      HighlightExam.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HignlightExam(id: $id, title: $title, image: $image, total_favourites: $total_favourites, total_views: $total_views, total_gpoints: $total_gpoints, created: $created)';
  }

  @override
  bool operator ==(covariant HighlightExam other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
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
        image.hashCode ^
        total_favourites.hashCode ^
        total_views.hashCode ^
        total_gpoints.hashCode ^
        created.hashCode;
  }
}

class ChannelItemModel {
  final ChannelInfo channel_info;
  final int total_mascots;
  final int total_exams;
  final String report_favourite;
  final String report_suggest;
  final List<HighlightExam> highlight_exams;

  ChannelItemModel({
    required this.channel_info,
    required this.total_mascots,
    required this.total_exams,
    required this.report_favourite,
    required this.report_suggest,
    required this.highlight_exams,
  });

  ChannelItemModel copyWith({
    ChannelInfo? channel_info,
    int? total_mascots,
    int? total_exams,
    String? report_favourite,
    String? report_suggest,
    List<HighlightExam>? highlight_exams,
  }) {
    return ChannelItemModel(
      channel_info: channel_info ?? this.channel_info,
      total_mascots: total_mascots ?? this.total_mascots,
      total_exams: total_exams ?? this.total_exams,
      report_favourite: report_favourite ?? this.report_favourite,
      report_suggest: report_suggest ?? this.report_suggest,
      highlight_exams: highlight_exams ?? this.highlight_exams,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'channel_info': channel_info.toMap(),
      'total_mascots': total_mascots,
      'total_exams': total_exams,
      'report_favourite': report_favourite,
      'report_suggest': report_suggest,
      'highlight_exams': highlight_exams.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ChannelItemModel.fromJson(String source) =>
      ChannelItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChannelItemModel(channel_info: $channel_info, total_mascots: $total_mascots, total_exams: $total_exams, report_favourite: $report_favourite, report_suggest: $report_suggest, highlight_exams: $highlight_exams)';
  }

  @override
  bool operator ==(covariant ChannelItemModel other) {
    if (identical(this, other)) return true;

    return other.channel_info == channel_info &&
        other.total_mascots == total_mascots &&
        other.total_exams == total_exams &&
        other.report_favourite == report_favourite &&
        other.report_suggest == report_suggest &&
        listEquals(other.highlight_exams, highlight_exams);
  }

  @override
  int get hashCode {
    return channel_info.hashCode ^
        total_mascots.hashCode ^
        total_exams.hashCode ^
        report_favourite.hashCode ^
        report_suggest.hashCode ^
        highlight_exams.hashCode;
  }

  factory ChannelItemModel.fromMap(Map<String, dynamic> map) {
    return ChannelItemModel(
      channel_info:
          ChannelInfo.fromMap(map['channel_info'] as Map<String, dynamic>),
      total_mascots: map['total_mascots'] as int,
      total_exams: map['total_exams'] as int,
      report_favourite: map['report_favourite'] as String,
      report_suggest: map['report_suggest'] as String,
      highlight_exams: List<HighlightExam>.from(
        (map['highlight_exams']).map<HighlightExam>(
          (x) => HighlightExam.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
