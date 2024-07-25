// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestData {
  // final String app_id;
  // final String login_token;
  // final String user_id;
  final String query;
  final String data;

  RequestData({
    required this.query,
    required this.data,
  });

  RequestData copyWith({
    String? query,
    String? data,
  }) {
    return RequestData(
      query: query ?? this.query,
      data: data ?? this.data,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'query': query,
      'data': data,
    };
  }

  factory RequestData.fromMap(Map<String, dynamic> map) {
    return RequestData(
      query: map['query'] as String,
      data: map['data'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestData.fromJson(String source) =>
      RequestData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RequestData(query: $query, data: $data)';

  @override
  bool operator ==(covariant RequestData other) {
    if (identical(this, other)) return true;

    return other.query == query && other.data == data;
  }

  @override
  int get hashCode => query.hashCode ^ data.hashCode;
}

class RegisterData {
  final String fullname;
  final String username;
  final String password;
  final String parent_id;

  RegisterData({
    required this.fullname,
    required this.username,
    required this.password,
    this.parent_id = '',
  });

  RegisterData copyWith({
    String? fullname,
    String? username,
    String? password,
    String? parent_id,
  }) {
    return RegisterData(
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
      password: password ?? this.password,
      parent_id: parent_id ?? this.parent_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullname': fullname,
      'username': username,
      'password': password,
      'parent_id': parent_id,
    };
  }

  factory RegisterData.fromMap(Map<String, dynamic> map) {
    return RegisterData(
      fullname: map['fullname'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      parent_id: map['parent_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterData.fromJson(String source) =>
      RegisterData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterData(fullname: $fullname, username: $username, password: $password, parent_id: $parent_id)';
  }

  @override
  bool operator ==(covariant RegisterData other) {
    if (identical(this, other)) return true;

    return other.fullname == fullname &&
        other.username == username &&
        other.password == password &&
        other.parent_id == parent_id;
  }

  @override
  int get hashCode {
    return fullname.hashCode ^
        username.hashCode ^
        password.hashCode ^
        parent_id.hashCode;
  }
}
