import 'dart:io' show File, Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_ecommerce_app/src/blocs/auth/auth_bloc.dart';
import 'package:frontend_ecommerce_app/src/models/cart_model.dart';
import 'package:frontend_ecommerce_app/src/repository/cart_repository.dart';
import 'package:frontend_ecommerce_app/src/repository/order_repository.dart';
import 'package:frontend_ecommerce_app/src/repository/user_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
  late Cart cart;
  @override
  void initState() {
    // init notification service
    NotificationService().init();
    super.initState();
  }

  Future pickerImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Future<void> pickMultiImage() async {
  //   try {
  //     final images = await ImagePicker().pickMultiImage();
  //     if (images == null) return;
  //     final imagesTemporary = images.map((image) => File(image.path)).toList();
  //     setState(() {
  //       this.images = imagesTemporary;
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    /*24 is for notification bar on Android*/

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HomePage',
          // style: TextStyle(color: AppTheme.colors.text1),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(LogOut());
                Navigator.pushNamed(context, '/');
              },
              child: const Icon(Icons.logout_rounded))
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authorized) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                // padding: const EdgeInsets.only(left: 20, right: 20),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    state.user.image == null
                        ? Container()
                        : ClipOval(
                            child: Platform.isAndroid
                                ? Image.network(
                                    'http://10.0.2.2:3000/api/user/me${state.user.image}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    'http://localhost:3000/api/user/me${state.user.image}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                    Center(
                      child: Text('Hello  ${state.user.name}'),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await pickerImage();
                          if (image != null) {
                            await UserRepository().updateAvatar(file: image);
                            BlocProvider.of<AuthBloc>(context)
                                .add(AppStarted());
                          }
                        },
                        child: const Text(' Upload avatar')),
                    ElevatedButton(
                      onPressed: () async {
                        Cart? response =
                            await CartRepository().getCartByUserId();
                        if (response != null) {
                          cart = response;
                          // print(cart);
                        }
                      },
                      child: const Text('Get Cart'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await OrderRepository().createOrder(cart);
                      },
                      child: const Text('Create Order'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await NotificationService()
                            .showNotification(1, 'Hello', 'Hello');
                      },
                      child: const Text('Get Order'),
                    ),
                    // SizedBox(
                    //     height: 600,
                    //     child: FutureBuilder<List<Product>>(
                    //         builder:
                    //             (BuildContext context, AsyncSnapshot snapshot) {
                    //           if (!snapshot.hasData) {
                    //             return const Center(
                    //               child: CircularProgressIndicator(),
                    //             );
                    //           } else {
                    //             // return ListView.builder(
                    //             //     itemCount: snapshot.data.length,
                    //             //     itemBuilder:
                    //             //         (BuildContext context, int index) =>
                    //             //             CardProductCart(
                    //             //               product: snapshot.data[index],
                    //             //             ));

                    //             return GridView.builder(
                    //               shrinkWrap: true,
                    //               itemCount: snapshot.data!.length,
                    //               itemBuilder:
                    //                   (BuildContext context, int index) {
                    //                 return CustomCardProduct(
                    //                   product: snapshot.data![index],
                    //                 );
                    //               },
                    //               gridDelegate:
                    //                   SliverGridDelegateWithFixedCrossAxisCount(
                    //                       childAspectRatio:
                    //                           MediaQuery.of(context)
                    //                                   .size
                    //                                   .height /
                    //                               1000,
                    //                       crossAxisCount: 2,
                    //                       crossAxisSpacing: 10.0,
                    //                       mainAxisSpacing: 10.0),
                    //             );
                    //           }
                    //         },
                    //         future: ProductRepository().getProducts()))
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('HomePage'),
            );
          }
        },
      ),
    );
  }
}
