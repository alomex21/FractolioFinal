import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'product_review.dart';
import 'package:flutter/services.dart';

class ProductsDetail extends StatelessWidget {
  ProductsDetail({Key? key, required this.productId}) : super(key: key) {
    assert(productId != null);
  }

  final String? productId;

  Stream<DocumentSnapshot> getProductStream() {
    return FirebaseFirestore.instance
        .collection('Products')
        .doc(productId ?? '0R2bSVi2Dy6NmME4i3kN')
        .snapshots();
  }

  Widget buildProductDetail(
      AsyncSnapshot<DocumentSnapshot> snapshot, BuildContext context) {
    final Map<String, dynamic> data =
        snapshot.data?.data() as Map<String, dynamic> ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text(data["product_name"] ?? "Default Product Name"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BuildListTile(
                title: 'Product Name', value: data["product_name"] ?? ''),
            BuildListTile(
                title: 'Description', value: data["description"] ?? ''),
            BuildListTile(title: 'Image URL', value: data["image_url"] ?? ''),
            AllergensWidget(
                title: "Allergens", allergens: data["allergens"] ?? ''),
            NutritionalValues(
                title: "Nutritional Values",
                nutritionalValues: data["nutritional_values"] ?? ''),
            TextbuttonReview(data: data, qrCodeString: productId),
          ],
        ),
      ),
    );
  }

  Widget buildNutritionalValues(Map<String, dynamic>? nutritionalValues) {
    return Row(
      children: nutritionalValues?.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                children: [
                  Text("${entry.key}: ${entry.value.toString()}"),
                ],
              ),
            );
          }).toList() ??
          [],
    );
  }

  Widget buildAllergens(List? allergens) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: allergens?.map((allergen) {
            return Text(allergen.toString());
          }).toList() ??
          [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: getProductStream(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('Product not found');
        }

        return buildProductDetail(snapshot, context);
      },
    );
  }
}

class AllergensWidget extends StatelessWidget {
  final String title;
  final List? allergens;
  const AllergensWidget({super.key, this.allergens, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: allergens?.map((allergen) {
                return Text(allergen.toString());
              }).toList() ??
              [],
        ),
      ),
    );
  }
}

class NutritionalValues extends StatelessWidget {
  final String title;
  final Map<String, dynamic>? nutritionalValues;
  const NutritionalValues(
      {super.key, required this.title, this.nutritionalValues});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        _copyToClipboard(context, nutritionalValues);
      },
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: nutritionalValues?.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      Text(
                          "-${entry.key.capitalize()}: ${entry.value.toString()}"),
                    ],
                  ),
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}

class TextbuttonReview extends StatelessWidget {
  const TextbuttonReview({
    super.key,
    required this.qrCodeString,
    required this.data,
  });

  final Map<String, dynamic> data;
  final String? qrCodeString;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => ProductReviewPageTwo(
                    qrCodeString: qrCodeString,
                    productName: data["product_name"],
                  ))));
        },
        child: const Text('View Reviews'));
  }
}

class BuildListTile extends StatelessWidget {
  const BuildListTile({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        _copyToClipboard(context, value);
      },
      child: ListTile(
        title: Text(title),
        subtitle: Text(value ?? ""),
      ),
    );
  }
}

void _copyToClipboard(BuildContext context, dynamic value) {
  if (value != null) {
    String stringValue;

    if (value is Map) {
      stringValue = value.entries.map((entry) {
        return '${entry.key}: ${entry.value}';
      }).join('\n'); // convert map to string
    } else {
      stringValue =
          value.toString(); // For other types like String, int, double etc.
    }

    Clipboard.setData(ClipboardData(text: stringValue));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }
}



/*
 class ProductPage extends StatefulWidget {
  final String? qrCodeResult;

  const ProductPage({super.key, required this.qrCodeResult});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late DocumentSnapshot? productData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    DocumentReference productRef = FirebaseFirestore.instance
        .collection('products')
        .doc(widget.qrCodeResult);
    DocumentSnapshot data = await productRef.get();

    setState(() {
      productData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    /* if (productData == null) {
      return  const CircularProgressIndicator(); // Show a loading spinner until data is fetched
    } */
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text('Test: ')],
        ),
      ),
    );
    // ... Build your UI using productData.data()
  }
} */

/* class ProductsDetail extends StatelessWidget {
  const ProductsDetail({super.key, required this.productId});
  final String? productId;

  @override
  Widget build(BuildContext context) {
    const productIdtest = '0R2bSVi2Dy6NmME4i3kN';
    final Stream<DocumentSnapshot> productStream = FirebaseFirestore.instance
        .collection('Products')
        .doc(productIdtest)
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: productStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('Product not found');
        }
        //llega la data aca!
        //Map<String, dynamic> dataMap =
        snapshot.data!.data() as Map<String, dynamic>;
        //List<MapEntry<String, dynamic>> fields = dataMap.entries.toList();

        return Scaffold(
          appBar: AppBar(
            title:
                Text(snapshot.data!["product_name"] ?? "Default Product Name"),
          ),
          body: ListView(
            children: [
              ListTile(
                title: const Text('Product Name'),
                subtitle: Text(snapshot.data!["product_name"] ?? ""),
              ),
              ListTile(
                title: const Text('Description'),
                subtitle: Text(snapshot.data!["description"] ?? ""),
              ),
              ListTile(
                title: const Text('Image URL'),
                subtitle: Text(snapshot.data!["image_url"] ?? ""),
              ),
              ListTile(
                title: const Text('Nutritional Values'),
                subtitle: Row(
                  children: (snapshot.data!["nutritional_values"]
                              as Map<String, dynamic>?)
                          ?.entries
                          .map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            children: [
                              Text("${entry.key}: ${entry.value.toString()}"),
                              //Text(entry.value.toString()),
                            ],
                          ),
                        );
                      }).toList() ??
                      [],
                ),
              ),
              ListTile(
                title: const Text('Allergens'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      (snapshot.data!["allergens"] as List?)?.map((allergen) {
                            return Text(allergen.toString());
                          }).toList() ??
                          [],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
 */
