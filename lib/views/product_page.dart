import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';
import '../services/services/firestore_service.dart';
import 'product_review.dart';
import 'package:flutter/services.dart';
import 'package:fractoliotesting/services/services/storage_services.dart';

class ProductsDetail extends StatelessWidget {
  ProductsDetail(
      {super.key, required this.productId, required this.firebaseService}) {
    assert(productId != null);
  }

  final dbService = FirestoreService();
  final FirebaseServiceInterface? firebaseService;
  final String? productId;

  Widget buildProductDetail(
      AsyncSnapshot<DocumentSnapshot> snapshot, BuildContext context) {
    final Map<String, dynamic> data =
        snapshot.data?.data() as Map<String, dynamic>;

    List<Map<String, String>> keysAndTitles = [
      {'key': 'product_name', 'title': 'Product Name'},
      {'key': 'description', 'title': 'Description'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(data["product_name"] ?? "Default Product Name"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: keysAndTitles.length + 1, // +1 for the image
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return ImageBuilder(
                      firebaseService: firebaseService, data: data);
                } else {
                  final key = keysAndTitles[index - 1]['key'];
                  final title = keysAndTitles[index - 1]['title'];
                  return BuildListTile(title: title!, value: data[key!] ?? '');
                }
              },
            ),
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: dbService.getProductStream(productId),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('Product not found!');
        }

        final Map<String, dynamic> data =
            snapshot.data?.data() as Map<String, dynamic>;

        List<Map<String, String>> keysAndTitles = [
          {'key': 'product_name', 'title': 'Product Name'},
          {'key': 'description', 'title': 'Description'},
        ];
        return BuildProductDetail(
            data: data,
            keysAndTitles: keysAndTitles,
            firebaseService: firebaseService,
            productId: productId);
      },
    );
  }
}

class BuildProductDetail extends StatelessWidget {
  const BuildProductDetail({
    super.key,
    required this.data,
    required this.keysAndTitles,
    required this.firebaseService,
    required this.productId,
  });

  final Map<String, dynamic> data;
  final FirebaseServiceInterface? firebaseService;
  final List<Map<String, String>> keysAndTitles;
  final String? productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data["product_name"] ?? "Default Product Name"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: keysAndTitles.length + 1, // +1 for the image
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return ImageBuilder(
                      firebaseService: firebaseService, data: data);
                } else {
                  final key2 = keysAndTitles[index - 1]['key'];
                  final title = keysAndTitles[index - 1]['title'];
                  return BuildListTile(
                    title: title!,
                    value: data[key2!] ?? '',
                  );
                }
              },
            ),
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
}

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    super.key,
    required this.firebaseService,
    required this.data,
  });

  final Map<String, dynamic> data;
  final FirebaseServiceInterface? firebaseService;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: firebaseService?.getImageUrl(data["qr_code"] ?? 'default_name'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Image.network(
                    fit: BoxFit.cover,
                    snapshot.data!,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class BuildListTile extends StatelessWidget {
  const BuildListTile({
    super.key,
    required this.title,
    required this.value,
    this.trail,
    this.leading,
  });

  final String title;
  final String? value;
  final Widget? trail;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onLongPress: () {
          _copyToClipboard(context, value);
        },
        child: ListTile(
          leading: leading,
          title: Text(title),
          subtitle: Text(value ?? ""),
          trailing: trail,
        ),
      ),
    );
  }
}

class AllergensWidget extends StatelessWidget {
  const AllergensWidget({super.key, this.allergens, required this.title});

  final List? allergens;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onLongPress: () {
          _copyToClipboard(context, allergens);
        },
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
      ),
    );
  }
}

class NutritionalValues extends StatelessWidget {
  const NutritionalValues(
      {super.key, required this.title, this.nutritionalValues});

  final Map<String, dynamic>? nutritionalValues;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onLongPress: () {
          _copyToClipboard(context, nutritionalValues);
        },
        child: ListTile(
          title: Text(title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: nutritionalValues?.entries.map((entry) {
                  return Column(
                    children: [
                      Text(
                          "-${entry.key.capitalize()}: ${entry.value.toString()}"),
                    ],
                  );
                }).toList() ??
                [],
          ),
        ),
      ),
    );
  }
}

//WIDGETS FUNCTIONALITIES BELOW THIS LINE
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
