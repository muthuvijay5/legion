import 'dart:io';
import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'dept_checkbox.dart';

dynamic database_functions = FirebaseMethods();

class RecruitView extends StatefulWidget {
  String email;
  RecruitView(this.email, {super.key});

  @override
  State<RecruitView> createState() => _RecruitviewState();
}

class _RecruitviewState extends State<RecruitView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            return RenderRecruitView(widget.email, userList);
          default:
            return const Text('Loading...');
        }
      },
    );
  }
}

class RenderRecruitView extends StatefulWidget {
  String email;
  dynamic user_json;
  RenderRecruitView(this.email, this.user_json, {super.key});

  @override
  State<RenderRecruitView> createState() => _RecruitViewState();
}

class _RecruitViewState extends State<RenderRecruitView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            return RecruitPage(widget.email, userList);
          default:
            return const Text('Loading...');
        }
      },
    );
  }
}

class RecruitPage extends StatefulWidget {
  String email;
  dynamic user_json;
  RecruitPage(this.email, this.user_json, {super.key});

  @override
  State<RecruitPage> createState() => _RecruitPageState();
}

class _RecruitPageState extends State<RecruitPage> {
  final _formKey = GlobalKey<FormState>();
  var itCheck = new List.filled(4, false, growable: false);
  var cseCheck = new List.filled(4, false, growable: false);
  var eceCheck = new List.filled(4, false, growable: false);

  Map<String, dynamic> data = {};

  _RecruitPageState() {
    data = {"IT": itCheck, "CSE": cseCheck, "ECE": eceCheck};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text("Recruiting"),
      ),
      body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Description',
                ),
                onChanged: (String? value) {
                  data["desc"] = value;
                },
              ),
            ),
            Column(
              children: [
                DeptCheckBox(itCheck, "IT department"),
                DeptCheckBox(cseCheck, "CSE department"),
                DeptCheckBox(eceCheck, "ECE department"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> final_data = {};
                    dynamic for_map = [];
                    for (int i = 0; i < 4; ++i) {
                      if (data['IT'][i] == true) {
                        int int_batch = i + 2023;
                        String cur_batch = int_batch.toString();
                        for_map.add("IT $cur_batch");
                      }
                    }
                    for (int i = 0; i < 4; ++i) {
                      if (data['CSE'][i] == true) {
                        int cur_batch = i + 2023;
                        for_map.add("CSE $cur_batch");
                      }
                    }
                    for (int i = 0; i < 4; ++i) {
                      if (data['ECE'][i] == true) {
                        int cur_batch = i + 2023;
                        for_map.add("ECE $cur_batch");
                      }
                    }
                    if (for_map.length == 0) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("No Requirement!"),
                          content: const Text("Please choose the recruiting candidates for your club"),
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
                    else {
                      final_data['club'] = widget.user_json[0]['clubs'][0];
                      final_data['description'] = data['desc'];
                      final_data['for'] = for_map;
                      print(final_data);
                      try {
                        database_functions.createRecruit(final_data);
                      }
                      catch (e) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Close Previous Recruitment!"),
                            content: const Text("Your club is already recruiting members"),
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
                    }
                  }
                  else {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("No Description!"),
                        content: const Text("Please give a description for your club recruitment"),
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
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),)
    );
  }
}
