import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:legion/views/register_view.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterView(
                      admin: false,
                      userType: "Student",
                    )));
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
            width: 100.0,
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterView(
                      admin: true,
                      userType: "Staff",
                    )));
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
            width: 100.0,
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
      ]),
    )
    );
  }
}
