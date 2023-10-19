// firebase_service.dart
import 'package:firebase_storage/firebase_storage.dart';
import 'storage_services.dart';

class FirebaseService implements FirebaseServiceInterface {
  // FirebaseService._();
  factory FirebaseService() {
    return instance;
  }
  FirebaseService._internal();
  static final FirebaseService instance = FirebaseService._internal();

  final FirebaseStorage _firebaseInstance = FirebaseStorage.instance;

  @override
  Future<String> getImageUrl(String productName) async {
    final Reference ref =
        //_firebaseInstance.ref('ProductImage/$productName.jpeg');
        _firebaseInstance.ref('ProductImage/$productName');
    //print(ref);
    String url = await ref.getDownloadURL();
    return url;
  }
}
