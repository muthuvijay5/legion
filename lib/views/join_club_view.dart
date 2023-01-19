import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/join_club_list_view.dart';
import 'package:legion/views/loading_view.dart';

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
    return FutureBuilder(
      future: database_functions.checkApplicationExists(widget.user_json['email'], widget.title_text),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic res = snapshot.data;
            bool is_applied = res;
            return JoinClubViewTmp(widget.title_text, widget.desc, widget.user_json, is_applied);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class JoinClubViewTmp extends StatefulWidget {
  String title_text;
  String desc;
  dynamic user_json;
  bool is_applied;
  JoinClubViewTmp(this.title_text, this.desc, this.user_json, this.is_applied, {super.key});

  @override
  State<JoinClubViewTmp> createState() => _JoinClubViewTmpState();
}

class _JoinClubViewTmpState extends State<JoinClubViewTmp> {
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
      child: JoinClubRedirector(widget.desc, widget.user_json, widget.title_text, widget.is_applied),
    ),);
  }
}

class JoinClubRedirector extends StatelessWidget {
  final String desc;
  dynamic user_json;
  String club_name;
  bool is_applied;
  JoinClubRedirector(this.desc, this.user_json, this.club_name, this.is_applied, {Key? key})
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
              if (user_json['clubs'].contains(club_name) == true) {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("You are a member!"),
                      content: Text("You have already a member of $club_name"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Container(
                            color: Colors.blue,
                            padding: const EdgeInsets.all(14),
                            child: const Text(
                              "Okay",
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                              ),
                          ),
                        ),
                      ],
                    ),
                  );
              }
              else if (is_applied == false) {
                Map<String, dynamic> val = {
                  'club': club_name,
                  'email': user_json['email'],
                };
                database_functions.applyClub(val);
              }
              else {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Already Applied!"),
                      content: const Text("You have already applied for joining this club! Wait for the response"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Container(
                            color: Colors.blue,
                            padding: const EdgeInsets.all(14),
                            child: const Text(
                              "Okay",
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                              ),
                          ),
                        ),
                      ],
                    ),
                  );
              }
            },
            child: Text('Apply')
          ),
        ),
      ],
    );
  }
}