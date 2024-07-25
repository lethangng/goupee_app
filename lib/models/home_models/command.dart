// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Command {
  final int id;
  final String title;
  final String description;
  final int exam_type;
  final String sample_exam_title;
  final List<String> images;

  Command({
    required this.id,
    required this.title,
    required this.description,
    required this.exam_type,
    required this.sample_exam_title,
    required this.images,
  });

  Command copyWith({
    int? id,
    String? title,
    String? description,
    int? exam_type,
    String? sample_exam_title,
    List<String>? images,
  }) {
    return Command(
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

  // images: map['images']?.cast<String>(),
  factory Command.fromMap(Map<String, dynamic> map) {
    return Command(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      exam_type: map['exam_type'] as int,
      sample_exam_title: map['sample_exam_title'] as String,
      images: map['images']?.cast<String>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Command.fromJson(String source) =>
      Command.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Command(id: $id, title: $title, description: $description, exam_type: $exam_type, sample_exam_title: $sample_exam_title, images: $images)';
  }

  @override
  bool operator ==(covariant Command other) {
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
