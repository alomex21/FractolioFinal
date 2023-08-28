import 'package:flutter/material.dart';
import 'package:fractoliotesting/constant/routes.dart';
import 'package:fractoliotesting/views/add_product.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainMenuState();
  }

  //@override
  //_MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('test'),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(addProduct);
            },
            child: const Text('add product'),
          )
        ],
      ),
    );
  }
}
