import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.minLines,
    this.maxLength,
    this.showCounter = true,
    this.textAlign = TextAlign.left,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final int? maxLength;
  final int? minLines;
  final bool showCounter;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: null,
        minLines: minLines ?? 1,
        maxLength: maxLength,
        controller: controller,
        textAlign: textAlign,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: hintText,
          counterText: showCounter ? null : '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage(
      {super.key, required this.productId, required this.imagePath});

  final String imagePath;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
