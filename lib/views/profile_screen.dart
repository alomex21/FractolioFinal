import 'package:flutter/material.dart';
import 'package:fractoliotesting/widgets/widgets.dart';

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
          BotonPerfil(
            text: "Edit Profile",
            onTap: () {
              Navigator.pushNamed(context, '/edit_profile');
            },
          ),
          const BotonPerfil(text: "Change Password"),
        ],
      ),
    );
  }

  void _didPushButton(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/navigator');
  }
}
