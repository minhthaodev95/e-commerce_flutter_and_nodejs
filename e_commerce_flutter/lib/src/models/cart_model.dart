import 'dart:convert';

import 'package:frontend_ecommerce_app/src/models/product_model.dart';

class ItemModel {
  final String id;
  final Product product;
  final int quantity;
  final int total;

  ItemModel(
      {required this.id,
      required this.product,
      required this.quantity,
      required this.total});

  Map<String, dynamic> toMap() {
    return {
      'productId': product.toMap(),
      'quantity': quantity,
      'total': total,
    };
  }

  factory ItemModel.fromMap(map) {
    return ItemModel(
      id: map['_id'],
      product: Product.fromJson(map['productId']),
      quantity: map['quantity'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(source) => ItemModel.fromMap(source);
}

class Cart {
  final String id;
  final List<ItemModel> items;

  Cart({required this.id, required this.items});

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(map) {
    return Cart(
      id: map['_id'],
      items:
          List<ItemModel>.from(map['items']?.map((x) => ItemModel.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(source) => Cart.fromMap(source);
}
