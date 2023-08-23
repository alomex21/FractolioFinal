import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Row(
              children: [
                const Card(
                  child: Card(
                    child: Icon(Icons.person),
                  ),
                ),
                Column(
                  children: [
                    const Text("Username"),
                    const Text('emailaddress'),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _didPushButton(context);
                        },
                        child: const Text('menu principal'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const BotonPerfil(text: "Edit Profile"),
          const BotonPerfil(text: "Change Password"),
        ],
      ),
    );
  }

  void _didPushButton(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/navigator');
  }
}

class BotonPerfil extends StatelessWidget {
  final String text;
  const BotonPerfil({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
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
    );
  }
}

class EditText extends StatelessWidget {
  final String displayText;
  const EditText(this.displayText, {Key? key}) : super(key: key);
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
