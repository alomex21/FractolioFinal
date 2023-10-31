import 'package:flutter/material.dart';
import 'package:fractoliotesting/widgets/widgets.dart';

import '../services/auth/auth_service.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //_email.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.grey[300],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset('./lib/images/fractolio_logo.jpg', height: 200),
              const SizedBox(height: 20),
              Text(
                'Enter Email used',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              const SizedBox(height: 20),
              MyTextField(
                  loginorpasswordorusername: _email,
                  hintText: 'Enter Email here',
                  obscureText: false,
                  enableSuggestion: true,
                  autocorrect: false),
              /* TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _email,
                decoration: const InputDecoration(
                  hintText: 'Enter Email here...',
                ),
              ) */
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  AuthService.firebase().sendPasswordReset(_email.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Successfully Sent password reset link!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: const Text('Send me a password reset link',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
