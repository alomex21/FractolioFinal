import 'package:flutter/material.dart';
import 'package:fractoliotesting/constant/routes.dart';
import 'package:fractoliotesting/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(children: [
        const Text(
            "We've sent you an email verification. Please open it to verify domain"),
        const Text(
            "If you haven't received a verification email yet, press the button below"),
        TextButton(
          onPressed: () async {
            await AuthService.firebase().sendEmailVerification();
          },
          child: const Text('Send email Verification'),
        ),
        TextButton(
          onPressed: () async {
            await AuthService.firebase().logOut();
            if (mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            }
          },
          child: const Text('Restart'),
        )
      ]),
    );
  }
}
