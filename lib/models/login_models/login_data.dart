// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginData {
  final String username;
  final String password;

  LoginData({
    required this.username,
    required this.password,
  });

  LoginData copyWith({
    String? username,
    String? password,
  }) {
    return LoginData(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory LoginData.fromMap(Map<String, dynamic> map) {
    return LoginData(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginData.fromJson(String source) =>
      LoginData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginData(username: $username, password: $password)';

  @override
  bool operator ==(covariant LoginData other) {
    if (identical(this, other)) return true;

    return other.username == username && other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
