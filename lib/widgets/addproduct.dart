import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? minLines;
  final int? maxLength;
  final bool showCounter;
  final TextAlign textAlign;

  const BuildTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.minLines,
    this.maxLength,
    this.showCounter = true,
    this.textAlign = TextAlign.left,
  });

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
