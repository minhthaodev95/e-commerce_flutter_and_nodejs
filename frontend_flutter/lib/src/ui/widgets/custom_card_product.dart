import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_ecommerce_app/src/models/product_model.dart';
import 'package:intl/intl.dart';

class CustomCardProduct extends StatefulWidget {
  const CustomCardProduct({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  _CustomCardProductState createState() => _CustomCardProductState();
}

class _CustomCardProductState extends State<CustomCardProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 8),
        // width: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned(
              top: 0,
              bottom: 100,
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 1,
                  //     blurRadius: 1,
                  //     offset: const Offset(0, 1), // changes position of shadow
                  //   ),
                  // ],
                  borderRadius: BorderRadius.circular(12.0),
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                  image: DecorationImage(
                    image: Platform.isAndroid
                        ? NetworkImage(
                            'http://10.0.2.2:3000/api${widget.product.images[0]}')
                        : NetworkImage(
                            'http://localhost:3000/api${widget.product.images[0]}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                NumberFormat.compactCurrency(
                  //   decimalDigits: 3,
                  locale: 'vi',
                  symbol: '₫',
                  //   decimalDigits: 3,
                ).format(widget.product.price).toString(),
                style: const TextStyle(fontSize: 13, color: Color(0xffC73A1B)),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                // strutStyle: const StrutStyle(fontSize: 12.0),
                text: TextSpan(
                  text: widget.product.title,
                  style: const TextStyle(
                      color: Color(0xff2C406E),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Roboto'),
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Divider(height: 5, color: Colors.grey),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.shopping_cart, color: Colors.orange[500]),
                  Text(
                    'Add to cart',
                    style: TextStyle(fontSize: 16, color: Colors.orange[500]),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
