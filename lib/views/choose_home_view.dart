import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/firebase_options.dart';
import 'package:legion/views/staff_home_view.dart';
import 'package:legion/views/student_home_view.dart';

dynamic database_functions = FirebaseMethods();

class ChooseView extends StatefulWidget {
  String email;
  ChooseView(this.email, {super.key});

  @override
  State<ChooseView> createState() => _ChooseViewState();
}

class _ChooseViewState extends State<ChooseView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            if (userList[0]['admin'] == true) {
              return StaffHomeView(widget.email);
            }
            else {
              return StudentHomeView(widget.email);
            }
          default:
            return const Text('Loading...');
        }
      },
    );
  }
}