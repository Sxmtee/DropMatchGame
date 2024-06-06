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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA0a8-WToeS39At5De2j-g7XXjOxg4r4aQ',
    appId: '1:27475153704:web:a32b858276f08702f8f61d',
    messagingSenderId: '27475153704',
    projectId: 'dropmatch-982db',
    authDomain: 'dropmatch-982db.firebaseapp.com',
    storageBucket: 'dropmatch-982db.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClE0KSmLy7f1DOnaaEhqsyhRxnpfEzqlk',
    appId: '1:27475153704:android:e740993043e6955cf8f61d',
    messagingSenderId: '27475153704',
    projectId: 'dropmatch-982db',
    storageBucket: 'dropmatch-982db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7ZMp5oewlftRW6p_aomeA7IsbAPZT0Fk',
    appId: '1:27475153704:ios:fca78a5a167c816ff8f61d',
    messagingSenderId: '27475153704',
    projectId: 'dropmatch-982db',
    storageBucket: 'dropmatch-982db.appspot.com',
    iosBundleId: 'com.example.dropmatchgame',
  );
}
