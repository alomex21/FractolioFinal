import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fractoliotesting/views/navigator_logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  //_LoginPageState createState() => _LoginPageState();

  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

// TODO agregar dispose y controllers a los TextFormfields
class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '', _password = '';

  @override
  Widget build(BuildContext context) {
    return loginPage();
  }

  Scaffold loginPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (String? value) => _email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (String? value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                onSaved: (String? value) => _password = value!,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _signIn,
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: _register,
                child: const Text('Create Account'),
              ),
              TextButton(
                onPressed: _resetPassword,
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final UserCredential userCredential = await _auth
            .signInWithEmailAndPassword(email: _email, password: _password);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Successfully signed in: ${userCredential.user!.email}')),
        );
        Navigator.of(context).pushReplacementNamed(
          '/navigator',
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in: ${e.message}')),
        );
      }
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      try {
        final UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: _email, password: _password);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Successfully registered: ${userCredential.user!.email}')),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register: ${e.message}')),
        );
      }
    }
  }

  Future<void> _resetPassword() async {
    if (_email.isNotEmpty) {
      try {
        await _auth.sendPasswordResetEmail(email: _email);
        if (mounted) {}
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send password reset email')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address')),
      );
    }
  }
}
