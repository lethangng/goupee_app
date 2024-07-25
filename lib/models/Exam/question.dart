// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'sentence_search.dart';

enum MessageType { user, res }

class QuestionContainer {
  final SentenceSearch? sentenceSearch;
  final List<Question>? listQuestion;
  String messageType;

  QuestionContainer({
    this.sentenceSearch,
    this.listQuestion,
    this.messageType = 'user',
  });
}

class Question {
  final int id;
  final String title;
  final String content;
  final Map<String, dynamic> quest;
  final List<String> images;
  final String right_answer;
  final int g_point;

  Question({
    required this.id,
    required this.title,
    required this.content,
    required this.quest,
    required this.images,
    required this.right_answer,
    required this.g_point,
  });

  Question copyWith({
    int? id,
    String? title,
    String? content,
    Map<String, dynamic>? quest,
    List<String>? images,
    String? right_answer,
    int? g_point,
  }) {
    return Question(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      quest: quest ?? this.quest,
      images: images ?? this.images,
      right_answer: right_answer ?? this.right_answer,
      g_point: g_point ?? this.g_point,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'quest': quest,
      'images': images,
      'right_answer': right_answer,
      'g_point': g_point,
    };
  }

  // images: map['images']?.cast<String>(),
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      quest: Map<String, dynamic>.from((map['quest'] as Map<String, dynamic>)),
      images: map['images']?.cast<String>(),
      right_answer: map['right_answer'] as String,
      g_point: map['g_point'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(id: $id, title: $title, content: $content, quest: $quest, images: $images, right_answer: $right_answer, g_point: $g_point)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        mapEquals(other.quest, quest) &&
        listEquals(other.images, images) &&
        other.right_answer == right_answer &&
        other.g_point == g_point;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        quest.hashCode ^
        images.hashCode ^
        right_answer.hashCode ^
        g_point.hashCode;
  }
}
