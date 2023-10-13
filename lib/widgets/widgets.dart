import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fractoliotesting/constant/routes.dart';
import 'package:fractoliotesting/dialogs/error_dialog.dart';
import 'package:fractoliotesting/models/user.dart' as model;
import 'package:fractoliotesting/services/auth/auth_exceptions.dart';
import 'package:fractoliotesting/services/auth/auth_service.dart';
import 'package:string_capitalize/string_capitalize.dart';

//BOTON PERFIL
class BotonPerfil extends StatelessWidget {
  const BotonPerfil({
    super.key,
    required this.text,
    this.onTap,
  });

  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(width: 0, color: const Color(0x00ffffff)),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
                child: EditText(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//EDITAR TEXT DE BOTON PERFIL
class EditText extends StatelessWidget {
  const EditText(this.displayText, {Key? key}) : super(key: key);

  final String displayText;

  @override
  Widget build(BuildContext context) {
    return Text(
      displayText,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          fontStyle: FontStyle.normal),
    );
  }
}

//LOGIN STATE
class LoginState extends StatelessWidget {
  const LoginState({
    super.key,
    required TextEditingController email,
    required TextEditingController password,
    required this.mounted,
  })  : _email = email,
        _password = password;

  final bool mounted;

  final TextEditingController _email;
  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        FocusScope.of(context).unfocus();
        final email = _email.text;
        final password = _password.text;
        try {
          await AuthService.firebase().logIn(
            email: email,
            password: password,
          );
          final user = AuthService.firebase().currentUser;
          if (user?.isEmailVerified ?? false) {
            //user verified
            if (mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                navigator,
                (route) => false,
              );
            }
          } else {
            //Not verified yet
            if (mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                verifyEmailRoute,
                (route) => false,
              );
            }
          }
        } on UserNotFoundAuthException {
          if (mounted) {
            await showErrorDialog(
              context,
              "User not found",
            );
          }
        } on WrongPasswordAuthException {
          if (mounted) {
            await showErrorDialog(
              context,
              "Wrong credentials",
            );
          }
        } on GenericAuthException {
          if (mounted) {
            await showErrorDialog(
              context,
              'Authentication Error',
            );
          }
        }
      },
      child: const Text('Login'),
    );
  }
}

class FullnameWidget extends StatelessWidget {
  FullnameWidget({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> _fetchFullName() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;

    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(currentUser.uid).get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      return data?['username'] as String?;
    } catch (error) {
      //print("Error fetching full name: $error");
      throw Exception('Failed to fetch full name');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _fetchFullName(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          return Text('${snapshot.data}');
        } else {
          return const Text('Welcome!');
        }
      },
    );
  }
}

class RegisterState extends StatelessWidget {
  const RegisterState({
    super.key,
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController username,
    required this.mounted,
  })  : _email = email,
        _password = password,
        _username = username;

  final bool mounted;

  final TextEditingController _email;
  final TextEditingController _password;
  final TextEditingController _username;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            final fullname = _username.text;
            final fullnamecapital = fullname.capitalizeEach();
            try {
              await AuthService.firebase()
                  .createUser(email: email, password: password);
              AuthService.firebase().sendEmailVerification();
            } on WeakPasswordAuthException {
              if (mounted) {
                await showErrorDialog(
                  context,
                  'Weak Password',
                );
              }
            } on EmailAlreadyInUseAuthException {
              if (mounted) {
                await showErrorDialog(
                  context,
                  'Email already in use',
                );
              }
            } on InvalidEmailAuthException {
              if (mounted) {
                await showErrorDialog(
                  context,
                  'Invalid Email',
                );
              }
            } on GenericAuthException {
              if (mounted) {
                await showErrorDialog(
                  context,
                  'Failed to register',
                );
              }
            }
            try {
              model.FirebaseUser user = model.FirebaseUser(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                  fullName: fullnamecapital,
                  email: email,
                  joinedDate: DateTime.now().toString(),
                  dietaryPreferences: null);

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .set(user.toJson());
              if (mounted) {
                Navigator.of(context).pushNamed(verifyEmailRoute);
              }
            } on GenericAuthException {
              if (mounted) {
                await showErrorDialog(
                  context,
                  'Error while uploading data to Firestore',
                );
              }
            }
          },
          child: const Text('Register'),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Already registered? Login Here!'))
      ],
    );
  }
}
