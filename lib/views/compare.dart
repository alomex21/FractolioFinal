// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:permission_handler/permission_handler.dart';

// class _ProductInfoFormState extends State<ProductInfoForm> {
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   final TextEditingController _productNameController = TextEditingController();
//   final TextEditingController _qrCodeController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _allergenController = TextEditingController();
//   List<String> _allergens = [];
//   Map<String, String> _nutritionalValues = {};

//   final TextEditingController _nutritionalPropertyController =
//       TextEditingController();
//   final TextEditingController _nutritionalValueController =
//       TextEditingController();
//   File? imageFile; // To hold the picked image file

//   @override
//   void dispose() {
//     super.dispose();
//     _productNameController.dispose();
//     _qrCodeController.dispose();
//     _descriptionController.dispose();
//     _allergenController.dispose();
//     _nutritionalPropertyController.dispose();
//     _nutritionalValueController.dispose();
//   }

//   Future<String?> uploadImage(File image) async {
//     try {
//       final ref = FirebaseStorage.instance
//           .ref()
//           .child('product_images')
//           .child(DateTime.now().toIso8601String() + '.jpg');
//       await ref.putFile(image);
//       return await ref.getDownloadURL();
//     } catch (e) {
//       print('Upload Failed: $e');
//       return null;
//     }
//   }

//   Future<void> chooseImage() async {
//     final status = await Permission.photos.request();
//     if (status.isGranted) {
//       final pickedFile =
//           await ImagePicker().getImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() {
//           imageFile = File(pickedFile.path);
//         });
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Permission to access photos is denied!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _formkey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // ... [Your other fields]

//                 ElevatedButton(
//                   child: Text("Choose Image"),
//                   onPressed: chooseImage,
//                 ),
//                 if (imageFile != null)
//                   Image.file(
//                     imageFile!,
//                     height: 100, // Adjust as needed
//                     width: 100, // Adjust as needed
//                   ),

//                 // ... [Your other fields and buttons]

//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formkey.currentState!.validate()) {
//                       String? imageUrl;
//                       if (imageFile != null) {
//                         imageUrl = await uploadImage(imageFile!);
//                       }

//                       CollectionReference products =
//                           FirebaseFirestore.instance.collection('Products');
//                       await products.add({
//                         'product_name': _productNameController.text,
//                         'qr_code': _qrCodeController.text,
//                         'description': _descriptionController.text,
//                         'image_url': imageUrl ?? "",
//                         'allergens': _allergens,
//                         'nutritional_values': _nutritionalValues,
//                       });

//                       // Clear fields after submission
//                       _productNameController.clear();
//                       _qrCodeController.clear();
//                       _descriptionController.clear();
//                       _allergenController.clear();
//                       _nutritionalPropertyController.clear();
//                       _nutritionalValueController.clear();
//                       setState(() {
//                         _allergens.clear();
//                         _nutritionalValues.clear();
//                         imageFile = null;
//                       });
//                     }
//                   },
//                   child: Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
