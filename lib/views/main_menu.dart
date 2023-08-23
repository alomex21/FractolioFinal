import 'package:flutter/material.dart';

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
    return const Scaffold(
      body: Center(child: Text('Menuuuu')),
    );
  }
}
