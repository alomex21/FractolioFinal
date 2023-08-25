import 'package:flutter/material.dart';
import 'package:fractoliotesting/constant/routes.dart';
import 'package:fractoliotesting/services/auth/auth_service.dart';
import 'package:fractoliotesting/views/change_password.dart';
import 'package:fractoliotesting/views/login.dart';
import 'package:fractoliotesting/views/navigator_logic.dart';
import 'package:fractoliotesting/views/profile_screen.dart';
import 'package:fractoliotesting/views/register_view.dart';
import 'package:fractoliotesting/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        navigator: (context) => const MenuPrincipal(),
        editProfle: (context) => const ProfileScreen(),
        changePassword: (context) => const EditProfile(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const MenuPrincipal();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CircularProgressIndicator(),
              ],
            ); //const CircularProgressIndicator();
        }
      },
    );
  }
}


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light(useMaterial3: true),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const LoginPage(),
//         '/mainmenu': (context) => const MainMenu(),
//         '/profile_screen': (context) => const ProfileScreen(),
//         '/navigator': (context) => const MenuPrincipal(),
//         '/edit_profile': (context) => const EditProfile(),
//       },
//     );
//   }
// }
