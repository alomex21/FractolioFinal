import 'package:flutter/material.dart';

import 'package:fractoliotesting/services/auth/auth_service.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _email = TextEditingController();

  @override
  void initState() {
    //_email.dispose();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Enter Email used'),
            TextField(
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autofocus: true,
              controller: _email,
              decoration: const InputDecoration(
                hintText: 'Enter Email here...',
              ),
            ),
            TextButton(
              onPressed: () {
                AuthService.firebase().sendPasswordReset(_email.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Successfully Sent password reset link!'),
                  ),
                );
              },
              child: const Text('Send me a password reset link'),
            )
          ],
        ),
      ),
    );
  }
}
