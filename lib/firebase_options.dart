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
    apiKey: 'AIzaSyAjZV6saViAYEJdUEfJBBzmjQSq_K9A2Yg',
    appId: '1:481382897971:web:d69b3375130b01e6a24646',
    messagingSenderId: '481382897971',
    projectId: 'cmsc-23-project-maiso-juatco',
    authDomain: 'cmsc-23-project-maiso-juatco.firebaseapp.com',
    storageBucket: 'cmsc-23-project-maiso-juatco.appspot.com',
    measurementId: 'G-0295VQDJBZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-T-OQFdcwFFSLaW9RTnuno5-BguGb2rk',
    appId: '1:481382897971:android:a21364d861fc115ea24646',
    messagingSenderId: '481382897971',
    projectId: 'cmsc-23-project-maiso-juatco',
    storageBucket: 'cmsc-23-project-maiso-juatco.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvmSg9tc2oTLTUKS21X6mZKuszLEXiqNk',
    appId: '1:481382897971:ios:973768e5190c2100a24646',
    messagingSenderId: '481382897971',
    projectId: 'cmsc-23-project-maiso-juatco',
    storageBucket: 'cmsc-23-project-maiso-juatco.appspot.com',
    iosBundleId: 'com.example.donationSystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvmSg9tc2oTLTUKS21X6mZKuszLEXiqNk',
    appId: '1:481382897971:ios:973768e5190c2100a24646',
    messagingSenderId: '481382897971',
    projectId: 'cmsc-23-project-maiso-juatco',
    storageBucket: 'cmsc-23-project-maiso-juatco.appspot.com',
    iosBundleId: 'com.example.donationSystem',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAjZV6saViAYEJdUEfJBBzmjQSq_K9A2Yg',
    appId: '1:481382897971:web:b6ba3e198a669626a24646',
    messagingSenderId: '481382897971',
    projectId: 'cmsc-23-project-maiso-juatco',
    authDomain: 'cmsc-23-project-maiso-juatco.firebaseapp.com',
    storageBucket: 'cmsc-23-project-maiso-juatco.appspot.com',
    measurementId: 'G-J8X6JZY51L',
  );
}
