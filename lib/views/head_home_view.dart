import 'package:flutter/material.dart';
import 'package:legion/views/faculty_profile_view.dart';
import 'package:legion/views/home_view.dart';
import 'package:legion/firebase_methods.dart';

FirebaseMethods some = FirebaseMethods();

class HeadHomeView extends StatefulWidget {
  String email;
  HeadHomeView(this.email, {super.key});

  @override
  State<HeadHomeView> createState() => _HeadHomeViewState();
}

class _HeadHomeViewState extends State<HeadHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: IconButton(
    icon: const Icon(Icons.logout, color: Colors.white),
    onPressed: () => 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeView(),
      ),
    )
  ),
        title: const Text('Home'),
        centerTitle: true,
        ),
      body: Center(
      child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FacultyProfileView(widget.email),
              ),
            );
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
              'View Registrations',
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
    ),);
  }
}