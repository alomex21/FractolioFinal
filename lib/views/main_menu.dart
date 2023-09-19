import 'package:flutter/material.dart';
import 'package:fractoliotesting/views/add_product.dart';
import 'package:fractoliotesting/views/product_page.dart';
import 'package:fractoliotesting/widgets/widgets.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

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
      body: Column(
        children: [
/*           FutureBuilder<String?>(
            future: _fullNameFuture,
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data != null) {
                return Text('Welcome, ${snapshot.data}!');
              } else {
                return const Text('Welcome!');
              }
            },
          ), */
          FullnameWidget(),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProductsDetail(
                        productId: '0R2bSVi2Dy6NmME4i3kN')));
              },
              child: const Text('Test Product Page')),
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

  //@override
  //_MainMenuState createState() => _MainMenuState();
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
