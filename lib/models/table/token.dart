// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Token {
  final String app_id;
  final String login_token;
  final int user_id;
  int? is_login;

  Token({
    required this.app_id,
    this.login_token = '',
    this.user_id = 0,
    this.is_login,
  });

  Token copyWith({
    String? app_id,
    String? login_token,
    int? user_id,
    int? is_login,
  }) {
    return Token(
      app_id: app_id ?? this.app_id,
      login_token: login_token ?? this.login_token,
      user_id: user_id ?? this.user_id,
      is_login: is_login ?? this.is_login,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'app_id': app_id,
      'login_token': login_token,
      'user_id': user_id,
      'is_login': is_login,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      app_id: map['app_id'] as String,
      login_token: map['login_token'] as String,
      user_id: map['user_id'] as int,
      is_login: map['is_login'] != null ? map['is_login'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) =>
      Token.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Token(app_id: $app_id, login_token: $login_token, user_id: $user_id, is_login: $is_login)';
  }

  @override
  bool operator ==(covariant Token other) {
    if (identical(this, other)) return true;

    return other.app_id == app_id &&
        other.login_token == login_token &&
        other.user_id == user_id &&
        other.is_login == is_login;
  }

  @override
  int get hashCode {
    return app_id.hashCode ^
        login_token.hashCode ^
        user_id.hashCode ^
        is_login.hashCode;
  }
}
