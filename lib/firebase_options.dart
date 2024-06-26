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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDUb-u6wxuTQHS60PhAQmMet-aKhMk3E4E',
    appId: '1:562615193593:web:e49060a7850e6ad0f7f728',
    messagingSenderId: '562615193593',
    projectId: 'fixit-30d1f',
    authDomain: 'fixit-30d1f.firebaseapp.com',
    storageBucket: 'fixit-30d1f.appspot.com',
    measurementId: 'G-YMTTVZSZLN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBes5OUZzLI1UMg1rwbVpAsItyT8NuzT1c',
    appId: '1:562615193593:android:90ae0c0e84a1f0c9f7f728',
    messagingSenderId: '562615193593',
    projectId: 'fixit-30d1f',
    storageBucket: 'fixit-30d1f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCoZZDal4A2Q7PSibXASkU65MemMY0B-Jo',
    appId: '1:562615193593:ios:483d933d27402bcef7f728',
    messagingSenderId: '562615193593',
    projectId: 'fixit-30d1f',
    storageBucket: 'fixit-30d1f.appspot.com',
    iosBundleId: 'com.example.fixIt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCoZZDal4A2Q7PSibXASkU65MemMY0B-Jo',
    appId: '1:562615193593:ios:50acc57d5d694af5f7f728',
    messagingSenderId: '562615193593',
    projectId: 'fixit-30d1f',
    storageBucket: 'fixit-30d1f.appspot.com',
    iosBundleId: 'com.example.fixIt.RunnerTests',
  );
}
