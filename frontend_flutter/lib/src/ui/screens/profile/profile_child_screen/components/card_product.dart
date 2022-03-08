import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_ecommerce_app/src/models/product_model.dart';
import 'package:intl/intl.dart';

class CardProduct extends StatefulWidget {
  const CardProduct({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  _CardProductState createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 2),
        Card(
          margin: const EdgeInsets.all(0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            // isThreeLine: true,
            leading: ClipOval(
              child: Platform.isAndroid
                  ? Image.network(
                      'http://10.0.2.2:3000/api${widget.product.images[0]}',
                      fit: BoxFit.cover)
                  : Image.network(
                      'http://localhost:3000/api${widget.product.images[0]}',
                      fit: BoxFit.cover),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                strutStyle: const StrutStyle(fontSize: 16.0),
                text: TextSpan(
                  text: widget.product.title,
                  style: const TextStyle(
                      color: Color(0xff2C406E),
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      fontFamily: 'Roboto'),
                ),
              ),
            ),
            subtitle: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: const StrutStyle(fontSize: 12.0),
              text: TextSpan(
                text: widget.product.description,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: 'Roboto'),
              ),
            ),
            trailing: Text(
                NumberFormat.compactCurrency(
                  //   decimalDigits: 3,
                  locale: 'vi',
                  symbol: '₫',

                  //   decimalDigits: 3,
                ).format(widget.product.price).toString(),
                style: TextStyle(color: Colors.orange[500])),
          ),
        ),
      ],
    );
  }
}
