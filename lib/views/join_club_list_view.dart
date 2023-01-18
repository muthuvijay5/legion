import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/join_club_view.dart';
import 'package:legion/views/loading_view.dart';
import 'package:legion/views/student_home_view.dart';

dynamic database_functions = FirebaseMethods();

class JoinClubListView extends StatefulWidget {
  Map user_json;
  JoinClubListView(this.user_json, {super.key});

  @override
  State<JoinClubListView> createState() => _JoinClubListViewState();
}

class _JoinClubListViewState extends State<JoinClubListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.getMatchingRecords('recruit', widget.user_json['dept'] + ' ' + widget.user_json['batch']),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic join_club_list = snapshot.data;
            return JoinClubPage(join_club_list, widget.user_json);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class JoinClubPage extends StatefulWidget {
  dynamic join_club_list;
  Map user_json;
  JoinClubPage(this.join_club_list, this.user_json, {Key? key}) : super(key: key);
  @override
  State<JoinClubPage> createState() => _JoinClubPageState();
}

class _JoinClubPageState extends State<JoinClubPage> {

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
        title: Text("Join Club"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: ListJoinClub(widget.join_club_list, widget.user_json),
    ),);
  }
}

class ListJoinClub extends StatefulWidget {
  dynamic join_club_list;
  Map user_json;
  ListJoinClub(this.join_club_list, this.user_json, {super.key});

  @override
  State<ListJoinClub> createState() => _ListJoinClubState();
}

class _ListJoinClubState extends State<ListJoinClub> {
  @override
  Widget build(BuildContext context) {
    List<Widget> final_list = [];
    for (int i = 0; i < widget.join_club_list.length; ++i) {
      final_list.add(AEvent(widget.join_club_list[i]['club'], widget.user_json, widget.join_club_list[i]['description']));
    }
    print(final_list);
    return Column(
      children: final_list,
    );
  }
}

class AEvent extends StatefulWidget {
  String name;
  String desc;
  dynamic user_json;
  AEvent(this.name, this.user_json, this.desc, {super.key});

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
                builder: (context) => JoinClubView(widget.name, widget.desc, widget.user_json),
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