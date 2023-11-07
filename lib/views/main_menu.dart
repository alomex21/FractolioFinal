import 'package:flutter/material.dart';
import 'package:fractoliotesting/services/services/firestore_storage.dart';
import 'add_product.dart';
import 'product_page.dart';
import '../widgets/widgets.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  //@override
  //_MainMenuState createState() => _MainMenuState();

/*   late Future<String?> _fullNameFuture;

  @override
  void initState() {
    super.initState();
    _fullNameFuture = _fetchFullName();
  }

  Future<String?> _fetchFullName() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      return data?['username'] as String?;
    } catch (error) {
      print("Error fetching full name: $error");
      return null;
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome, ',
                  style: TextStyle(fontSize: 20),
                ),
                FullnameWidget(textSize: 20),
              ],
            ),
            const SizedBox(height: 50),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductsDetail(
                            productId: 'UqkWbaqGz02xKU4KYpPU',
                            firebaseService: FirebaseService.instance,
                          )));
                },
                child: const Text('Test Product Page')),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProductInfoForm()));
              },
              child: const Text('Add Product to Database'),
            )
          ],
        ),
      ),
    );
  }
}

/* class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      body: Column(
        children: [
          Text('Welcome, $userEmail! '),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProductInfoForm()));
            },
            child: const Text('add product'),
          )
        ],
      ),
    );
  }
} */
