import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:legion/firebase_options.dart';
import 'package:legion/views/home_view.dart';
import 'package:legion/views/login_view.dart';
import 'package:legion/views/verifyUser_view.dart';
import 'package:legion/views/circular_page.dart';
import 'package:legion/views/club_events.dart';

import 'views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      '/login': (context) => const LoginView(),
      '/register': (context) => RegisterView(
            admin: false,
            userType: "Student",
          ),
      '/emailVerify': (context) => VerifyAndAddUser(
            admin: false,
            userType: "Student",
          ),
      '/events' :(context) => const ClubEventsPage(),
      '/circulars' :(context) => const CircularPage()
    },
  ));
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
            return const HomeView();

          // final user = FirebaseAuth.instance.currentUser;
          // if (user?.emailVerified ?? false) {
          // } else {
          //   return const VerifyEmailView();
          // }
          // return const Text("Done");
          default:
            return const Text('Loading...');
        }
      },
    );
  }
}
