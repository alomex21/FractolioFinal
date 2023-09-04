import 'package:flutter/material.dart';

class AddProduct {
  final String productName;
  final String qrCode;
  final String description;
  final String imageUrl;
  final List<String> allergens;
  final Map<String, String> nutritionalValues;

  AddProduct(this.productName, this.qrCode, this.description, this.imageUrl,
      this.allergens, this.nutritionalValues);

  Map<String, dynamic> toJson() => {
        'product_name': productName,
        'qr_code': qrCode,
        'description': description,
        'image_url': imageUrl,
        'allergens': allergens,
        'nutritional_values': nutritionalValues,
      };
}
