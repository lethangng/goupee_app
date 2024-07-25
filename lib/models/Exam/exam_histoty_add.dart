// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ExamHistotyAdd {
  final int exam_history_id;
  final List<String> list_question;
  final int limit_time;

  ExamHistotyAdd({
    required this.exam_history_id,
    required this.list_question,
    required this.limit_time,
  });

  ExamHistotyAdd copyWith({
    int? exam_history_id,
    List<String>? list_question,
    int? limit_time,
  }) {
    return ExamHistotyAdd(
      exam_history_id: exam_history_id ?? this.exam_history_id,
      list_question: list_question ?? this.list_question,
      limit_time: limit_time ?? this.limit_time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exam_history_id': exam_history_id,
      'list_question': list_question,
      'limit_time': limit_time,
    };
  }

  // map['list_question']?.cast<String>()
  factory ExamHistotyAdd.fromMap(Map<String, dynamic> map) {
    return ExamHistotyAdd(
      exam_history_id: map['exam_history_id'] as int,
      list_question: map['list_question']?.cast<String>(),
      limit_time: map['limit_time'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamHistotyAdd.fromJson(String source) =>
      ExamHistotyAdd.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ExamHistotyAdd(exam_history_id: $exam_history_id, list_question: $list_question, limit_time: $limit_time)';

  @override
  bool operator ==(covariant ExamHistotyAdd other) {
    if (identical(this, other)) return true;

    return other.exam_history_id == exam_history_id &&
        listEquals(other.list_question, list_question) &&
        other.limit_time == limit_time;
  }

  @override
  int get hashCode =>
      exam_history_id.hashCode ^ list_question.hashCode ^ limit_time.hashCode;
}
