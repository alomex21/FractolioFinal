import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fractoliotesting/views/camera_preview_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'main_menu.dart';
import 'profile_screen.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  // @override
  // State<MenuPrincipal> createState() => _MenuPrincipalState();

  @override
  State<StatefulWidget> createState() {
    return _MenuPrincipalState();
  }
}

enum BodyPage { homePage, detailsPage, profileScreen }

class _MenuPrincipalState extends State<MenuPrincipal> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final screens = const
  final List<Widget> screens = [
    const MainMenu(),
    const ProfileScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCamera,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  void _logout() async {
    await _auth.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushReplacementNamed(
      '/',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully signed out!'),
      ),
    );
  }

  Future<void> _openCamera() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      if (!context.mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CameraPreviewScreen(camera: firstCamera),
        ),
      );
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission is not granted')),
      );
    }
  }
}
