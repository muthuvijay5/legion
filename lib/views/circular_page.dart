import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class CircularPage extends StatefulWidget {
  const CircularPage({Key? key}) : super(key: key);
  @override
  State<CircularPage> createState() => _CircularPageState();
}

class _CircularPageState extends State<CircularPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection("circulars").snapshots(),
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
