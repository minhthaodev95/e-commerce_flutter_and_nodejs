import 'dart:math';

import 'package:dio/dio.dart';
import 'package:frontend_ecommerce_app/src/models/user_model.dart';
import 'package:frontend_ecommerce_app/src/models/user_register_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  Dio dio = Dio(BaseOptions(
    baseUrl: "http://localhost:3000/api/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));
  UserRepository();

  Future<String?> signInWithEmailandPassword(
      String email, String password) async {
    final response = await dio
        .post("user/login", data: {"email": email, "password": password});
    if (response.statusCode == 200) {
      await setToken(response.data["data"]["token"]);
      return response.data["data"]['id'] as String;
    } else {
      return null;
    }
  }

  Future<int?> registerWithEmailandPassword(UserRegister user) async {
    final response = await dio.post("user/register", data: user.toJson());

    return response.statusCode ?? 401;
  }

  Future<User?> getUser() async {
    final token = await getToken();
    if (token != null) {
      final response = await dio.get("user/me",
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        return User.fromJson(response.data["data"]);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // Future<bool> isLogin() async {
  //   final token = await getToken();

  // }

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: "token");
  }

  Future<void> setToken(String token) async {
    // save token in keystore/keychain
    const storage = FlutterSecureStorage();
    storage
        .write(key: "token", value: token)
        .then((_) => print('set Token success'))
        .onError((error, stackTrace) => print(error));
  }

  Future<void> logOut() async {
    // delete token from keystore/keychain
    const storage = FlutterSecureStorage();
    storage
        .delete(key: "token")
        .then((_) => print('delete Token success'))
        .onError((error, stackTrace) => print(error));
  }

// to test done will delete
  Future<void> printToken() async {
    // get token from keystore/keychain
    const storage = FlutterSecureStorage();
    storage
        .read(key: "token")
        .then((value) => print('token : $value'))
        .onError((error, stackTrace) => print(error));
  }

  Future<void> deleteUser() async {}

  Future<void> updateUser(User user) async {}

  Future<void> updateUserPassword(String password) async {}

  Future<void> updateUserEmail(String email) async {}

  Future<void> updateUserName(String name) async {}

  Future<void> updateUserPhone(String phone) async {}

  Future<void> updateUserPhoto(String photo) async {}

  Future<void> updateUserAddress(String address) async {}
}
