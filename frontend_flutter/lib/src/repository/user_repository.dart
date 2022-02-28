import 'package:dio/dio.dart';
import 'package:frontend_ecommerce_app/src/models/user_model.dart';
import 'package:frontend_ecommerce_app/src/models/user_register_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
import 'dart:io' show File, Platform;

class UserRepository {
  Dio dio = Dio(BaseOptions(
    baseUrl: Platform.isAndroid
        ? 'http://10.0.2.2:3000/api/'
        : 'http://localhost:3000/api/',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));
  UserRepository();

  Future<String?> signInWithEmailandPassword(
      String email, String password) async {
    final response = await dio.post("user/auth/login", data: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      await setToken(response.data["data"]["token"]);
      return response.data["data"]['id'] as String;
    } else {
      return null;
    }
  }

  Future<int?> registerWithEmailandPassword(UserRegister user) async {
    final response = await dio.post("user/auth/register", data: user.toJson());

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
        } else if (response.statusCode == 401) {
          await removeToken();
          return null;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on Exception catch (e) {
      // print(e);
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

  Future<String> uploadUserAvatar(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "files": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    // print('Data: $formData');
    final response = await dio.put("/user/me",
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
        data: formData);
    return response.data['id'];
  }

  Future<void> uploadMultiImage(List<File?> images) async {
    if (images.isNotEmpty) {
      // ignore: prefer_typing_uninitialized_variables
      var formData = FormData.fromMap({"files": []});
      for (var i = 0; i < images.length; i++) {
        formData.files.addAll([
          MapEntry(
              "files",
              await MultipartFile.fromFile(images[i]!.path,
                  filename: images[i]!.path.split("/").last)),
        ]);
      }

      final response = await dio.post("/user/me/upload",
          options:
              Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
          data: formData);
      print(response.data);
    }
  }

  Future<void> updateUserPassword(String password) async {}

  Future<void> updateUserEmail(String email) async {}

  Future<void> updateUserName(String name) async {}

  Future<void> updateUserPhone(String phone) async {}

  Future<void> updateUserPhoto(String photo) async {}

  Future<void> updateUserAddress(String address) async {}
}
