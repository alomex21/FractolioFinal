import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constant/routes.dart';
import 'models/providers/user_provider.dart';
import 'services/auth/auth_service.dart';
import 'views/login.dart';
import 'views/navigator_logic.dart';
import 'views/verify_email_view.dart';

/* void main() {
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
        forgotPassword: (context) => const ForgotPasswordView(),
        addProduct: (context) => const ProductInfoForm()
      },
    ),
  );
} */

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EmailProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(useMaterial3: true),
        home: const HomePage(),
        routes: buildRoutes(),
      ),
    );
  }
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
            return const Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
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
