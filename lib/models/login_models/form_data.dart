// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FormDataError {
  String name;
  String email;
  String otp;
  String password;
  String confirmPassword;
  String newPassword;

  FormDataError({
    this.name = '',
    this.email = '',
    this.otp = '',
    this.password = '',
    this.confirmPassword = '',
    this.newPassword = '',
  });

  @override
  bool operator ==(covariant FormDataError other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.otp == otp &&
        other.password == password &&
        other.confirmPassword == confirmPassword &&
        other.newPassword == newPassword;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        otp.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode ^
        newPassword.hashCode;
  }

  FormDataError copyWith({
    String? name,
    String? email,
    String? otp,
    String? password,
    String? confirmPassword,
    String? newPassword,
  }) {
    return FormDataError(
      name: name ?? this.name,
      email: email ?? this.email,
      otp: otp ?? this.otp,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'otp': otp,
      'password': password,
      'confirmPassword': confirmPassword,
      'newPassword': newPassword,
    };
  }

  factory FormDataError.fromMap(Map<String, dynamic> map) {
    return FormDataError(
      name: map['name'] as String,
      email: map['email'] as String,
      otp: map['otp'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
      newPassword: map['newPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormDataError.fromJson(String source) =>
      FormDataError.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormDataError(name: $name, email: $email, otp: $otp, password: $password, confirmPassword: $confirmPassword, newPassword: $newPassword)';
  }
}
