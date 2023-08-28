import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  List<String> _allergens = [];
  Map<String, String> _nutritionalValues = {};

  final TextEditingController _nutritionalPropertyController =
      TextEditingController();
  final TextEditingController _nutritionalValueController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _qrCodeController.dispose();
    _descriptionController.dispose();
    _imageURLController.dispose();
    _allergenController.dispose();
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
                  TextFormField(
                    controller: _productNameController,
                    decoration: const InputDecoration(
                        hintText: 'Enter product name...'),
                  ),
                  TextFormField(
                    controller: _qrCodeController,
                    decoration:
                        const InputDecoration(hintText: 'Enter QRCode...'),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration:
                        const InputDecoration(hintText: 'Enter description...'),
                  ),
                  TextFormField(
                    controller: _imageURLController,
                    decoration:
                        const InputDecoration(hintText: 'Enter imageURL...'),
                  ),
                  ListView.builder(
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
                          ));
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _allergenController,
                          decoration: const InputDecoration(
                              hintText: 'Enter allergen...'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _allergens.add(_allergenController.text);
                            _allergenController.clear();
                          });
                        },
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _nutritionalValues.keys.length,
                    itemBuilder: (context, index) {
                      String key = _nutritionalValues.keys.elementAt(index);
                      return ListTile(
                          title: Text('$key: ${_nutritionalValues[key]}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _nutritionalValues.remove(key);
                              });
                            },
                          ));
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nutritionalPropertyController,
                          decoration: const InputDecoration(
                              hintText: 'Enter nutritional value property...'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _nutritionalValueController,
                          decoration: const InputDecoration(
                              hintText: 'Enter nutritional value...'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _nutritionalValues[_nutritionalPropertyController
                                .text] = _nutritionalValueController.text;
                            print(_nutritionalValues);
                            _nutritionalPropertyController.clear();
                            _nutritionalValueController.clear();
                          });
                        },
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TextField(
                  //         decoration: const InputDecoration(
                  //             hintText: 'Enter nutritional value property...'),
                  //         onSubmitted: (value) {
                  //           setState(() {
                  //             _nutritionalValues[value] = '';
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: TextField(
                  //         decoration: const InputDecoration(
                  //             hintText: 'Enter nutritional value...'),
                  //         onSubmitted: (value) {
                  //           setState(() {
                  //             _nutritionalValues[_nutritionalValues.keys.last] =
                  //                 value;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        // Do something with the data
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
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
