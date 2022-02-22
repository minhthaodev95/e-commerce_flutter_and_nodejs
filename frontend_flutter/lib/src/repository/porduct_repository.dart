import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend_ecommerce_app/src/models/product_model.dart';

class ProductRepository {
  Dio dio = Dio(BaseOptions(
    baseUrl: Platform.isAndroid
        ? 'http://10.0.2.2:3000/api/'
        : 'http://localhost:3000/api/',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));
  ProductRepository();
  Future<List<Product>> getProducts() async {
    try {
      Response response = await dio.get('products');
      return (response.data as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } catch (e) {
      // print(e);
      return [];
    }
  }
}
