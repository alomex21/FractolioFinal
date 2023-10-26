import 'package:flutter/material.dart';
import 'package:timer_button/timer_button.dart';
import '../constant/routes.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Check your email!'),
        backgroundColor: Colors.grey[300],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.mark_email_read, size: 200),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "We've sent you an email verification. Please open it to verify domain",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                      "If you haven't received a verification email yet, press the button below",
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextButton(
                      onPressed: () async {
                        //TODO:AWAIT APAGADO
                        //await AuthService.firebase().sendEmailVerification();
                      },
                      child: TimerButton(
                        buttonType: ButtonType.textButton,
                        label: 'Resend Send email Verification',
                        onPressed: () {},
                        timeOutInSeconds: 20,
                        activeTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        disabledTextStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        color: Colors.black,
                        disabledColor: Colors.black,
                      )
                      /* const Text('Resend Send email Verification',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)) */
                      ,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //TODO AWAIT APAGADO
                      //await AuthService.firebase().logOut();
                      if (context.mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          registerRoute2,
                          (route) => false,
                        );
                      }
                    },
                    child: const Text('Go back to the Registration Page',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
