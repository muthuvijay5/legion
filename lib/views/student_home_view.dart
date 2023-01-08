import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:legion/views/login_view.dart';
import 'package:legion/views/register_view.dart';
import 'package:legion/views/profile_view.dart';
import 'package:legion/firebase_methods.dart';

class StudentHomeView extends StatefulWidget {
  const StudentHomeView({super.key});

  @override
  State<StudentHomeView> createState() => _StudentHomeViewState();
}

class _StudentHomeViewState extends State<StudentHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(null),
        title: const Text('Home'),
        centerTitle: true,
        ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginView(
                    )));
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
            width: 200.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Text(
              'Profile',
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginView(
                    )));
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
            width: 200.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Text(
              'Participate',
              
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginView(
                    )));
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
            width: 200.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Text(
              'Circulars',
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginView(
                    )));
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
            width: 200.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Text(
              'Join Clubs',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),)
          ),
        )),
      ]),
    )
    );
  }
}