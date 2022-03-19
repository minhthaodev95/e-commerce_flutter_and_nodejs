import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_ecommerce_app/src/models/user_model.dart';

class AdminRepository {
  Dio dio = Dio(BaseOptions(
    baseUrl: Platform.isAndroid
        ? 'http://10.0.2.2:3000/api/admin'
        : 'http://localhost:3000/api/admin',
    connectTimeout: 5000,
    receiveTimeout: 3000,
    validateStatus: (status) {
      return status! < 500;
    },
  ));
  AdminRepository();

  // get all users
  Future<List<User>> getAllUsers() async {
    try {
      Response response = await dio.get(
        '/users',
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => User.fromJson(e)).toList();
      } else {
        throw Exception('Failed to get users');
      }
    } catch (e) {
      return [];
    }
  }

  // get user by email address
  Future<User?> getUserByEmail(String email) async {
    try {
      Response response = await dio.get(
        '/users/email/$email',
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to get user');
      }
    } catch (e) {
      return null;
    }
  }

  //get users by role
  Future<List<User>> getUsersByRole(String role) async {
    try {
      Response response = await dio.get(
        '/users/role/$role',
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => User.fromJson(e)).toList();
      } else {
        throw Exception('Failed to get users');
      }
    } catch (e) {
      return [];
    }
  }

  // get user by id
  Future<User?> getUserById(String id) async {
    try {
      Response response = await dio.get(
        '/user/$id',
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to get user');
      }
    } catch (e) {
      return null;
    }
  }

  // delete user by id
  Future<bool> deleteUserById(String id) async {
    try {
      Response response = await dio.delete(
        '/user/$id',
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete user');
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
