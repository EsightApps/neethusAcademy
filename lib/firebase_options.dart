// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAEYDDheedW7lhgMrytLkM6-FV33Xv8J-8',
    appId: '1:246497695550:web:fa0500f5c0032162d5fe6f',
    messagingSenderId: '246497695550',
    projectId: 'neethu-s-academy',
    authDomain: 'neethu-s-academy.firebaseapp.com',
    storageBucket: 'neethu-s-academy.firebasestorage.app',
    measurementId: 'G-90JDZSSX1N',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCesZCH54HqwtIVuttge88MNbastfB2Vf8',
    appId: '1:246497695550:ios:fb02abd434ce9685d5fe6f',
    messagingSenderId: '246497695550',
    projectId: 'neethu-s-academy',
    storageBucket: 'neethu-s-academy.firebasestorage.app',
    iosBundleId: 'com.example.neethusacademy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAEYDDheedW7lhgMrytLkM6-FV33Xv8J-8',
    appId: '1:246497695550:web:3bdece54e919d2ddd5fe6f',
    messagingSenderId: '246497695550',
    projectId: 'neethu-s-academy',
    authDomain: 'neethu-s-academy.firebaseapp.com',
    storageBucket: 'neethu-s-academy.firebasestorage.app',
    measurementId: 'G-B239JRK8FK',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCesZCH54HqwtIVuttge88MNbastfB2Vf8',
    appId: '1:246497695550:ios:fb02abd434ce9685d5fe6f',
    messagingSenderId: '246497695550',
    projectId: 'neethu-s-academy',
    storageBucket: 'neethu-s-academy.firebasestorage.app',
    iosBundleId: 'com.example.neethusacademy',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4Sn4AfZtDCgudFYmwT_yK7iJ_9F48ELc',
    appId: '1:246497695550:android:01c86a5d994bb282d5fe6f',
    messagingSenderId: '246497695550',
    projectId: 'neethu-s-academy',
    storageBucket: 'neethu-s-academy.firebasestorage.app',
  );

}