import 'dart:convert';

class Category {
  final String id;
  final String title;
  final String description;

  Category({required this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'],
      title: map['title'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(source) => Category.fromMap(source);
}
