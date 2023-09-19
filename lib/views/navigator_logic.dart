import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:fractoliotesting/dialogs/logout_dialog.dart';
import 'package:fractoliotesting/enums/menu_action.dart';
import 'package:fractoliotesting/services/auth/auth_service.dart';
import 'package:fractoliotesting/views/camera_preview_screen.dart';
import 'package:fractoliotesting/views/login.dart';
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

class _MenuPrincipalState extends State<MenuPrincipal> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
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
          LogoutPopUpMenuButton(mounted: mounted)
          // IconButton(
          //   icon: const Icon(Icons.logout),
          //   onPressed: _logout,
          // ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCamera,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  // void _logout() async {
  //   await _auth.signOut();
  //   if (!context.mounted) return;
  //   Navigator.of(context).pushReplacementNamed(
  //     '/',
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('Successfully signed out!'),
  //     ),
  //   );
  // }

  Future<void> _openCamera() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      //final cameras = await availableCameras();
      //final firstCamera = cameras.first;
      if (!context.mounted) return;
      /* Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CameraControllerQR(),

          //CameraPreviewScreen(camera: firstCamera)
        ),
      ); */
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CameraControllerQR()),
      );
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission is not granted')),
      );
    }
  }
}

class LogoutPopUpMenuButton extends StatelessWidget {
  const LogoutPopUpMenuButton({
    super.key,
    required this.mounted,
  });

  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (value) async {
        switch (value) {
          case MenuAction.logout:
            final shouldlogout = await showLogOutDialog(context);
            if (shouldlogout) {
              await AuthService.firebase().logOut();

              if (mounted) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                    (route) => false);
                //Navigator.of(context)
                //    .pushNamedAndRemoveUntil(loginRoute, (_) => false);
              }
            }
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text('Log out'),
          )
        ];
      },
    );
  }
}
