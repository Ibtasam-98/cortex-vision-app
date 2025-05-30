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
    apiKey: 'AIzaSyChgYsw64dTPS-YjESJKBNPom2vtPr2qqM',
    appId: '1:1079561466704:web:0eba209f422d28f38f7255',
    messagingSenderId: '1079561466704',
    projectId: 'cortexvision-8f777',
    authDomain: 'cortexvision-8f777.firebaseapp.com',
    storageBucket: 'cortexvision-8f777.firebasestorage.app',
    measurementId: 'G-TCB2476W5V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2TDLIkmJbxqnDbZkP54hyo9LD_a79IYU',
    appId: '1:1079561466704:android:5f9b8f6d2dbfcc298f7255',
    messagingSenderId: '1079561466704',
    projectId: 'cortexvision-8f777',
    storageBucket: 'cortexvision-8f777.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtjftH4pTPVKro9rbBd-leDXPYvzPqcR8',
    appId: '1:1079561466704:ios:836d9c487c4eda7a8f7255',
    messagingSenderId: '1079561466704',
    projectId: 'cortexvision-8f777',
    storageBucket: 'cortexvision-8f777.firebasestorage.app',
    iosBundleId: 'com.example.cortexVisionApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtjftH4pTPVKro9rbBd-leDXPYvzPqcR8',
    appId: '1:1079561466704:ios:836d9c487c4eda7a8f7255',
    messagingSenderId: '1079561466704',
    projectId: 'cortexvision-8f777',
    storageBucket: 'cortexvision-8f777.firebasestorage.app',
    iosBundleId: 'com.example.cortexVisionApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyChgYsw64dTPS-YjESJKBNPom2vtPr2qqM',
    appId: '1:1079561466704:web:6c16faab6c7855db8f7255',
    messagingSenderId: '1079561466704',
    projectId: 'cortexvision-8f777',
    authDomain: 'cortexvision-8f777.firebaseapp.com',
    storageBucket: 'cortexvision-8f777.firebasestorage.app',
    measurementId: 'G-CECVH07QTF',
  );
}
