// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../home_models/command.dart';
import '../home_models/hashtag.dart';

class AppData {
  final List<String> trending;
  final List<int> favourite_exam;
  final List<int> follow_channels;
  final List<Command> command;
  final List<int> top_channels;
  final List<int> top_exams;
  final List<Hashtag> hashtag;

  AppData({
    required this.trending,
    required this.favourite_exam,
    required this.follow_channels,
    required this.command,
    required this.top_channels,
    required this.top_exams,
    required this.hashtag,
  });

  AppData copyWith({
    List<String>? trending,
    List<int>? favourite_exam,
    List<int>? follow_channels,
    List<Command>? command,
    List<int>? top_channels,
    List<int>? top_exams,
    List<Hashtag>? hashtag,
  }) {
    return AppData(
      trending: trending ?? this.trending,
      favourite_exam: favourite_exam ?? this.favourite_exam,
      follow_channels: follow_channels ?? this.follow_channels,
      command: command ?? this.command,
      top_channels: top_channels ?? this.top_channels,
      top_exams: top_exams ?? this.top_exams,
      hashtag: hashtag ?? this.hashtag,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trending': trending,
      'favourite_exam': favourite_exam,
      'follow_channels': follow_channels,
      'command': command.map((x) => x.toMap()).toList(),
      'top_channels': top_channels,
      'top_exams': top_exams,
      'hashtag': hashtag.map((x) => x.toMap()).toList(),
    };
  }

  // trending: map['trending']?.cast<String>(),
  // favourite_exam: map['favourite_exam']?.cast<int>(),
  // follow_channels: map['follow_channels']?.cast<int>(),
  // top_channels: map['top_channels']?.cast<int>(),
  // top_exams: map['top_exams']?.cast<int>(),

  // Sua chua ham nay roi
  factory AppData.fromMap(Map<String, dynamic> map) {
    return AppData(
      trending: map['trending']?.cast<String>(),
      favourite_exam: map['favourite_exam']?.cast<int>(),
      follow_channels: map['follow_channels']?.cast<int>(),
      top_channels: map['top_channels']?.cast<int>(),
      top_exams: map['top_exams']?.cast<int>(),
      command: List<Command>.from(
        (map['command'] as List).map<Command>(
          (x) => Command.fromMap(x as Map<String, dynamic>),
        ),
      ),
      hashtag: List<Hashtag>.from(
        (map['hashtag'] as List).map<Hashtag>(
          (x) => Hashtag.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppData.fromJson(String source) =>
      AppData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppData(trending: $trending, favourite_exam: $favourite_exam, follow_channels: $follow_channels, command: $command, top_channels: $top_channels, top_exams: $top_exams, hashtag: $hashtag)';
  }

  @override
  bool operator ==(covariant AppData other) {
    if (identical(this, other)) return true;

    return listEquals(other.trending, trending) &&
        listEquals(other.favourite_exam, favourite_exam) &&
        listEquals(other.follow_channels, follow_channels) &&
        listEquals(other.command, command) &&
        listEquals(other.top_channels, top_channels) &&
        listEquals(other.top_exams, top_exams) &&
        listEquals(other.hashtag, hashtag);
  }

  @override
  int get hashCode {
    return trending.hashCode ^
        favourite_exam.hashCode ^
        follow_channels.hashCode ^
        command.hashCode ^
        top_channels.hashCode ^
        top_exams.hashCode ^
        hashtag.hashCode;
  }
}
