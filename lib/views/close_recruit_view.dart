import 'package:flutter/material.dart';
import 'package:legion/views/CircularForm.dart';
import 'package:legion/views/EventForm.dart';
import 'package:legion/views/home_view.dart';
import 'package:legion/views/list_recruit_member_view.dart';
import 'package:legion/views/loading_view.dart';
import 'package:legion/views/profile_view.dart';
import 'package:legion/views/recruit_view.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/staff_events_list_view.dart';
import 'package:legion/views/staff_home_view.dart';

dynamic database_functions = FirebaseMethods();

class CloseRecruitView extends StatefulWidget {
  String email;
  CloseRecruitView(this.email, {super.key});

  @override
  State<CloseRecruitView> createState() => _CloseRecruitViewState();
}

class _CloseRecruitViewState extends State<CloseRecruitView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            return CloseRecruitViewTmp(userList[0]);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class CloseRecruitViewTmp extends StatefulWidget {
  dynamic user_json;
  CloseRecruitViewTmp(this.user_json, {super.key});

  @override
  State<CloseRecruitViewTmp> createState() => _CloseRecruitViewTmpState();
}

class _CloseRecruitViewTmpState extends State<CloseRecruitViewTmp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.recruitOpen(widget.user_json['club']),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic isOpen = snapshot.data;
            bool is_open = isOpen;
            return CloseRecruitGUIView(widget.user_json, is_open);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class CloseRecruitGUIView extends StatefulWidget {
  dynamic user_json;
  bool is_open;
  CloseRecruitGUIView(this.user_json, this.is_open, {super.key});

  @override
  State<CloseRecruitGUIView> createState() => _CloseRecruitGUIViewState();
}

class _CloseRecruitGUIViewState extends State<CloseRecruitGUIView> {
  @override
  Widget build(BuildContext context) {
    if (widget.is_open == true) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => 
    Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StaffHomeView(widget.user_json['email']),
              ),
            )
  ),
            title: Text('Close Recruitment')
        ),
        body: Center(
            child: Column(
              children: [
                Text('Are you sure you want to close the recruitment for ' + widget.user_json['club'] + '?'),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                  child: ElevatedButton(
                            onPressed: () {
                              database_functions.deleteRecruitsByClub(widget.user_json['club']);
                              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StaffHomeView(widget.user_json['email']),
              ),
            );
                              },
                            child: Text('Confirm')),
                )
              ],
            )
        ),
    );
    }
    else {
      return Scaffold(
      appBar: AppBar(
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => 
    Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StaffHomeView(widget.user_json['email']),
              ),
            )
  ),
            title: Text('No Recruitment in Progress')
        ),
        body: Center(
            child: Column(
              children: [
                Text(widget.user_json['club'] + 'is currently not recruiting!'),
              ],
            )
        ),
    );
    }
  }
}