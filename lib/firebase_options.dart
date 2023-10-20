// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCf_tTNwrw9vSkI4dAEFNaDIfcq3hPFf8I',
    appId: '1:1081635638594:android:470ce01885f54fb538ccdb',
    messagingSenderId: '1081635638594',
    projectId: 'fractolio-qrcoder',
    storageBucket: 'fractolio-qrcoder.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyDufT4Mwb3xNLZKfkUlWsrBJv4Fvd9zM',
    appId: '1:1081635638594:ios:0382e13f9e20ec5538ccdb',
    messagingSenderId: '1081635638594',
    projectId: 'fractolio-qrcoder',
    storageBucket: 'fractolio-qrcoder.appspot.com',
    iosClientId: '1081635638594-6gt23mff5a6ubco3ug4l585k6uke6lek.apps.googleusercontent.com',
    iosBundleId: 'com.example.fractoliotesting',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyDufT4Mwb3xNLZKfkUlWsrBJv4Fvd9zM',
    appId: '1:1081635638594:ios:0382e13f9e20ec5538ccdb',
    messagingSenderId: '1081635638594',
    projectId: 'fractolio-qrcoder',
    storageBucket: 'fractolio-qrcoder.appspot.com',
    iosClientId: '1081635638594-6gt23mff5a6ubco3ug4l585k6uke6lek.apps.googleusercontent.com',
    iosBundleId: 'com.example.fractoliotesting',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDs98SNSMd15Gx1Cmqxj3AgxJ683LPMN7Y',
    appId: '1:1081635638594:web:fe8124448d14134138ccdb',
    messagingSenderId: '1081635638594',
    projectId: 'fractolio-qrcoder',
    authDomain: 'fractolio-qrcoder.firebaseapp.com',
    storageBucket: 'fractolio-qrcoder.appspot.com',
  );

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
}
