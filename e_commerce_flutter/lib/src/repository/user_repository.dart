import 'package:dio/dio.dart';
import 'package:frontend_ecommerce_app/src/models/user_model.dart';
import 'package:frontend_ecommerce_app/src/models/user_register_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io' show File, Platform;

class UserRepository {
  Dio dio = Dio(BaseOptions(
    baseUrl: Platform.isAndroid
        ? 'http://10.0.2.2:3000/api/'
        : 'http://localhost:3000/api/',
    connectTimeout: 5000,
    receiveTimeout: 3000,
    validateStatus: (status) {
      return status! < 500;
    },
  ));

  UserRepository();

  Future<String?> signInWithEmailandPassword(
      String email, String password) async {
    try {
      final response = await dio.post("auth/login", data: {
        "email": email,
        "password": password,
      }, options: Options(
        // followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ));
      if (response.statusCode == 200) {
        await setToken(response.data["data"]["token"]);
        return response.data["data"]['id'] as String;
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e);
      return null;
    }
  }

  Future<int?> registerWithEmailandPassword(UserRegister user) async {
    final response = await dio.post("auth/register", data: user.toJson());

    return response.statusCode ?? 401;
  }

  Future<User?> getUser() async {
    try {
      final token = await getToken();
      if (token != null) {
        final response = await dio.get("user/me",
            options: Options(
                headers: {"Authorization": "Bearer ${await getToken()}"}));
        if (response.statusCode == 200) {
          return User.fromJson(response.data["data"]);
        } else if (response.statusCode == 401 &&
            response.data["error"] == "Token is invalid or expired") {
          await removeToken();
          return null;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> removeToken() async {
    await const FlutterSecureStorage().delete(key: "token");
  }

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

  Future<void> deleteUser() async {
    final token = await getToken();
    if (token != null) {
      final response = await dio.delete("user/me",
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        await logOut();
      }
    }
  }

  Future<void> updateUser({User? user, File? file}) async {
    final token = await getToken();
    if (token != null) {
      final response = await dio.put("user/me",
          data: user!.toJson(),
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        await getUser();
      }
    }
  }

  Future<void> updateAvatar({File? file}) async {
    final token = await getToken();
    if (token != null) {
      FormData formData = FormData();

      formData = FormData.fromMap({
        "files": file == null
            ? {}
            : await MultipartFile.fromFile(file.path,
                filename: file.path.split('/').last),
      });

      final response = await dio.put("user/me",
          data: formData,
          options: Options(
              headers: {"Authorization": "Bearer ${await getToken()}"}));
      if (response.statusCode == 200) {
        await getUser();
      }
    }
  }
}
