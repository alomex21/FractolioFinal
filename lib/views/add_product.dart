import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fractoliotesting/widgets/controllers/submit_form.dart';
import 'package:image_picker/image_picker.dart';
import '../dialogs/error_dialog.dart';
import '../widgets/addproduct.dart';
import '../widgets/controllers/allergen_widget.dart';

class ProductInfoForm extends StatefulWidget {
  const ProductInfoForm({super.key});

  @override
  State<ProductInfoForm> createState() => _ProductInfoFormState();
}

class _ProductInfoFormState extends State<ProductInfoForm> {
  final TextEditingController _allergenController = TextEditingController();
  final List<String> _allergens = [];
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _imageURLController = TextEditingController();
  final TextEditingController _nutritionalPropertyController =
      TextEditingController();

  final TextEditingController _nutritionalValueController =
      TextEditingController();

  final Map<String, String> _nutritionalValues = {};
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _qrCodeController = TextEditingController();
  ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _qrCodeController.dispose();
    _descriptionController.dispose();
    _imageURLController.dispose();
    _allergenController.dispose();
    _nutritionalPropertyController.dispose();
    _nutritionalValueController.dispose();
  }

/*   Widget _buildAllergenListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _allergens.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_allergens[index]),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _allergens.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  Widget _addAllergenRow() {
    return Row(
      children: [
        Expanded(
          child: BuildTextField(
              controller: _allergenController,
              hintText: 'Enter allergen...',
              textAlign: TextAlign.center),
        ),
        FloatingActionButton.small(
          backgroundColor: Colors.orange,
          heroTag: "fab2",
          elevation: 3,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            if (_allergenController.text.trim().isNotEmpty) {
              setState(() {
                _allergens.add(_allergenController.text);
                _allergenController.clear();
              });
            } else {
              showErrorDialog(context, "Add Allergens first");
            }
          },
        ),
      ],
    );
  } */

  Widget _buildNutritionalListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _nutritionalValues.keys.length,
      itemBuilder: (context, index) {
        String key = _nutritionalValues.keys.elementAt(index);
        int keyLength = index + 1;
        return ListTile(
          title: Text('$keyLength. $key: ${_nutritionalValues[key]}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _nutritionalValues.remove(key);
              });
            },
          ),
        );
      },
    );
  }

  Widget _addNutritionalRow() {
    return Row(
      children: [
        Expanded(
          child: BuildTextField(
              controller: _nutritionalPropertyController,
              hintText: 'Nutritional property'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: BuildTextField(
            controller: _nutritionalValueController,
            hintText: 'Nutritional value',
            keyboardType: const TextInputType.numberWithOptions(
                signed: false, decimal: true),
            //TODO: MAKE SURE IT ONLY ACCEPT POSITIVE INTEGERS WITH TWO DECIMAL
          ),
        ),
        FloatingActionButton.small(
          backgroundColor: Colors.orange,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            if (_nutritionalPropertyController.text.trim().isNotEmpty &&
                _nutritionalValueController.text.trim().isNotEmpty) {
              setState(
                () {
                  //TODO: int value = int.parse(_nutritionalValueController.text);
                  //https://dart.dev/language/collections#maps
                  //Adds a nutritional property(calories)
                  _nutritionalValues[_nutritionalPropertyController.text] =
                      _nutritionalValueController.text;
                  _nutritionalPropertyController.clear();
                  _nutritionalValueController.clear();
                },
              );
            } else {
              showErrorDialog(context,
                  "You need atleast one nutritional property and value");
            }
          },
        ),
      ],
    );
  }

/*
  Widget _submitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      child: const Text('Submit'),
    );
  }

  void _submitForm() async {
    if (_formkey.currentState!.validate()) {
      // Check if any of the fields or lists are empty
      if (_productNameController.text.isEmpty ||
          //_qrCodeController.text.isEmpty ||
          _descriptionController.text.isEmpty ||
          //_imageURLController.text.isEmpty ||
          _allergens.isEmpty ||
          _nutritionalValues.isEmpty) {
        showErrorDialog(context, "All fields have to be filled!");
        return; // Exit the function without submitting the data
      }

      product.AddProduct productfinal = product.AddProduct(
          _productNameController.text,
          _qrCodeController.text,
          _descriptionController.text,
          _imageURLController.text,
          _allergens,
          _nutritionalValues);

      CollectionReference products =
          FirebaseFirestore.instance.collection('Products');
      final connectivity = await (Connectivity().checkConnectivity());
      if (connectivity != ConnectivityResult.none) {
        try {
          await products.add(productfinal.toJson()).then(
            (value) {
              String idref = value.id;
              products
                  .doc(idref)
                  .update(
                    {
                      "qr_code": idref,
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
                    _productNameController.clear();
                    _qrCodeController.clear();
                    _descriptionController.clear();
                    _imageURLController.clear();
                    //_allergenController.clear();
                    //_nutritionalPropertyController.clear();
                    //_nutritionalValueController.clear();
                    setState(() {
                      _allergens.clear();
                      _nutritionalValues.clear();
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
        if (mounted) {
          showErrorDialog(context, 'No internet access!');
        }
      }
      //TODO: qr_code enter value of your document and from there create qr image and store?

      // Clear the allergens and nutritional values lists
    }
  }
 */
  File? _imageFile;
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    //print('${pickedFile?.path}');
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Divider(),
                IconButton(
                    onPressed: (() => _pickImage()),
                    icon: const Icon(Icons.add_a_photo_outlined)),
                BuildTextField(
                    controller: _imageURLController,
                    hintText: 'Enter imageURL...'),
                BuildTextField(
                  controller: _productNameController,
                  hintText: 'Enter product name...',
                  textAlign: TextAlign.center,
                ),
                BuildTextField(
                    controller: _qrCodeController, hintText: 'Enter QRCode'),
                BuildTextField(
                  controller: _descriptionController,
                  hintText: 'Enter description',
                  minLines: 1,
                  showCounter: true,
                  maxLength: 500,
                ),
                AllergenListView(
                    allergens: _allergens,
                    onRemoveAllergen: (index) {
                      setState(() {
                        _allergens.removeAt(index);
                      });
                    }),
                //_buildAllergenListView(),
                AllergenRow(
                    controller: _allergenController,
                    onAddAllergen: (allergen) {
                      setState(() {
                        _allergens.add(allergen);
                        _allergenController.clear();
                      });
                    }),
                //_addAllergenRow(),
                _buildNutritionalListView(),
                _addNutritionalRow(),
                const Divider(),
                SubmitForm(
                    formkey: _formkey,
                    productNameController: _productNameController,
                    descriptionController: _descriptionController,
                    allergens: _allergens,
                    nutritionalValues: _nutritionalValues,
                    qrCodeController: _qrCodeController,
                    imageURLController: _imageURLController,
                    mounted: mounted,
                    imageFile: _imageFile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
