import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fractoliotesting/dialogs/error_dialog.dart';
import 'package:fractoliotesting/views/add_product.dart';
import 'package:fractoliotesting/widgets/controllers/submitprovider.dart';

import 'package:provider/provider.dart';

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
    this.qrImageFile,
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
  final File? qrImageFile;
  @override
  State<SubmitForm> createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  void reloadEntireView() {
    Navigator.of(context).pop(); // Pop the current view
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) =>
            const ProductInfoForm(), // Replace YourWidget with the actual widget you want to reload
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        /*
        Check if the form is valid
         */
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

          /*

          This is the AddProduct class from lib/models/addproduct.dart

          class AddProduct {
            AddProduct(this.productName, this.qrCode, this.description, this.imageUrl,
              this.allergens, this.nutritionalValues);

            final List<String> allergens;
            final String description;
            final String imageUrl;
            final Map<String, String> nutritionalValues;
            final String productName;
            final String qrCode;

          Map<String, dynamic> toJson() => {
                'product_name': productName,
                'qr_code': qrCode,
                'description': description,
                'image_url': imageUrl,
                'allergens': allergens,
                'nutritional_values': nutritionalValues,
              };
            }
           */
          product.AddProduct productfinal = product.AddProduct(
              widget._productNameController.text,
              widget._qrCodeController.text,
              widget._descriptionController.text,
              widget._imageURLController.text,
              widget._allergens,
              widget._nutritionalValues);

          /*
          This is the CollectionReference from Firebase Firestore for the Products collection
          */
          CollectionReference products =
              FirebaseFirestore.instance.collection('Products');
          /*
          Check if there is internet access
          */
          final connectivity = await (Connectivity().checkConnectivity());
          /*
          If there is internet access, then add the product to Firebase Firestore
          */
          if (connectivity != ConnectivityResult.none) {
            try {
              await products.add(productfinal.toJson()).then(
                (value) async {
                  /*
                  This step is to generate the QR code image and upload it to Firebase Storage
                  Also it creates a product and uploads it to Firebase Firestore
                  REFERENCES:
                  idref is the document autogenerated id of the product.
                  qrImageURL is the download URL of the QR code image.
                  imageURL is the download URL of the product image.
                  all these 3 are stored in the product document in Firestore as an update...
                  since all these 3 are generated after the product is created to obtain the autogenerated id
                   */
                  String idref = value.id;

                  // final qrImageURL =
                  //     await generateAndUploadQRCode(idref, idref);
                  // String imageURL = await _uploadImage(idref);

                  final imageProvider =
                      Provider.of<SubmitProvider>(context, listen: false);

                  String imageURL =
                      ""; // Default value if there's no image to upload
                  String qrImageURL =
                      ""; // Default value if there's no QR code image to upload

                  // Check if qrImageFile is not null, then upload and get the URL

                  qrImageURL =
                      await imageProvider.generateAndUploadQRCode(idref, idref);

                  print("qrImageURL======>>>$qrImageURL");

                  // Check if _imageFile is not null, then upload and get the URL
                  if (widget._imageFile != null) {
                    imageURL = await imageProvider.uploadImage(
                        idref, widget._imageFile!);
                  } else {
                    print("no product image");
                  }
                  await products
                      .doc(idref)
                      .update(
                        {
                          "qr_code": idref,
                          "image_url": imageURL,
                          "qr_code_image": qrImageURL,
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
                      .then(
                        (value) {
                          Future.delayed(
                            const Duration(milliseconds: 1500),
                            () {
                              widget._productNameController.clear();
                              widget._qrCodeController.clear();
                              widget._descriptionController.clear();
                              widget._imageURLController.clear();
                              widget._nutritionalValues.clear();
                              widget._allergens.clear();
                              reloadEntireView();
                            },
                          );
                          // Clear the fields
                        },
                      );
                },
                onError: (e) => showErrorDialog(
                    context, 'Failed with error "${e.code}": "${e.message}"'),
              );
            } on FirebaseException catch (e) {
              AlertDialog(
                title: const Text('Error'),
                content:
                    Text('Failed with error "${e.code}": "${e.message}",)'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'))
                ],
              );
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




 /*
  _uploadImage
  This function uploads the image of a product to Firebase Storage and returns the download URL
  */
//   Future<String> _uploadImage(String id) async {
//     if (widget._imageFile == null) {
//       return "";
//     }
//     final Reference storageRef =
//         FirebaseStorage.instance.ref().child('ProductImage').child(id);
//     final UploadTask uploadTask = storageRef.putFile(widget._imageFile!);
//     final TaskSnapshot downloadUrl = (await uploadTask);
//     return await downloadUrl.ref.getDownloadURL();
//   }

//   /*
//   generateAndUploadQRCode
//   This function generates the QR code image and uploads it to Firebase Storage and returns the QR image's URL
//  */
//   Future<String> generateAndUploadQRCode(String content, String idref) async {
//     try {
//       // Generate the QR code
//       final qrValidationResult = QrValidator.validate(
//         data: content,
//         version: QrVersions.auto,
//         errorCorrectionLevel: QrErrorCorrectLevel.L,
//       );

//       if (qrValidationResult.status == QrValidationStatus.error) {
//         throw Exception(qrValidationResult.error);
//       }

//       final qrCode = qrValidationResult.qrCode;

//       // Convert to image
//       final painter = QrPainter.withQr(
//         qr: qrCode!,
//         gapless: false,
//         embeddedImageStyle: null,
//         embeddedImage: null,
//       );

//       final picData = await painter.toImageData(2048);
//       if (picData == null) {
//         throw Exception('Unable to convert QR code to image data.');
//       }

//       final bytes = picData.buffer.asUint8List();

//       // Save the QR code image as a file
//       final tempDir = await getTemporaryDirectory();
//       final file = await File('${tempDir.path}/$idref.png').create();
//       await file.writeAsBytes(bytes);

//       // Upload to Firebase Storage
//       final storageRef =
//           FirebaseStorage.instance.ref().child('qr_images/$idref.png');
//       await storageRef.putFile(file);

//       // Get the download URL
//       final qrImageURL = await storageRef.getDownloadURL();

//       // Delete the temporary file
//       await file.delete();

//       return qrImageURL;
//     } catch (e) {
//       // Handle exceptions
//       //print(e);
//       rethrow;
//     }
//   }
