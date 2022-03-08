import 'package:flutter/material.dart';
import 'package:frontend_ecommerce_app/src/models/product_model.dart';
import 'package:frontend_ecommerce_app/src/repository/porduct_repository.dart';

import 'components/card_product.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({Key? key, required this.userId}) : super(key: key);

  final String userId;
  @override
  _MyProductsScreenState createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
          title: const Text(
            'My Products',
            // style: TextStyle(color: AppTheme.colors.text1),
          )),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 600,
          child: FutureBuilder<List<Product>>(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardProduct(
                      product: snapshot.data![index],
                    );
                  },
                );
              }
            },
            future: ProductRepository().getProductsByUserId(widget.userId),
          ),
        ),
      ),
    );
  }
}
