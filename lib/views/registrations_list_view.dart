import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/head_home_view.dart';
import 'package:legion/views/loading_view.dart';
import 'package:legion/views/registration_user_view_faculty.dart';
import 'package:legion/views/registration_user_view_staff.dart';

dynamic database_functions = FirebaseMethods();

class RegistrationsListView extends StatefulWidget {
  String email;
  RegistrationsListView(this.email, {super.key});

  @override
  State<RegistrationsListView> createState() => _RegistrationsListViewState();
}

class _RegistrationsListViewState extends State<RegistrationsListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.getInactiveProfiles(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic inactive_list = snapshot.data;
            return ApplicationsPage(inactive_list, widget.email);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class ApplicationsPage extends StatefulWidget {
  dynamic inactive_list;
  String email;
  ApplicationsPage(this.inactive_list, this.email, {Key? key}) : super(key: key);
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
                builder: (context) => HeadHomeView(widget.email),
              ),
            )),
        title: Text("Applications"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: ListApplications(widget.inactive_list, widget.email),
    ),);
  }
}

class ListApplications extends StatefulWidget {
  dynamic inactive_list;
  String email;
  ListApplications(this.inactive_list, this.email, {super.key});

  @override
  State<ListApplications> createState() => _ListApplicationsState();
}

class _ListApplicationsState extends State<ListApplications> {
  @override
  Widget build(BuildContext context) {
    List<Widget> final_list = [];
    for (int i = 0; i < widget.inactive_list.length; ++i) {
      final_list.add(AApplication(widget.inactive_list[i], widget.email));
    }
    // print(final_list);
    return Column(
      children: final_list,
    );
  }
}

class AApplication extends StatefulWidget {
  String email;
  dynamic user_json;
  AApplication(this.user_json, this.email, {super.key});

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
            widget.user_json['email'],
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
                  builder: (context) {
                    if (widget.user_json['admin'] == '1') {
                      return RegistrationUserViewStaff(widget.user_json, widget.email);
                    }
                    else {
                      return RegistrationUserViewFaculty(widget.user_json, widget.email);
                    }
                  },
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