import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

dynamic database_functions = FirebaseMethods();

class CircularView extends StatefulWidget {
  String email;
  CircularView(this.email, {super.key});

  @override
  State<CircularView> createState() => _CircularViewState();
}

class _CircularViewState extends State<CircularView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            return CircularPage(widget.email, userList);
          default:
            return const Text('Loading...');
        }
      },
    );
  }
}

class CircularPage extends StatefulWidget {
  final String email;
  dynamic user_json;
  CircularPage(this.email, this.user_json, {Key? key}) : super(key: key);
  @override
  State<CircularPage> createState() => _CircularPageState();
}

class _CircularPageState extends State<CircularPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String department = "";
  int year = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection("circulars")
              .where("year", arrayContains: widget.user_json[0]["batch"])
              .where("dept", isEqualTo: widget.user_json[0]["dept"])
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("please wait");
            } else {
              log('${snapshot.data!.docs.length}');
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (((context, index) {
                    DocumentSnapshot circular = snapshot.data!.docs[index];
                    return CircularRedirector(
                        photo: circular["imgLink"], date: DateTime.now());
                  })));
            }
          }),
    )));
  }
}

class CircularRedirector extends StatelessWidget {
  final String photo;
  final DateTime date;
  const CircularRedirector({Key? key, required this.photo, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => Circular(url: photo))));
      },
      child: Column(
        children: [
          AspectRatio(
              aspectRatio: 16 / 7,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(photo, fit: BoxFit.cover),
                // child: FadeInImage.assetNetwork(placeholder: 'assests/loading.jpg', image: photo),
              )),
          Text(date.toString())
        ],
      ),
    );
  }
}

class Circular extends StatelessWidget {
  final String url;
  final transformationController = TransformationController();
  Circular({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InteractiveViewer(
        child: Center(
          child: Image.network(
            url,
          ),
        ),
      ),
    );
  }
}
