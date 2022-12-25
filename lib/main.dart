// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:legion/circular_page.dart';
import 'package:legion/club_events.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:legion/firebase_options.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return const ClubEventsPage();
          default:
            return const Text('Loading...');
        }
      },
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home : const CircularPage(),
      home: const HomePage(),
      routes: {
        '/circular': (context) => const CircularPage(),
        '/clubs': (context) => const ClubEventsPage()
      },
    );
  }
}
