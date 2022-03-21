import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? address;
  final String role;
  final String? image;

  User(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      required this.role,
      this.image,
      this.address});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'image': image,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      role: map['role'],
      image: map['image'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(source) => User.fromMap(source);
}
