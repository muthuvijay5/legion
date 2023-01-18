import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/circular_view.dart';
import 'package:legion/views/loading_view.dart';
import 'package:legion/views/recruit_member_view.dart';
import 'package:legion/views/staff_home_view.dart';

dynamic database_functions = FirebaseMethods();

class ListRecruitMemberView extends StatefulWidget {
  String email;
  ListRecruitMemberView(this.email, {super.key});

  @override
  State<ListRecruitMemberView> createState() => _ListRecruitMemberViewState();
}

class _ListRecruitMemberViewState extends State<ListRecruitMemberView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            return ListRecruitMemberViewTMP(userList[0]);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class ListRecruitMemberViewTMP extends StatefulWidget {
  Map user_json;
  ListRecruitMemberViewTMP(this.user_json, {super.key});

  @override
  State<ListRecruitMemberViewTMP> createState() => _ListRecruitMemberViewTMPState();
}

class _ListRecruitMemberViewTMPState extends State<ListRecruitMemberViewTMP> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.getClubApplication('club_application', widget.user_json['club']),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic applied_list = snapshot.data;
            return ApplicationsPage(applied_list, widget.user_json);;
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class ApplicationsPage extends StatefulWidget {
  dynamic applied_list;
  Map user_json;
  ApplicationsPage(this.applied_list, this.user_json, {Key? key}) : super(key: key);
  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => 
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StaffHomeView(widget.user_json['email']),
              ),
            )),
        title: Text("Applications"),
        centerTitle: true,
      ),
      // body: ListView(children: <Widget>[Wrap(children: [ListApplications(widget.applied_list, widget.user_json)],)],
      body: ListView(children: [ListApplications(widget.applied_list, widget.user_json)],
    ),);
  }
}

class ListApplications extends StatefulWidget {
  dynamic applied_list;
  Map user_json;
  ListApplications(this.applied_list, this.user_json, {super.key});

  @override
  State<ListApplications> createState() => _ListApplicationsState();
}

class _ListApplicationsState extends State<ListApplications> {
  @override
  Widget build(BuildContext context) {
    List<Widget> final_list = [];
    for (int i = 0; i < widget.applied_list.length; ++i) {
      final_list.add(AApplication(widget.applied_list[i]['email'], widget.user_json));
    }
    print(final_list);
    return Column(
      children: final_list,
    );
  }
}

class AApplication extends StatefulWidget {
  String email;
  dynamic user_json;
  AApplication(this.email, this.user_json, {super.key});

  @override
  State<AApplication> createState() => _AApplicationState();
}

class _AApplicationState extends State<AApplication> {
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Wrap(
        children: <Widget>[
          Padding(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
          child: Text(
            widget.email,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),),
          Padding(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
          child: TextButton(
            style: flatButtonStyle,
            onPressed: () {
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RecruitMemberView(widget.email, widget.user_json['club']),
              ),
            );
            },
            child: Text(
              'View',
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),),
        ],
      ),
    ),);
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);