import 'package:flutter/material.dart';

class ProductReviewPage extends StatelessWidget {
  const ProductReviewPage(
      {super.key, required this.productName, required this.productId});
  final String productName;
  final String? productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(productName),
        ),
        body: null);
  }
}
