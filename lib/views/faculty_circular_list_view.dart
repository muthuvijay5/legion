import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/faculty_circular_view.dart';
import 'package:legion/views/faculty_home_view.dart';
import 'package:legion/views/loading_view.dart';

dynamic database_functions = FirebaseMethods();

class FacultyCircularListView extends StatefulWidget {
  String email;
  FacultyCircularListView(this.email, {super.key});

  @override
  State<FacultyCircularListView> createState() => _FacultyCircularListViewState();
}

class _FacultyCircularListViewState extends State<FacultyCircularListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            Map userListTmp = userList[0];
            return FacultyCircularListViewTmp(userListTmp);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class FacultyCircularListViewTmp extends StatefulWidget {
  Map user_json;
  FacultyCircularListViewTmp(this.user_json, {super.key});

  @override
  State<FacultyCircularListViewTmp> createState() => _FacultyCircularListViewTmpState();
}

class _FacultyCircularListViewTmpState extends State<FacultyCircularListViewTmp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.getAllDocumentsWithId('circular'),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic circular_list = snapshot.data;
            return FacultyCircularPage(circular_list, widget.user_json);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class FacultyCircularPage extends StatefulWidget {
  dynamic circular_list;
  Map user_json;
  FacultyCircularPage(this.circular_list, this.user_json, {Key? key}) : super(key: key);
  @override
  State<FacultyCircularPage> createState() => _FacultyCircularPageState();
}

class _FacultyCircularPageState extends State<FacultyCircularPage> {

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
                builder: (context) => FacultyHomeView(widget.user_json['email']),
              ),
            )),
        title: Text("Circulars"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: FacultyListCirculars(widget.circular_list, widget.user_json),
    ),);
  }
}

class FacultyListCirculars extends StatefulWidget {
  dynamic circular_list;
  Map user_json;
  FacultyListCirculars(this.circular_list, this.user_json, {super.key});

  @override
  State<FacultyListCirculars> createState() => _FacultyListCircularsState();
}

class _FacultyListCircularsState extends State<FacultyListCirculars> {
  @override
  Widget build(BuildContext context) {
    List<Widget> final_list = [];
    for (int i = 0; i < widget.circular_list.length; ++i) {
      final_list.add(AFacultyCircular(widget.circular_list[i]['name'], widget.circular_list[i]['imageurl'], widget.circular_list[i]['timestamp'].toString(), widget.circular_list[i]['id'], widget.user_json));
    }
    print(final_list);
    return Column(
      children: final_list,
    );
  }
}

class AFacultyCircular extends StatefulWidget {
  String name;
  String url;
  String time;
  String docId;
  dynamic user_json;
  AFacultyCircular(this.name, this.url, this.time, this.docId, this.user_json, {super.key});

  @override
  State<AFacultyCircular> createState() => _AFacultyCircularState();
}

class _AFacultyCircularState extends State<AFacultyCircular> {
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
                  builder: (context) => FacultyCircularView(widget.url, widget.name, widget.time, widget.docId, widget.user_json),
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