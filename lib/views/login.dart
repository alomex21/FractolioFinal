import 'package:flutter/material.dart';
import '../constant/routes.dart';
import '../widgets/widgets.dart';

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
      backgroundColor: Colors.grey[300],
      /* appBar: AppBar(
        title: const Text('Login'),
      ), */
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                Text(
                  'Welcome! Please fill the form below to login',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 20),
                /* Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter Email here',
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true),
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ), */

                MyTextField(
                  loginorpassword: _email,
                  autocorrect: false,
                  enableSuggestion: false,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter Email here',
                  obscureText: false,
                ),
                const SizedBox(height: 25),
                MyTextField(
                  loginorpassword: _password,
                  hintText: 'Enter password here',
                  obscureText: true,
                  enableSuggestion: false,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                ),

                /* Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter password here',
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _password,
                  ),
                ), */
                const SizedBox(height: 10),
                //Login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(forgotPassword);
                          },
                          child: Text(
                            'I forgot my password',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          )),
                    ],
                  ),
                ),
                LoginState(
                  email: _email,
                  password: _password,
                  mounted: mounted,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not registered yet?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            registerRoute, (route) => true);
                      },
                      child: const Text('Register here!',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
