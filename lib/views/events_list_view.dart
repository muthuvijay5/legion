import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/events_view.dart';
import 'package:legion/views/loading_view.dart';
import 'package:legion/views/student_home_view.dart';

dynamic database_functions = FirebaseMethods();

class EventsListView extends StatefulWidget {
  Map user_json;
  EventsListView(this.user_json, {super.key});

  @override
  State<EventsListView> createState() => _EventsListViewState();
}

class _EventsListViewState extends State<EventsListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.getMatchingRecords('events', widget.user_json['dept'] + ' ' + widget.user_json['batch']),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic events_list = snapshot.data;
            return EventsPage(events_list, widget.user_json);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class EventsPage extends StatefulWidget {
  dynamic events_list;
  Map user_json;
  EventsPage(this.events_list, this.user_json, {Key? key}) : super(key: key);
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

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
                builder: (context) => StudentHomeView(widget.user_json['email']),
              ),
            )),
        title: Text("Events"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: ListEvents(widget.events_list, widget.user_json),
    ),);
  }
}

class ListEvents extends StatefulWidget {
  dynamic events_list;
  Map user_json;
  ListEvents(this.events_list, this.user_json, {super.key});

  @override
  State<ListEvents> createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {
  @override
  Widget build(BuildContext context) {
    List<Widget> final_list = [];
    for (int i = 0; i < widget.events_list.length; ++i) {
      final_list.add(AEvent(widget.events_list[i]['eventname'], widget.events_list[i]['imageurl'], widget.events_list[i]['timestamp'], widget.user_json, widget.events_list[i]['eventdescription'], widget.events_list[i]['phone']));
    }
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
  dynamic user_json;
  AEvent(this.name, this.url, this.time, this.user_json, this.desc, this.phone, {super.key});

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
                builder: (context) => EventsView(widget.url, widget.name, widget.time, widget.desc, widget.phone, widget.user_json),
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