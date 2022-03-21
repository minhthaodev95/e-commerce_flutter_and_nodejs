import 'dart:convert';

class UserRegister {
  final String username;
  final String password;
  final String email;
  final String phone;

  UserRegister(
      {required this.username,
      required this.password,
      required this.email,
      required this.phone});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
    };
  }

  factory UserRegister.fromMap(Map<String, dynamic> map) {
    return UserRegister(
      username: map['username'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRegister.fromJson(String source) =>
      UserRegister.fromMap(json.decode(source));
}
