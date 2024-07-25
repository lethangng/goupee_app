// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../home_models/command.dart';

class SentenceSearch {
  final int id;
  final String title;
  final String description;
  final int exam_type;
  final String sample_exam_title;
  final List<String> images;

  SentenceSearch({
    required this.id,
    required this.title,
    required this.description,
    required this.exam_type,
    required this.sample_exam_title,
    required this.images,
  });

  factory SentenceSearch.commandTo(Command? command, String text) {
    return SentenceSearch(
      id: command == null ? 0 : command.id,
      title: command == null ? text : command.description,
      description: command == null ? '' : command.description,
      exam_type: command == null ? 4 : command.exam_type,
      images: command == null ? [] : command.images,
      sample_exam_title: command == null ? '' : command.sample_exam_title,
    );
  }

  SentenceSearch copyWith({
    int? id,
    String? title,
    String? description,
    int? exam_type,
    String? sample_exam_title,
    List<String>? images,
  }) {
    return SentenceSearch(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      exam_type: exam_type ?? this.exam_type,
      sample_exam_title: sample_exam_title ?? this.sample_exam_title,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'exam_type': exam_type,
      'sample_exam_title': sample_exam_title,
      'images': images,
    };
  }

  factory SentenceSearch.fromMap(Map<String, dynamic> map) {
    return SentenceSearch(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      exam_type: map['exam_type'] as int,
      sample_exam_title: map['sample_exam_title'] as String,
      images: map['images']?.cast<String>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SentenceSearch.fromJson(String source) =>
      SentenceSearch.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SentenceSearch(id: $id, title: $title, description: $description, exam_type: $exam_type, sample_exam_title: $sample_exam_title, images: $images)';
  }

  @override
  bool operator ==(covariant SentenceSearch other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.exam_type == exam_type &&
        other.sample_exam_title == sample_exam_title &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        exam_type.hashCode ^
        sample_exam_title.hashCode ^
        images.hashCode;
  }
}
