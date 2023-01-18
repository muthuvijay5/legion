import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:legion/firebase_options.dart';
import 'package:legion/views/home_view.dart';
import 'package:legion/views/login_view.dart';
import 'package:legion/views/verifyUser_view.dart';
import 'views/register_view_student.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      '/login': (context) => const LoginView(),
      '/emailVerify': (context) => VerifyAndAddUser(
            admin: false,
            userType: "Student",
          ),
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
          default:
            return const Text('Loading...');
        }
      },
    );
  }
}
