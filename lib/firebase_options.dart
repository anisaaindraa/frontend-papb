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
    apiKey: 'AIzaSyA9tIzrs6N0Og0q9mWxujwM4rG3MdF8o1k',
    appId: '1:871723171858:web:457b3af5f1a95b39e718cb',
    messagingSenderId: '871723171858',
    projectId: 'dictionary-pad',
    authDomain: 'dictionary-pad.firebaseapp.com',
    storageBucket: 'dictionary-pad.appspot.com',
    measurementId: 'G-RH9KP2C28J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDF2BtgvcKntPQK7MZo70qHsSIQudZ_Xzk',
    appId: '1:871723171858:android:e4bc00b9fe52ee60e718cb',
    messagingSenderId: '871723171858',
    projectId: 'dictionary-pad',
    storageBucket: 'dictionary-pad.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADBsrotDt3zqy5qmz_RENRaBFH8REP9Uw',
    appId: '1:871723171858:ios:b03940108e04e67ae718cb',
    messagingSenderId: '871723171858',
    projectId: 'dictionary-pad',
    storageBucket: 'dictionary-pad.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADBsrotDt3zqy5qmz_RENRaBFH8REP9Uw',
    appId: '1:871723171858:ios:b03940108e04e67ae718cb',
    messagingSenderId: '871723171858',
    projectId: 'dictionary-pad',
    storageBucket: 'dictionary-pad.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA9tIzrs6N0Og0q9mWxujwM4rG3MdF8o1k',
    appId: '1:871723171858:web:43af3652f68ba2fbe718cb',
    messagingSenderId: '871723171858',
    projectId: 'dictionary-pad',
    authDomain: 'dictionary-pad.firebaseapp.com',
    storageBucket: 'dictionary-pad.appspot.com',
    measurementId: 'G-LNTFDDP1Q3',
  );
}
