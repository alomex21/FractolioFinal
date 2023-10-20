import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fractoliotesting/dialogs/error_dialog.dart';

import '../../models/addproduct.dart' as product;

class SubmitForm extends StatefulWidget {
  const SubmitForm({
    super.key,
    required GlobalKey<FormState> formkey,
    required TextEditingController productNameController,
    required TextEditingController descriptionController,
    required List<String> allergens,
    required Map<String, String> nutritionalValues,
    required TextEditingController qrCodeController,
    required TextEditingController imageURLController,
    required this.mounted,
    required imageFile,
  })  : _formkey = formkey,
        _productNameController = productNameController,
        _descriptionController = descriptionController,
        _allergens = allergens,
        _nutritionalValues = nutritionalValues,
        _qrCodeController = qrCodeController,
        _imageURLController = imageURLController,
        _imageFile = imageFile;

  final bool mounted;

  final List<String> _allergens;
  final TextEditingController _descriptionController;
  final GlobalKey<FormState> _formkey;
  final File? _imageFile;
  final TextEditingController _imageURLController;
  final Map<String, String> _nutritionalValues;
  final TextEditingController _productNameController;
  final TextEditingController _qrCodeController;

  @override
  State<SubmitForm> createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  Future<String> _uploadImage(String id) async {
    if (widget._imageFile == null) {
      return "";
    }
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('ProductImage').child(id);
    final UploadTask uploadTask = storageRef.putFile(widget._imageFile!);
    final TaskSnapshot downloadUrl = (await uploadTask);
    return await downloadUrl.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (widget._formkey.currentState!.validate()) {
          // Check if any of the fields or lists are empty
          if (widget._productNameController.text.isEmpty ||
              //_qrCodeController.text.isEmpty ||
              widget._descriptionController.text.isEmpty ||
              //_imageURLController.text.isEmpty ||
              widget._allergens.isEmpty ||
              widget._nutritionalValues.isEmpty) {
            showErrorDialog(context, "All fields have to be filled!");
            return; // Exit the function without submitting the data
          }

          product.AddProduct productfinal = product.AddProduct(
              widget._productNameController.text,
              widget._qrCodeController.text,
              widget._descriptionController.text,
              widget._imageURLController.text,
              widget._allergens,
              widget._nutritionalValues);

          CollectionReference products =
              FirebaseFirestore.instance.collection('Products');
          final connectivity = await (Connectivity().checkConnectivity());
          if (connectivity != ConnectivityResult.none) {
            try {
              await products.add(productfinal.toJson()).then(
                (value) async {
                  String idref = value.id;
                  String imageURL = await _uploadImage(idref);
                  await products
                      .doc(idref)
                      .update(
                        {
                          "qr_code": idref,
                          "image_url": imageURL,
                        },
                      )
                      .whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Product Uploaded',
                            ),
                          ),
                        ),
                      )
                      .then((value) {
                        // Clear the fields
                        widget._productNameController.clear();
                        widget._qrCodeController.clear();
                        widget._descriptionController.clear();
                        widget._imageURLController.clear();
                        //_allergenController.clear();
                        //_nutritionalPropertyController.clear();
                        //_nutritionalValueController.clear();
                        setState(() {
                          widget._allergens.clear();
                          widget._nutritionalValues.clear();
                        });
                      });
                },
                onError: (e) => showErrorDialog(
                    context, 'Failed with error "${e.code}": "${e.message}"'),
              );
            } on FirebaseException catch (e) {
              print('Failed with error "${e.code}": "${e.message}"');
            }
          } else {
            if (widget.mounted) {
              showErrorDialog(context, 'No internet access!');
            }
          }
          //TODO: qr_code enter value of your document and from there create qr image and store?

          // Clear the allergens and nutritional values lists
        }
      },
      child: const Text('Submit'),
    );
  }
}
