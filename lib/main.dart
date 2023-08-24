import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fractoliotesting/firebase_options.dart';
import 'package:fractoliotesting/views/change_password.dart';
import 'package:fractoliotesting/views/login.dart';
import 'package:fractoliotesting/views/main_menu.dart';
import 'package:fractoliotesting/views/navigator_logic.dart';
import 'package:fractoliotesting/views/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/mainmenu': (context) => const MainMenu(),
        '/profile_screen': (context) => const ProfileScreen(),
        '/navigator': (context) => const MenuPrincipal(),
        '/edit_profile': (context) => const EditProfile(),
      },
    );
  }
}
