// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AnswerHistory {
  final String? user_answer;
  final int is_right;
  final int unlock_explain;
  final String remain_time;
  AnswerHistory({
    required this.user_answer,
    required this.is_right,
    required this.unlock_explain,
    required this.remain_time,
  });

  AnswerHistory copyWith({
    String? user_answer,
    int? is_right,
    int? unlock_explain,
    String? remain_time,
  }) {
    return AnswerHistory(
      user_answer: user_answer ?? this.user_answer,
      is_right: is_right ?? this.is_right,
      unlock_explain: unlock_explain ?? this.unlock_explain,
      remain_time: remain_time ?? this.remain_time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_answer': user_answer,
      'is_right': is_right,
      'unlock_explain': unlock_explain,
      'remain_time': remain_time,
    };
  }

  factory AnswerHistory.fromMap(Map<String, dynamic> map) {
    return AnswerHistory(
      user_answer:
          map['user_answer'] != null ? map['user_answer'] as String : null,
      is_right: map['is_right'] as int,
      unlock_explain: map['unlock_explain'] as int,
      remain_time: map['remain_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerHistory.fromJson(String source) =>
      AnswerHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnswerHistory(user_answer: $user_answer, is_right: $is_right, unlock_explain: $unlock_explain, remain_time: $remain_time)';
  }

  @override
  bool operator ==(covariant AnswerHistory other) {
    if (identical(this, other)) return true;

    return other.user_answer == user_answer &&
        other.is_right == is_right &&
        other.unlock_explain == unlock_explain &&
        other.remain_time == remain_time;
  }

  @override
  int get hashCode {
    return user_answer.hashCode ^
        is_right.hashCode ^
        unlock_explain.hashCode ^
        remain_time.hashCode;
  }
}

class ExamQuestionHistory {
  final Map<String, AnswerHistory> history;
  final int exam_id;
  ExamQuestionHistory({
    required this.history,
    required this.exam_id,
  });

  ExamQuestionHistory copyWith({
    Map<String, AnswerHistory>? history,
    int? exam_id,
  }) {
    return ExamQuestionHistory(
      history: history ?? this.history,
      exam_id: exam_id ?? this.exam_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'history': history,
      'exam_id': exam_id,
    };
  }

  // Map<String, AnswerHistory> history = {};
  //   (map['history'] as Map<String, dynamic>).forEach((key, value) {
  //     if (value is Map<String, dynamic>) {
  //       history[key] = AnswerHistory.fromMap(value);
  //     }
  //   });
  //   return ExamQuestionHistory(
  //     history: history,
  //     exam_id: map['exam_id'] as int,
  //   );
  factory ExamQuestionHistory.fromMap(Map<String, dynamic> map) {
    Map<String, AnswerHistory> history = {};
    map['history'].forEach((key, value) {
      history[key] = AnswerHistory.fromMap(value);
    });
    return ExamQuestionHistory(
      history: history,
      exam_id: map['exam_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamQuestionHistory.fromJson(String source) =>
      ExamQuestionHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ExamQuestionHistory(history: $history, exam_id: $exam_id)';

  @override
  bool operator ==(covariant ExamQuestionHistory other) {
    if (identical(this, other)) return true;

    return mapEquals(other.history, history) && other.exam_id == exam_id;
  }

  @override
  int get hashCode => history.hashCode ^ exam_id.hashCode;
}
