// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserInfo {
  final int id;
  final String fullname;
  final String? image;
  final String? job_des;
  final String? archieve_des;
  final String? description;

  UserInfo({
    required this.id,
    required this.fullname,
    required this.image,
    required this.job_des,
    required this.archieve_des,
    required this.description,
  });

  UserInfo copyWith({
    int? id,
    String? fullname,
    String? image,
    String? job_des,
    String? archieve_des,
    String? description,
  }) {
    return UserInfo(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      image: image ?? this.image,
      job_des: job_des ?? this.job_des,
      archieve_des: archieve_des ?? this.archieve_des,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'image': image,
      'job_des': job_des,
      'archieve_des': archieve_des,
      'description': description,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      id: map['id'] as int,
      fullname: map['fullname'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      job_des: map['job_des'] != null ? map['job_des'] as String : null,
      archieve_des:
          map['archieve_des'] != null ? map['archieve_des'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserInfo(id: $id, fullname: $fullname, image: $image, job_des: $job_des, archieve_des: $archieve_des, description: $description)';
  }

  @override
  bool operator ==(covariant UserInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullname == fullname &&
        other.image == image &&
        other.job_des == job_des &&
        other.archieve_des == archieve_des &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullname.hashCode ^
        image.hashCode ^
        job_des.hashCode ^
        archieve_des.hashCode ^
        description.hashCode;
  }
}
