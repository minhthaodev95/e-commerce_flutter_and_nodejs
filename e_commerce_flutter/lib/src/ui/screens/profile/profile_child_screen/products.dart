import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_ecommerce_app/src/models/product_model.dart';
import 'package:frontend_ecommerce_app/src/repository/porduct_repository.dart';
import 'package:image_picker/image_picker.dart';

import 'components/card_product.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({Key? key, required this.userId}) : super(key: key);

  final String userId;
  @override
  _MyProductsScreenState createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  List<File> images = [];

  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productCategoryController = TextEditingController();
  final productTagsController = TextEditingController();
  final productImageController = TextEditingController();

  Future<void> pickMultiImage() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      final imagesTemporary = images.map((image) => File(image.path)).toList();

      setState(() {
        for (File image in imagesTemporary) {
          // ignore: iterable_contains_unrelated_type
          print(image);
          print(this.images.contains(image));
          if (!this.images.contains(image)) {
            this.images.add(image);
          }
          print(this.images);
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    productImageController.text = 'assets/images/product_image.png';
    super.initState();
  }

  void addProductDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text('Add Product'),
          content: SingleChildScrollView(
            child: Container(
              // height: 400,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: productNameController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                    ),
                  ),
                  TextField(
                    controller: productPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Product Price',
                    ),
                  ),
                  TextField(
                    controller: productDescriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Product Description',
                    ),
                  ),
                  TextField(
                    controller: productCategoryController,
                    decoration: const InputDecoration(
                      labelText: 'Product Category',
                    ),
                  ),
                  TextField(
                    controller: productTagsController,
                    decoration: const InputDecoration(
                      labelText: 'Product Tags',
                    ),
                  ),
                  Container(
                      height: 50,
                      child: SizedBox(
                        width: 400,
                        child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (index == images.length) {
                              return GestureDetector(
                                onTap: () async {
                                  await pickMultiImage();
                                  setState(() {});
                                },
                                child: const Icon(Icons.add_a_photo),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  images[index],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                          },
                          itemCount: images.length + 1,
                        ),
                      )),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () async {
                await ProductRepository().createProduct(
                  title: productNameController.text,
                  price: int.parse(productPriceController.text),
                  description: productDescriptionController.text,
                  category: productCategoryController.text,
                  tags: productTagsController.text.split(','),
                  files: images,
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(Icons.arrow_back_ios),
            )),
        title: const Text(
          'My Products',
          // style: TextStyle(color: AppTheme.colors.text1),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: addProductDialog,
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
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
