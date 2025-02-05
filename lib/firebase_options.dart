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
    apiKey: 'AIzaSyDnwsD3fOkbplDr0vIvXzbGtr_jbqLFAJY',
    appId: '1:584533852122:web:06f3b125a74a45fed0cae3',
    messagingSenderId: '584533852122',
    projectId: 'groceries-5ba8b',
    authDomain: 'groceries-5ba8b.firebaseapp.com',
    storageBucket: 'groceries-5ba8b.firebasestorage.app',
    measurementId: 'G-TKF7X5DZVS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAibg1eFHiVgHyyB7eaiCg7Wex4U9OaArE',
    appId: '1:584533852122:android:91fb0afeb24332add0cae3',
    messagingSenderId: '584533852122',
    projectId: 'groceries-5ba8b',
    storageBucket: 'groceries-5ba8b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD2JM5lGlz5i1Zp8yD4ckFohbMBemY-lDc',
    appId: '1:584533852122:ios:a4cb2e8628e56467d0cae3',
    messagingSenderId: '584533852122',
    projectId: 'groceries-5ba8b',
    storageBucket: 'groceries-5ba8b.firebasestorage.app',
    iosBundleId: 'com.groceries.app.groceries',
  );
}
