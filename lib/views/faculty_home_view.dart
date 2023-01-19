import 'package:flutter/material.dart';
import 'package:legion/views/CircularForm.dart';
import 'package:legion/views/faculty_circular_list_view.dart';
import 'package:legion/views/faculty_profile_view.dart';
import 'package:legion/views/home_view.dart';
import 'package:legion/firebase_methods.dart';

FirebaseMethods some = FirebaseMethods();

class FacultyHomeView extends StatefulWidget {
  String email;
  FacultyHomeView(this.email, {super.key});

  @override
  State<FacultyHomeView> createState() => _FacultyHomeViewState();
}

class _FacultyHomeViewState extends State<FacultyHomeView> {
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CircularFormView(widget.email),
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
              'Anouncement',
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
                builder: (context) => FacultyCircularListView(widget.email),
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
              'Delete Announcements',
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