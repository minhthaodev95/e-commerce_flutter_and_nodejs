import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_ecommerce_app/src/models/category.dart';

class CategoryRepository {
  Dio dio = Dio(BaseOptions(
    baseUrl: Platform.isAndroid
        ? 'http://10.0.2.2:3000/api/category'
        : 'http://localhost:3000/api/category',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  CategoryRepository();

  // get all categories List<Category>
  Future<List<Category>> getCategories() async {
    try {
      Response response = await dio.get(
        '/',
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((category) => Category.fromJson(category))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // create a new category
  Future<Category?> createCategory(Category category) async {
    try {
      Response response = await dio.post(
        '/',
        data: category.toJson(),
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      if (response.statusCode == 200) {
        return Category.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // update category by id
  Future<Category?> updateCategory(Category category) async {
    try {
      Response response = await dio.put(
        '/${category.id}',
        data: category.toJson(),
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      if (response.statusCode == 200) {
        return Category.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // dalete category by id
  Future<bool> deleteCategory(int id) async {
    try {
      Response response = await dio.delete(
        '/$id',
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: "token");
  }
}
