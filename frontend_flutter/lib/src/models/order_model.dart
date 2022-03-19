import 'dart:convert';

import 'package:frontend_ecommerce_app/src/models/product_model.dart';

class Order {
  final String id;
  final String userSellerId;
  final String userBuyerId;
  final List<Product> products;
  final String status;
  final String total;
  final DateTime createdAt;
  Order({
    required this.id,
    required this.userSellerId,
    required this.userBuyerId,
    required this.products,
    required this.status,
    required this.total,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userSellerId': userSellerId,
      'userBuyerId': userBuyerId,
      'products': products.map((x) => x.toMap()).toList(),
      'status': status,
      'total': total,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userSellerId: map['userSellerId'],
      userBuyerId: map['userBuyerId'],
      products:
          List<Product>.from(map['products']?.map((x) => Product.fromJson(x))),
      status: map['status'],
      total: map['total'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
