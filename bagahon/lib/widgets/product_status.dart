import 'package:flutter/material.dart';

class ProductStatus extends StatelessWidget {
  final double price;
  final int stock;
  final double? fontSize;

  const ProductStatus({
    Key? key,
    required this.price,
    required this.stock,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (stock <= 0) {
      return Text(
        'Out of Stock',
        style: TextStyle(
          fontSize: fontSize ?? 16,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      );
    } else {
      return Text(
        '₱${price.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: fontSize ?? 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    }
  }
}
