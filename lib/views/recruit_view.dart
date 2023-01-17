import 'dart:io';
import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'dept_checkbox.dart';

class RecruitView extends StatefulWidget {
  String email;
  RecruitView(this.email, {super.key});

  @override
  State<RecruitView> createState() => _RecruitViewState();
}

dynamic database_functions = FirebaseMethods();

class _RecruitViewState extends State<RecruitView> {
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<RecruitPage> createState() => _RecruitPageState();
}

class _RecruitPageState extends State<RecruitPage> {
  final _formKey = GlobalKey<FormState>();
  // List of items in our dropdown menu
  var yearVal = 1;
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
      appBar: AppBar(
        title: const Text("Recruiting"),
      ),
      body: Form(
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
                  // Validate returns true if the form is valid, or false otherwise.
                  print(data);
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
