import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/loading_view.dart';
import 'package:legion/views/staff_events_view.dart';
import 'package:legion/views/staff_home_view.dart';

dynamic database_functions = FirebaseMethods();

class StaffEventListView extends StatefulWidget {
  String email;
  StaffEventListView(this.email, {super.key});

  @override
  State<StaffEventListView> createState() => _StaffEventListViewState();
}

class _StaffEventListViewState extends State<StaffEventListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.getAllDocumentsWithId('events'),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic events_list = snapshot.data;
            return StaffEventListViewTmp(widget.email, events_list);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class StaffEventListViewTmp extends StatefulWidget {
  String email;
  dynamic events_list;
  StaffEventListViewTmp(this.email, this.events_list, {super.key});

  @override
  State<StaffEventListViewTmp> createState() => _StaffEventListViewTmpState();
}

class _StaffEventListViewTmpState extends State<StaffEventListViewTmp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic user_list = snapshot.data;
            Map user_json = user_list[0];
            return StaffEventPage(widget.events_list, user_json);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class StaffEventPage extends StatefulWidget {
  dynamic events_list;
  Map user_json;
  StaffEventPage(this.events_list, this.user_json, {Key? key}) : super(key: key);
  @override
  State<StaffEventPage> createState() => _StaffEventPageState();
}

class _StaffEventPageState extends State<StaffEventPage> {
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
        title: Text("Events"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: ListStaffEvent(widget.events_list, widget.user_json),
    ),);
  }
}

class ListStaffEvent extends StatefulWidget {
  dynamic events_list;
  Map user_json;
  ListStaffEvent(this.events_list, this.user_json, {super.key});

  @override
  State<ListStaffEvent> createState() => _ListStaffEventState();
}

class _ListStaffEventState extends State<ListStaffEvent> {
  @override
  Widget build(BuildContext context) {
    List<Widget> final_list = [];
    for (int i = 0; i < widget.events_list.length; ++i) {
      final_list.add(AEvent(widget.events_list[i]['eventname'], widget.events_list[i]['imageurl'], widget.events_list[i]['timestamp'].toString(), widget.user_json, widget.events_list[i]['eventdescription'], widget.events_list[i]['phone'], widget.events_list[i]['id']));
    }
    // print(final_list);
    return Column(
      children: final_list,
    );
  }
}

class AEvent extends StatefulWidget {
  String name;
  String url;
  String time;
  String desc;
  String phone;
  String docId;
  dynamic user_json;
  AEvent(this.name, this.url, this.time, this.user_json, this.desc, this.phone, this.docId, {super.key});

  @override
  State<AEvent> createState() => _AEventState();
}

class _AEventState extends State<AEvent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.name,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            style: flatButtonStyle,
            onPressed: () {
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StaffEventView(widget.url, widget.name, widget.time, widget.desc, widget.phone, widget.docId, widget.user_json),
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
          ),
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