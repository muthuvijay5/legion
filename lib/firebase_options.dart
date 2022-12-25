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
    apiKey: 'AIzaSyCHxK9k0ibf53mCwSSkwqH-frVvF4Nz9sY',
    appId: '1:730042238274:web:6e4521220e6165ac4f74db',
    messagingSenderId: '730042238274',
    projectId: 'legion-psg-flutter',
    authDomain: 'legion-psg-flutter.firebaseapp.com',
    storageBucket: 'legion-psg-flutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzjzBQoWbSkQA7P8NeyCew-vykftK6rvs',
    appId: '1:730042238274:android:2d73c3ab692ab8e74f74db',
    messagingSenderId: '730042238274',
    projectId: 'legion-psg-flutter',
    storageBucket: 'legion-psg-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2rqG8ahDGHgcsx87e6zhs7VUHywpvnYI',
    appId: '1:730042238274:ios:2fef8fbab7ad1e094f74db',
    messagingSenderId: '730042238274',
    projectId: 'legion-psg-flutter',
    storageBucket: 'legion-psg-flutter.appspot.com',
    iosClientId: '730042238274-oss3b1qi8o4is4k3ln9rbga88prqhi5k.apps.googleusercontent.com',
    iosBundleId: 'com.example.legion',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2rqG8ahDGHgcsx87e6zhs7VUHywpvnYI',
    appId: '1:730042238274:ios:2fef8fbab7ad1e094f74db',
    messagingSenderId: '730042238274',
    projectId: 'legion-psg-flutter',
    storageBucket: 'legion-psg-flutter.appspot.com',
    iosClientId: '730042238274-oss3b1qi8o4is4k3ln9rbga88prqhi5k.apps.googleusercontent.com',
    iosBundleId: 'com.example.legion',
  );
}
