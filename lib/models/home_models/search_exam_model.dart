// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'exam_item_model.dart';

class SearchExamModel {
  final List<ExamItemModel> exams;
  final int? total_result;

  SearchExamModel({
    required this.exams,
    required this.total_result,
  });

  SearchExamModel copyWith({
    List<ExamItemModel>? exams,
    int? total_result,
  }) {
    return SearchExamModel(
      exams: exams ?? this.exams,
      total_result: total_result ?? this.total_result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exams': exams.map((x) => x.toMap()).toList(),
      'total_result': total_result,
    };
  }

  factory SearchExamModel.fromMap(Map<String, dynamic> map) {
    return SearchExamModel(
      exams: List<ExamItemModel>.from(
        (map['exams'] as List).map<ExamItemModel>(
          (x) => ExamItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total_result:
          map['total_result'] != null ? map['total_result'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchExamModel.fromJson(String source) =>
      SearchExamModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SearchExamModel(exams: $exams, total_result: $total_result)';

  @override
  bool operator ==(covariant SearchExamModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.exams, exams) && other.total_result == total_result;
  }

  @override
  int get hashCode => exams.hashCode ^ total_result.hashCode;
}
