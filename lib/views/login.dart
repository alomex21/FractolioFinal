import 'package:flutter/material.dart';
import 'package:fractoliotesting/constant/routes.dart';
import 'package:fractoliotesting/widgets/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Enter Email here'),
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Enter password here'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: _password,
            ),
            //Login
            LoginState(
              email: _email,
              password: _password,
              mounted: mounted,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => true);
              },
              child: const Text('Not registered yet? Register here!'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(forgotPassword);
                },
                child: const Text('I forgot my password')),
          ],
        ),
      ),
    );
  }
}























// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:fractoliotesting/views/navigator_logic.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   //_LoginPageState createState() => _LoginPageState();

//   State<LoginPage> createState() {
//     return _LoginPageState();
//   }
// }

// // TODO agregar dispose y controllers a los TextFormfields
// class _LoginPageState extends State<LoginPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   String _email = '', _password = '';
//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return loginPage();
//   }

//   Scaffold loginPage() {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login Page'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (String? value) {
//                   if (value == null || value.isEmpty || !value.contains('@')) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//                 onSaved: (String? value) => _email = value!,
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 controller: _passwordController,
//                 validator: (String? value) {
//                   if (value == null || value.isEmpty || value.length < 6) {
//                     return 'Password must be at least 6 characters long';
//                   }
//                   return null;
//                 },
//                 onSaved: (String? value) => _password = value!,
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _signIn,
//                 child: const Text('Login'),
//               ),
//               TextButton(
//                 onPressed: _register,
//                 child: const Text('Create Account'),
//               ),
//               TextButton(
//                 onPressed: _resetPassword,
//                 child: const Text('Forgot Password?'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _signIn() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       try {
//         final UserCredential userCredential = await _auth
//             .signInWithEmailAndPassword(email: _email, password: _password);
//         if (!context.mounted) return;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(
//                   'Successfully signed in: ${userCredential.user!.email}')),
//         );
//         Navigator.of(context).pushReplacementNamed(
//           '/navigator',
//         );
//       } on FirebaseAuthException catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to sign in: ${e.message}')),
//         );
//       }
//     }
//   }

//   Future<void> _register() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState?.save();
//       try {
//         final UserCredential userCredential = await _auth
//             .createUserWithEmailAndPassword(email: _email, password: _password);
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//                 content: Text(
//                     'Successfully registered: ${userCredential.user!.email}')),
//           );
//         }
//       } on FirebaseAuthException catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to register: ${e.message}')),
//         );
//       }
//     }
//   }

//   Future<void> _resetPassword() async {
//     if (_email.isNotEmpty) {
//       try {
//         await _auth.sendPasswordResetEmail(email: _email);
//         if (mounted) {}
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Password reset email sent')),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to send password reset email')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter your email address')),
//       );
//     }
//   }
// }
