// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:fractoliotesting/views/change_password.dart';
import 'package:fractoliotesting/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Card(
                    child: Icon(Icons.person),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text("Welcome, "),
                        FullnameWidget(),
                      ],
                    ),
                    EmailWidget(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          BotonPerfil(
            text: "Change Password",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const EditProfile())));
              //Navigator.pushNamed(context, '/change_password');
            },
          ),
        ],
      ),
    );
  }
}
