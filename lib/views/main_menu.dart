import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final String assetName = './lib/images/camera.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetName,
              height: 200,
              width: 200,
            ),
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
                          productId: 'fimqsRGRHvCteRpISHye',
                          firebaseService: FirebaseService.instance,
                        )));
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text('Test a Product Page!'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProductInfoForm()));
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87,
                  disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  textStyle: const TextStyle(fontSize: 20),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Add Product to Database!'))
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
