import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../dialogs/error_dialog.dart';
import '../services/auth/auth_exceptions.dart';
import 'login.dart';
import '../widgets/widgets.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final currentUser = FirebaseAuth.instance.currentUser;
  var newPassword = '';
  final newPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Password Changed. Log in again.'),
          ),
        );
      }
    } on GenericAuthException {
      if (mounted) {
        await showErrorDialog(
          context,
          'Error While changing password',
        );
      }
    }
  }

  void _logout() async {
    await _auth.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushReplacementNamed(
      '/',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully signed out!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'About to Reset Password',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  fontStyle: FontStyle.normal),
            ),
            const Text('Remember to correctly set a good password'),
            const Divider(
              height: 25,
              thickness: 5,
            ),
            Container(
              //padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              alignment: AlignmentDirectional.center,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0x00f1f4f8),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Enter new Password'),
                        obscureText: true,
                        controller: newPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 25, thickness: 5),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    newPassword = newPasswordController.text;
                  });
                  changePassword();
                }
              },
              child: const BotonPerfil(text: 'Change Password'),
            )
          ],
        ),
      ),
    );
  }
}
