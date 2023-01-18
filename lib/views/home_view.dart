import 'package:flutter/material.dart';
import 'package:legion/views/login_view.dart';
import 'package:legion/views/register_view_faculty.dart';
import 'package:legion/views/register_view_student.dart';
import 'package:legion/views/register_view_staff.dart';
import 'package:legion/firebase_methods.dart';

FirebaseMethods some = FirebaseMethods();

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(null),
        title: const Text('Select User'),
        centerTitle: true,
        ),
      body: Center(
      child: ListView(
      children: [Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterViewStudent(userType: "Student"),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 90.0, 5.0, 5.0),
            child: Container(
            width: 150.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Text(
              'Student',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),)
          ),
        )),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterViewFaculty(userType: "Faculty",),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
            width: 150.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Text(
              'Faculty',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          )),
        )),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterViewStaff(userType: "Staff",),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
            width: 150.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Text(
              'Staff',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          )),
        )),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginView(),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
            width: 150.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),)
          ),
        )),
      ])],
    )
    ),);
  }
}
