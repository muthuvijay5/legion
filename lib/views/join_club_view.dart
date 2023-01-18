import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/join_club_list_view.dart';

dynamic database_functions = FirebaseMethods();

class JoinClubView extends StatefulWidget {
  String title_text;
  String desc;
  dynamic user_json;
  JoinClubView(this.title_text, this.desc, this.user_json, {super.key});

  @override
  State<JoinClubView> createState() => _JoinClubViewState();
}

class _JoinClubViewState extends State<JoinClubView> {
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
                builder: (context) => JoinClubListView(widget.user_json),
              ),
            )),
        title: Text(widget.title_text),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: JoinClubRedirector(widget.desc, widget.user_json, widget.title_text),
    ),);
  }
}

class JoinClubRedirector extends StatelessWidget {
  final String desc;
  dynamic user_json;
  String club_name;
  JoinClubRedirector(this.desc, this.user_json, this.club_name, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(desc),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          child: ElevatedButton(
            onPressed: () {
              Map<String, dynamic> val = {
                'club': club_name,
                'email': user_json['email'],
              };
              database_functions.applyClub(val);
            },
            child: Text('Apply')
          ),
        ),
      ],
    );
  }
}