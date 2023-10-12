import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fractoliotesting/views/product_review.dart';

class ProductsDetail extends StatelessWidget {
  const ProductsDetail({Key? key, required this.productId}) : super(key: key);
  final String? productId;

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

  Stream<DocumentSnapshot> getProductStream() {
    return FirebaseFirestore.instance
        .collection('Products')
        .doc(productId ?? '0R2bSVi2Dy6NmME4i3kN')
        .snapshots();
  }

  Widget buildProductDetail(
      AsyncSnapshot<DocumentSnapshot> snapshot, BuildContext context) {
    final Map<String, dynamic> data =
        snapshot.data!.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(data["product_name"] ?? "Default Product Name"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BuildListTile(title: 'Product Name', value: data["product_name"]),
            BuildListTile(title: 'Description', value: data["description"]),
            BuildListTile(title: 'Image URL', value: data["image_url"]),
            ListTile(
              title: const Text('Allergens'),
              subtitle: buildAllergens(data["allergens"]),
            ),
            ListTile(
              title: const Text('Nutritional Values'),
              subtitle: buildNutritionalValues(
                data["nutritional_values"],
              ),
            ),
            TextbuttonReview(data: data, productId: productId),
            TextbuttonReviewtwo(data: data, qrCodeString: productId),
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
}

class TextbuttonReview extends StatelessWidget {
  const TextbuttonReview({
    super.key,
    required this.data,
    required this.productId,
  });

  final Map<String, dynamic> data;
  final String? productId;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => ProductReviewPage(
                    productName: data["product_name"],
                    productId: productId,
                  ))));
        },
        child: const Text('View Reviews'));
  }
}

class TextbuttonReviewtwo extends StatelessWidget {
  const TextbuttonReviewtwo({
    super.key,
    required this.qrCodeString,
    required this.data,
  });

  final String? qrCodeString;
  final Map<String, dynamic> data;

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
        child: const Text('View Reviews2'));
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
    return ListTile(
      title: Text(title),
      subtitle: Text(value ?? ""),
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
