import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      _fetchFullName();
    }
  }

  User? _currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _userName;

  String? get userName => _userName;

  Future<void> _fetchFullName() async {
    if (_currentUser == null) return;
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(_currentUser!.uid).get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      _userName = data?['username'] as String?;
      //print("Fetched User Name: $_userName");
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to fetch full name');
    }
  }
}

class EmailProvider with ChangeNotifier {
  EmailProvider() {
    _userEmail = FirebaseAuth.instance.currentUser!.email!;
    //print("Email provider: ${_userEmail}");
    notifyListeners();
  }

  late String _userEmail;

  String? get email => _userEmail;
}
