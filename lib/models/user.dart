import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String fullName;
  final String email;
  final String joinedDate;
  final String? dietaryPreferences;

  const User(
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

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
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
