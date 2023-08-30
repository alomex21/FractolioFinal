// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:fractoliotesting/views/change_password.dart';
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
                    FullnameWidget(),
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
            text: "Change Password",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const EditProfile())));
              //Navigator.pushNamed(context, '/change_password');
            },
          ),
          const BotonPerfil(text: "Edit Profile"),
        ],
      ),
    );
  }

  void _didPushButton(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/navigator');
  }
}
