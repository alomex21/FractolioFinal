import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fractoliotesting/dialogs/error_dialog.dart';
import 'package:fractoliotesting/models/addproduct.dart' as product;
import 'package:connectivity_plus/connectivity_plus.dart';

class ProductInfoForm extends StatefulWidget {
  const ProductInfoForm({super.key});

  @override
  State<ProductInfoForm> createState() => _ProductInfoFormState();
}

class _ProductInfoFormState extends State<ProductInfoForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _qrCodeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();
  final TextEditingController _allergenController = TextEditingController();
  final TextEditingController _nutritionalPropertyController =
      TextEditingController();
  final TextEditingController _nutritionalValueController =
      TextEditingController();

  final List<String> _allergens = [];
  final Map<String, String> _nutritionalValues = {};

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
                _buildTextField(
                  _productNameController,
                  'Enter product name...',
                  textAlign: TextAlign.center,
                ),
                _buildTextField(
                  _qrCodeController,
                  'Enter QRCode...',
                ),
                _buildTextField(
                  _descriptionController,
                  'Enter description...',
                  minLines: 1,
                  showCounter: true,
                  maxLength: 500,
                ),
                _buildTextField(
                  _imageURLController,
                  'Enter imageURL...',
                ),
                _buildAllergenListView(),
                _addAllergenRow(),
                _buildNutritionalListView(),
                _addNutritionalRow(),
                const Divider(),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    int? minLines,
    int? maxLength,
    bool showCounter = true,
    TextAlign textAlign = TextAlign.left,
  }) {
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

  Widget _buildAllergenListView() {
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
          child: _buildTextField(_allergenController, 'Enter allergen...',
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
  }

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
          child: _buildTextField(
              _nutritionalPropertyController, 'Nutritional property'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child:
              _buildTextField(_nutritionalValueController, 'Nutritional value'),
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
                    _allergenController.clear();
                    _nutritionalPropertyController.clear();
                    _nutritionalValueController.clear();
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

      //TODO: qr_code ingresar valor de su documento y de ahi crear imagen de qr y almacenar?

      // Clear the allergens and nutritional values lists
    }
  }
}
