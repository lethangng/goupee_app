import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final int id;
  String fullname;
  String? image;
  String? job_des;
  String? archieve_des;
  String? description;
  String? phone;
  String? email;
  int? g_points;
  int? total_recharge;
  String? channel_title;
  int? total_followers;
  int? total_favourites;
  int? total_attempts;
  String? login_type;
  int? is_login;

  User({
    required this.id,
    required this.fullname,
    required this.image,
    this.job_des,
    this.archieve_des,
    this.description,
    this.phone,
    required this.email,
    this.g_points,
    this.total_recharge,
    this.channel_title,
    this.total_followers,
    this.total_favourites,
    this.total_attempts,
    this.login_type = 'password',
    this.is_login,
  });

  User copyWith({
    int? id,
    String? fullname,
    String? image,
    String? job_des,
    String? archieve_des,
    String? description,
    String? phone,
    String? email,
    int? g_points,
    int? total_recharge,
    String? channel_title,
    int? total_followers,
    int? total_favourites,
    int? total_attempts,
    String? login_type,
    int? is_login,
  }) {
    return User(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      image: image ?? this.image,
      job_des: job_des ?? this.job_des,
      archieve_des: archieve_des ?? this.archieve_des,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      g_points: g_points ?? this.g_points,
      total_recharge: total_recharge ?? this.total_recharge,
      channel_title: channel_title ?? this.channel_title,
      total_followers: total_followers ?? this.total_followers,
      total_favourites: total_favourites ?? this.total_favourites,
      total_attempts: total_attempts ?? this.total_attempts,
      login_type: login_type ?? this.login_type,
      is_login: is_login ?? this.is_login,
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
      'phone': phone,
      'email': email,
      'g_points': g_points,
      'total_recharge': total_recharge,
      'channel_title': channel_title,
      'total_followers': total_followers,
      'total_favourites': total_favourites,
      'total_attempts': total_attempts,
      'login_type': login_type,
      'is_login': is_login,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      fullname: map['fullname'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      job_des: map['job_des'] != null ? map['job_des'] as String : null,
      archieve_des:
          map['archieve_des'] != null ? map['archieve_des'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      g_points: map['g_points'] != null ? map['g_points'] as int : null,
      total_recharge:
          map['total_recharge'] != null ? map['total_recharge'] as int : null,
      channel_title:
          map['channel_title'] != null ? map['channel_title'] as String : null,
      total_followers:
          map['total_followers'] != null ? map['total_followers'] as int : null,
      total_favourites: map['total_favourites'] != null
          ? map['total_favourites'] as int
          : null,
      total_attempts:
          map['total_attempts'] != null ? map['total_attempts'] as int : null,
      login_type:
          map['login_type'] != null ? map['login_type'] as String : null,
      is_login: map['is_login'] != null ? map['is_login'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, fullname: $fullname, image: $image, job_des: $job_des, archieve_des: $archieve_des, description: $description, phone: $phone, email: $email, g_points: $g_points, total_recharge: $total_recharge, channel_title: $channel_title, total_followers: $total_followers, total_favourites: $total_favourites, total_attempts: $total_attempts, login_type: $login_type, is_login: $is_login)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullname == fullname &&
        other.image == image &&
        other.job_des == job_des &&
        other.archieve_des == archieve_des &&
        other.description == description &&
        other.phone == phone &&
        other.email == email &&
        other.g_points == g_points &&
        other.total_recharge == total_recharge &&
        other.channel_title == channel_title &&
        other.total_followers == total_followers &&
        other.total_favourites == total_favourites &&
        other.total_attempts == total_attempts &&
        other.login_type == login_type &&
        other.is_login == is_login;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullname.hashCode ^
        image.hashCode ^
        job_des.hashCode ^
        archieve_des.hashCode ^
        description.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        g_points.hashCode ^
        total_recharge.hashCode ^
        channel_title.hashCode ^
        total_followers.hashCode ^
        total_favourites.hashCode ^
        total_attempts.hashCode ^
        login_type.hashCode ^
        is_login.hashCode;
  }
}
