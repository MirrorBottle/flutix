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
    apiKey: 'AIzaSyB8FXE6oRVHS23QnnBYb5r_8ArQe8NavnU',
    appId: '1:33812622240:web:8f5d740b5ba3ece79bd2c5',
    messagingSenderId: '33812622240',
    projectId: 'mirrorbottle-flutix',
    authDomain: 'mirrorbottle-flutix.firebaseapp.com',
    storageBucket: 'mirrorbottle-flutix.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjMqW7jQ10R4o5GAXCYQNGCwr2-hLOYmM',
    appId: '1:33812622240:android:8cba9ef5a96da8a19bd2c5',
    messagingSenderId: '33812622240',
    projectId: 'mirrorbottle-flutix',
    storageBucket: 'mirrorbottle-flutix.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCc1Q7AfxF7h-l_Y-bEVE12s1B-n9UCM9Q',
    appId: '1:33812622240:ios:1e13b366fb618a7f9bd2c5',
    messagingSenderId: '33812622240',
    projectId: 'mirrorbottle-flutix',
    storageBucket: 'mirrorbottle-flutix.appspot.com',
    iosBundleId: 'com.example.flutterCubit',
  );
}
