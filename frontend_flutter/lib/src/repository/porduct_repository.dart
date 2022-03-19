import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_ecommerce_app/src/models/product_model.dart';

class ProductRepository {
  Dio dio = Dio(BaseOptions(
    baseUrl: Platform.isAndroid
        ? 'http://10.0.2.2:3000/api/product'
        : 'http://localhost:3000/api/product',
    connectTimeout: 5000,
    receiveTimeout: 3000,
    validateStatus: (status) {
      return status! < 500;
    },
  ));
  ProductRepository();

  // create a new product
  Future<Product?> createProduct(Product product) async {
    try {
      final response = await dio.post('/', data: product.toMap());
      return Product.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      String? token = await getToken();
      if (token != null) {
        Response response = await dio.get('/',
            options: Options(headers: {"Authorization": "Bearer $token"}));
        if (response.statusCode == 200) {
          return (response.data as List)
              .map((product) => Product.fromJson(product))
              .toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // get products by userId
  Future<List<Product>> getProductsByUserId(String userId) async {
    try {
      Response response = await dio.get('/user/$userId',
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      // print(e);
      return [];
    }
  }

  // get products by categoryId
  Future<List<Product>> getProductsByCategoryId(String categoryId) async {
    try {
      Response response = await dio.get('/category/$categoryId',
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      // print(e);
      return [];
    }
  }

  // get product by ID
  Future<Product?> getProductById(String id) async {
    try {
      Response response = await dio.get('/$id',
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      // print(e);
      return null;
    }
  }

  // delete product by ID
  Future<bool> deleteProductById(String id) async {
    try {
      Response response = await dio.delete('/$id',
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // print(e);
      return false;
    }
  }

  // update product by id
  Future<bool> updateProductById(String id, Product product) async {
    try {
      Response response = await dio.put('/$id',
          data: product.toMap(),
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // print(e);
      return false;
    }
  }

  // get products by range price
  Future<List<Product>> getProductsByRangePrice(
      double minPrice, double maxPrice) async {
    try {
      Response response = await dio.get('/price/$minPrice/$maxPrice',
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      // print(e);
      return [];
    }
  }

  // get all products by name
  Future<List<Product>> getProductsByName(String name) async {
    try {
      Response response = await dio.get('/name/$name',
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      // print(e);
      return [];
    }
  }

  //get products by range date
  Future<List<Product>> getProductsByRangeDate(
      DateTime minDate, DateTime maxDate) async {
    try {
      Response response = await dio.get(
          '/date/${minDate.toString()}/${maxDate.toString()}',
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      // print(e);
      return [];
    }
  }

  // get products by tag
  Future<List<Product>> getProductsByTags(String tag) async {
    try {
      Response response = await dio.get('/tags/$tag',
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      // print(e);
      return [];
    }
  }

  // get Token from local storage
  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    try {
      String? token = await storage.read(key: 'token');
      if (token != null) {
        return token;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
