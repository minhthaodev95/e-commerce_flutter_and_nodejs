import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_ecommerce_app/src/models/product_model.dart';
import 'package:intl/intl.dart';

class CardProductSearch extends StatefulWidget {
  const CardProductSearch({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  _CardProductSearchState createState() => _CardProductSearchState();
}

class _CardProductSearchState extends State<CardProductSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 6.0),
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
      child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('title tapped');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          // strutStyle: const StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                            text: widget.product.title,
                            style: const TextStyle(
                                color: Color(0xff2C406E),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          NumberFormat.currency(
                            //   decimalDigits: 3,
                            locale: 'vi',
                            symbol: '₫',
                            //   decimalDigits: 3,
                          ).format(widget.product.price).toString(),
                          style: const TextStyle(
                              fontSize: 14, color: Color(0xffC73A1B)),
                        ),
                        const SizedBox(width: 8),
                        const Text('-'),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            print('name field tapped');
                          },
                          child: Text(widget.product.user.name,
                              style: const TextStyle(
                                  fontSize: 14, color: Color(0xff59A781))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('favorite tapped');
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Icon(Icons.favorite_border, color: Colors.red[500]),
              ),
            ),
          ]),
    );
  }
}
