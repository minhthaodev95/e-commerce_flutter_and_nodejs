import 'package:frontend_ecommerce_app/src/models/category.dart';
import 'package:frontend_ecommerce_app/src/models/user_model.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final List<String> tags;
  final int price;
  final User user;
  final Category category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.tags,
    required this.user,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      images: json['images'].cast<String>(),
      tags: json['tags'].cast<String>(),
      price: json['price'],
      user: User.fromJson(json['user']),
      category: Category.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "images": images,
      "price": price,
      "user": user.id,
      "category": category.id,
      "tags": tags,
    };
  }
}
