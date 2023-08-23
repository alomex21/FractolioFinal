import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _newpassword = '', _oldpassword = '', _finalpassword = '';

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
              'Reset Password',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  fontStyle: FontStyle.normal),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              alignment: AlignmentDirectional.center,
              width: double.infinity,
              height: 200,
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
                            labelText: 'Enter old Password'),
                        obscureText: true,
                        onSaved: (String? value) => _oldpassword = value!,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Enter new Password'),
                        obscureText: true,
                        onSaved: (String? value) => _newpassword,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Confirm your Password'),
                        obscureText: true,
                        validator: (String? value) {
                          if (_newpassword != _finalpassword) {
                            return 'Please enter the same password';
                          }
                          return null;
                        },
                        onSaved: (String? value) => _finalpassword,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
}
