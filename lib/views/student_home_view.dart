import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/circular_list_view.dart';
import 'package:legion/views/events_list_view.dart';
import 'package:legion/views/join_club_list_view.dart';
import 'package:legion/views/login_view.dart';
import 'package:legion/views/profile_view.dart';

dynamic database_functions = FirebaseMethods();

class StudentHomeView extends StatefulWidget {
  String email;
  StudentHomeView(this.email, {super.key});

  @override
  State<StudentHomeView> createState() => _StudentHomeViewState();
}

class _StudentHomeViewState extends State<StudentHomeView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            return StudentHomeViewTmp(widget.email, userList);
          default:
            return const Text('Loading...');
        }
      },
    );
  }
}

class StudentHomeViewTmp extends StatefulWidget {
  String email;
  dynamic user_json;
  StudentHomeViewTmp(this.email, this.user_json, {super.key});

  @override
  State<StudentHomeViewTmp> createState() => _StudentHomeViewTmpState();
}

class _StudentHomeViewTmpState extends State<StudentHomeViewTmp> {
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
                builder: (context) => ProfileView(widget.email
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
                builder: (context) => EventsListView(widget.user_json[0]
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
              'Events',
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
                builder: (context) => CircularListView(widget.user_json[0]
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
                builder: (context) => JoinClubListView(widget.user_json[0]
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
