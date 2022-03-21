import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend_ecommerce_app/src/models/cart_model.dart';
import 'package:frontend_ecommerce_app/src/repository/user_repository.dart';

class CartRepository {
  CartRepository();

  Dio dio = Dio(BaseOptions(
    baseUrl: Platform.isAndroid
        ? 'http://10.0.2.2:3000/api'
        : 'http://localhost:3000/api',
    connectTimeout: 5000,
    receiveTimeout: 3000,
    validateStatus: (status) {
      return status! < 500;
    },
  ));

  //get cart by
  Future<Cart?> getCartByUserId() async {
    try {
      Response response = await dio.get(
        '/cart',
        options: Options(
          headers: {
            "Authorization": "Bearer ${await UserRepository().getToken()}"
          },
        ),
      );
      // print(response.data['carts']);
      return Cart.fromJson(response.data['carts']);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //add to cart
  Future<Cart?> addToCart(String productId, int quantity) async {
    try {
      Response response = await dio.post(
        '/cart',
        data: {
          'productId': productId,
          'quantity': quantity,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${await UserRepository().getToken()}"
          },
        ),
      );
      return Cart.fromJson(response.data['carts']);
    } catch (e) {
      return null;
    }
  }

  //update cart
  Future<Cart?> updateCart(String productId, int quantity) async {
    try {
      Response response = await dio.put(
        '/cart',
        data: {
          'productId': productId,
          'quantity': quantity,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${await UserRepository().getToken()}"
          },
        ),
      );
      return Cart.fromJson(response.data['carts']);
    } catch (e) {
      return null;
    }
  }

  //delete cart
  Future<Cart?> deleteCart(String cartId) async {
    try {
      Response response = await dio.delete(
        '/cart',
        data: {
          'cartId': cartId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${await UserRepository().getToken()}"
          },
        ),
      );
      return Cart.fromJson(response.data['carts']);
    } catch (e) {
      return null;
    }
  }

  // delete a product from the cart by productId
  Future<Cart?> deleteProductFromCart(String productId) async {
    try {
      Response response = await dio.delete(
        '/cart/product/$productId',
        options: Options(
          headers: {
            "Authorization": "Bearer ${await UserRepository().getToken()}"
          },
        ),
      );
      return Cart.fromJson(response.data['carts']);
    } catch (e) {
      return null;
    }
  }
}
