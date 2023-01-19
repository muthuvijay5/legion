import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/faculty_home_view.dart';
import 'package:legion/views/head_home_view.dart';
import 'package:legion/views/loading_view.dart';
import 'package:legion/views/staff_home_view.dart';
import 'package:legion/views/student_home_view.dart';
import 'package:legion/views/wait_view.dart';

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
            if (userList[0]['admin'] == '1') {
              if (userList[0]['activated'] == true) {
                return StaffHomeView(widget.email);
              }
              else {
                return const WaitView();
              }
            }
            else if (userList[0]['admin'] == '0') {
              return StudentHomeView(widget.email);
            }
            else if (userList[0]['admin'] == '2') {
              if (userList[0]['activated'] == true) {
                return FacultyHomeView(widget.email);
              }
              else {
                return const WaitView();
              }
            }
            else {
              return HeadHomeView(widget.email);
            }
          default:
            return const LoadingView();
        }
      },
    );
  }
}