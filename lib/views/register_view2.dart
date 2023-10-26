import 'package:flutter/material.dart';
import '../constant/routes.dart';
import '../widgets/widgets.dart';

class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({super.key});

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      /* appBar: AppBar(
        title: const Text('Login'),
      ), */
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Image.asset('./lib/images/fractolio_logo.jpg', height: 200),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Please fill the form below to Register',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 20),
                //ENTER USERNAME
                MyTextField(
                    loginorpasswordorusername: _username,
                    hintText: 'Enter Username',
                    obscureText: false,
                    enableSuggestion: true,
                    autocorrect: true),

                const SizedBox(height: 10),

                //ENTER EMAIL
                MyTextField(
                  loginorpasswordorusername: _email,
                  autocorrect: false,
                  enableSuggestion: false,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter Email here',
                  obscureText: false,
                ),
                //ENTER PASSWORD
                const SizedBox(height: 10),
                MyTextField(
                  loginorpasswordorusername: _password,
                  hintText: 'Enter password here',
                  obscureText: true,
                  enableSuggestion: false,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 10),
                //Login
                RegisterState(
                  username: _username,
                  email: _email,
                  password: _password,
                  mounted: mounted,
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    //navigate to VerifyEmailView
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute,
                      (route) => false,
                    );
                  },
                  child: const Text('verifyemaildebug'),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute, (route) => false);
                      },
                      child: const Text(
                        'Login Here!',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
