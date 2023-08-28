import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

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

  File? imageFile;

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(
                    _productNameController, 'Enter product name...'),
                _buildTextField(_qrCodeController, 'Enter QRCode...'),
                _buildTextField(_descriptionController, 'Enter description...'),
                _buildTextField(_imageURLController, 'Enter imageURL...'),
                _buildAllergenListView(),
                _addAllergenRow(),
                _buildNutritionalListView(),
                _addNutritionalRow(),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
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
          child: _buildTextField(_allergenController, 'Enter allergen...'),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              _allergens.add(_allergenController.text);
              _allergenController.clear();
            });
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
        return ListTile(
          title: Text('$key: ${_nutritionalValues[key]}'),
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
          child: _buildTextField(_nutritionalPropertyController,
              'Enter nutritional value property...'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildTextField(
              _nutritionalValueController, 'Enter nutritional value...'),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              _nutritionalValues[_nutritionalPropertyController.text] =
                  _nutritionalValueController.text;
              _nutritionalPropertyController.clear();
              _nutritionalValueController.clear();
            });
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
      CollectionReference products =
          FirebaseFirestore.instance.collection('Products');
      await products.add({
        'product_name': _productNameController.text,
        'qr_code': _qrCodeController.text,
        'description': _descriptionController.text,
        'image_url': _imageURLController.text,
        'allergens': _allergens,
        'nutritional_values': _nutritionalValues,
      });

      // Clear the fields
      _productNameController.clear();
      _qrCodeController.clear();
      _descriptionController.clear();
      _imageURLController.clear();
      _allergenController.clear();
      _nutritionalPropertyController.clear();
      _nutritionalValueController.clear();

      // Clear the allergens and nutritional values lists
      setState(() {
        _allergens.clear();
        _nutritionalValues.clear();
      });
    }
  }
}
