// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ChannelRanking {
  final int id;
  final String title;
  final String user_fullname;
  final String? user_image;
  final int total_favourites;

  ChannelRanking({
    required this.id,
    required this.title,
    required this.user_fullname,
    this.user_image,
    required this.total_favourites,
  });

  ChannelRanking copyWith({
    int? id,
    String? title,
    String? user_fullname,
    String? user_image,
    int? total_favourites,
  }) {
    return ChannelRanking(
      id: id ?? this.id,
      title: title ?? this.title,
      user_fullname: user_fullname ?? this.user_fullname,
      user_image: user_image ?? this.user_image,
      total_favourites: total_favourites ?? this.total_favourites,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'user_fullname': user_fullname,
      'user_image': user_image,
      'total_favourites': total_favourites,
    };
  }

  factory ChannelRanking.fromMap(Map<String, dynamic> map) {
    return ChannelRanking(
      id: map['id'] as int,
      title: map['title'] as String,
      user_fullname: map['user_fullname'] as String,
      user_image:
          map['user_image'] != null ? map['user_image'] as String : null,
      total_favourites: map['total_favourites'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChannelRanking.fromJson(String source) =>
      ChannelRanking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChannelRanking(id: $id, title: $title, user_fullname: $user_fullname, user_image: $user_image, total_favourites: $total_favourites)';
  }

  @override
  bool operator ==(covariant ChannelRanking other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.user_fullname == user_fullname &&
        other.user_image == user_image &&
        other.total_favourites == total_favourites;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        user_fullname.hashCode ^
        user_image.hashCode ^
        total_favourites.hashCode;
  }
}

class TopChannelModel {
  final List<ChannelRanking> top_channels;
  final dynamic current_ranking;

  TopChannelModel({
    required this.top_channels,
    required this.current_ranking,
  });

  TopChannelModel copyWith({
    List<ChannelRanking>? top_channels,
    dynamic current_ranking,
  }) {
    return TopChannelModel(
      top_channels: top_channels ?? this.top_channels,
      current_ranking: current_ranking ?? this.current_ranking,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'top_channels': top_channels.map((x) => x.toMap()).toList(),
      'current_ranking': current_ranking,
    };
  }

  factory TopChannelModel.fromMap(Map<String, dynamic> map) {
    return TopChannelModel(
      top_channels: List<ChannelRanking>.from(
        (map['top_channels'] as List).map<ChannelRanking>(
          (x) => ChannelRanking.fromMap(x as Map<String, dynamic>),
        ),
      ),
      current_ranking: map['current_ranking'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopChannelModel.fromJson(String source) =>
      TopChannelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TopChannelModel(top_channels: $top_channels, current_ranking: $current_ranking)';

  @override
  bool operator ==(covariant TopChannelModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.top_channels, top_channels) &&
        other.current_ranking == current_ranking;
  }

  @override
  int get hashCode => top_channels.hashCode ^ current_ranking.hashCode;
}
