import 'dart:convert';

class User {
  final String name;
  final String? phone;
  final String email;
  final String? role;

  User({required this.name, this.phone, required this.email, this.role});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      role: map['role'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(source) => User.fromMap(source);
}
