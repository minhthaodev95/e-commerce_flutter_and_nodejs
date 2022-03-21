import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend_ecommerce_app/src/models/cart_model.dart';
import 'package:frontend_ecommerce_app/src/models/order_model.dart';
import 'package:frontend_ecommerce_app/src/repository/user_repository.dart';

class OrderRepository {
  OrderRepository();

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

  //get order by userId
  Future<List<Order>> getOrderByUserId() async {
    try {
      Response response = await dio.get(
        '/order',
        options: Options(
          headers: {
            "Authorization": "Bearer ${await UserRepository().getToken()}"
          },
        ),
      );
      return (response.data['orders'] as List)
          .map((e) => Order.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  // create a new order
  Future<void> createOrder(Cart cart) async {
    try {
      Response response = await dio.post(
        '/order',
        data: cart.toJson(),
        options: Options(
          headers: {
            "Authorization": "Bearer ${await UserRepository().getToken()}"
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  // update status order by orderId
  Future<Order?> updateStatusOrder(String orderId, String status) async {
    try {
      Response response = await dio.put(
        '/order/$orderId',
        data: {'status': status},
        options: Options(
          headers: {
            "Authorization": "Bearer ${await UserRepository().getToken()}"
          },
        ),
      );
      return Order.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
