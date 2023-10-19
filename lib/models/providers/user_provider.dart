// file: 'user_provider.dart'
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser;
  String? _userName;

  UserProvider() {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      _fetchFullName();
    }
  }

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

  String? get userName => _userName;
}

class EmailProvider with ChangeNotifier {
  late String _userEmail;
  EmailProvider() {
    _userEmail = FirebaseAuth.instance.currentUser!.email!;
    //print("Email provider: ${_userEmail}");
    notifyListeners();
  }
  String? get email => _userEmail;
}
