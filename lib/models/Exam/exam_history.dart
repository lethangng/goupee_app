// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExamHistory {
  final int id;
  final int exam_id;
  final String exam_title;
  final int total_true;
  final int? total_time;
  final String total_time_txt;
  final int limit_time;
  final String limit_time_txt;
  final String submit_time;
  final int total_question;
  final int start_from;
  final int type;
  // final String status;
  final int status;

  ExamHistory({
    required this.id,
    required this.exam_id,
    required this.exam_title,
    required this.total_true,
    required this.total_time,
    required this.total_time_txt,
    required this.limit_time,
    required this.limit_time_txt,
    required this.submit_time,
    required this.total_question,
    required this.start_from,
    required this.type,
    required this.status,
  });

  ExamHistory copyWith({
    int? id,
    int? exam_id,
    String? exam_title,
    int? total_true,
    int? total_time,
    String? total_time_txt,
    int? limit_time,
    String? limit_time_txt,
    String? submit_time,
    int? total_question,
    int? start_from,
    int? type,
    int? status,
  }) {
    return ExamHistory(
      id: id ?? this.id,
      exam_id: exam_id ?? this.exam_id,
      exam_title: exam_title ?? this.exam_title,
      total_true: total_true ?? this.total_true,
      total_time: total_time ?? this.total_time,
      total_time_txt: total_time_txt ?? this.total_time_txt,
      limit_time: limit_time ?? this.limit_time,
      limit_time_txt: limit_time_txt ?? this.limit_time_txt,
      submit_time: submit_time ?? this.submit_time,
      total_question: total_question ?? this.total_question,
      start_from: start_from ?? this.start_from,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'exam_id': exam_id,
      'exam_title': exam_title,
      'total_true': total_true,
      'total_time': total_time,
      'total_time_txt': total_time_txt,
      'limit_time': limit_time,
      'limit_time_txt': limit_time_txt,
      'submit_time': submit_time,
      'total_question': total_question,
      'start_from': start_from,
      'type': type,
      'status': status,
    };
  }

  factory ExamHistory.fromMap(Map<String, dynamic> map) {
    return ExamHistory(
      id: map['id'] as int,
      exam_id: map['exam_id'] as int,
      exam_title: map['exam_title'] as String,
      total_true: map['total_true'] as int,
      total_time: map['total_time'] != null ? map['total_time'] as int : null,
      total_time_txt: map['total_time_txt'] as String,
      limit_time: map['limit_time'] as int,
      limit_time_txt: map['limit_time_txt'] as String,
      submit_time: map['submit_time'] as String,
      total_question: map['total_question'] as int,
      start_from: map['start_from'] as int,
      type: map['type'] as int,
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamHistory.fromJson(String source) =>
      ExamHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExamHistory(id: $id, exam_id: $exam_id, exam_title: $exam_title, total_true: $total_true, total_time: $total_time, total_time_txt: $total_time_txt, limit_time: $limit_time, limit_time_txt: $limit_time_txt, submit_time: $submit_time, total_question: $total_question, start_from: $start_from, type: $type, status: $status)';
  }

  @override
  bool operator ==(covariant ExamHistory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.exam_id == exam_id &&
        other.exam_title == exam_title &&
        other.total_true == total_true &&
        other.total_time == total_time &&
        other.total_time_txt == total_time_txt &&
        other.limit_time == limit_time &&
        other.limit_time_txt == limit_time_txt &&
        other.submit_time == submit_time &&
        other.total_question == total_question &&
        other.start_from == start_from &&
        other.type == type &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        exam_id.hashCode ^
        exam_title.hashCode ^
        total_true.hashCode ^
        total_time.hashCode ^
        total_time_txt.hashCode ^
        limit_time.hashCode ^
        limit_time_txt.hashCode ^
        submit_time.hashCode ^
        total_question.hashCode ^
        start_from.hashCode ^
        type.hashCode ^
        status.hashCode;
  }
}
