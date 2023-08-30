import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class FirebaseUser {
  final String uid;
  final String fullName;
  final String email;
  final String joinedDate;
  final String? dietaryPreferences;

  const FirebaseUser(
      {required this.uid,
      required this.fullName,
      required this.email,
      required this.joinedDate,
      this.dietaryPreferences});

  Map<String, dynamic> toJson() => {
        'username': fullName,
        'uid': uid,
        'email': email,
        'joinedDate': joinedDate,
        'dietaryPreferences': dietaryPreferences,
      };

  static FirebaseUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return FirebaseUser(
      fullName: snapshot['username'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      joinedDate: snapshot['joinedDate'],
      dietaryPreferences: snapshot['dietaryPreferences'],
    );
  }
}

//   User.fromData(Map<String, dynamic> data)
//       : id = data['id'],
//         fullName = data['fullName'],
//         email = data['email'],
//         joinedDate = data['joinedDate'],
//         dietaryPreferences = data['dietaryPreferences'];

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'fullName': fullName,
//       'email': email,
//       'joinedData': joinedDate,
//       'dietaryPreferences': dietaryPreferences,
//     };
//   }
// }
