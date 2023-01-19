import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/circular_view.dart';
import 'package:legion/views/loading_view.dart';
import 'package:legion/views/student_home_view.dart';

dynamic database_functions = FirebaseMethods();

class CircularListView extends StatefulWidget {
  Map user_json;
  CircularListView(this.user_json, {super.key});

  @override
  State<CircularListView> createState() => _CircularListViewState();
}

class _CircularListViewState extends State<CircularListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.getMatchingRecords('circular', widget.user_json['dept'] + ' ' + widget.user_json['batch']),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic circular_list = snapshot.data;
            print(circular_list[0]['timestamp']);
            print(circular_list);
            return CircularPage(circular_list, widget.user_json);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class CircularPage extends StatefulWidget {
  dynamic circular_list;
  Map user_json;
  CircularPage(this.circular_list, this.user_json, {Key? key}) : super(key: key);
  @override
  State<CircularPage> createState() => _CircularPageState();
}

class _CircularPageState extends State<CircularPage> {

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
        title: Text("Circulars"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: ListCirculars(widget.circular_list, widget.user_json),
    ),);
  }
}

class ListCirculars extends StatefulWidget {
  dynamic circular_list;
  Map user_json;
  ListCirculars(this.circular_list, this.user_json, {super.key});

  @override
  State<ListCirculars> createState() => _ListCircularsState();
}

class _ListCircularsState extends State<ListCirculars> {
  @override
  Widget build(BuildContext context) {
    List<Widget> final_list = [];
    for (int i = 0; i < widget.circular_list.length; ++i) {
      final_list.add(ACircular(widget.circular_list[i]['name'], widget.circular_list[i]['imageurl'], widget.circular_list[i]['timestamp'], widget.user_json));
    }
    print(final_list);
    return Column(
      children: final_list,
    );
  }
}

class ACircular extends StatefulWidget {
  String name;
  String url;
  String time;
  dynamic user_json;
  ACircular(this.name, this.url, this.time, this.user_json, {super.key});

  @override
  State<ACircular> createState() => _ACircularState();
}

class _ACircularState extends State<ACircular> {
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
                  builder: (context) => CircularView(widget.url, widget.name, widget.time, widget.user_json),
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