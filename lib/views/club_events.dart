// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

dynamic database_functions = FirebaseMethods();

class ClubEventView extends StatefulWidget {
  String email;
  ClubEventView(this.email, {super.key});

  @override
  State<ClubEventView> createState() => _ClubEventViewState();
}

class _ClubEventViewState extends State<ClubEventView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', "A"),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            return ClubEventsPage(widget.email, userList);
          default:
            return const Text('Loading...');
        }
      },
    );
  }
}

class ClubEventsPage extends StatefulWidget {
  final String email;
  dynamic user_json;
  ClubEventsPage(this.email, this.user_json,{Key? key}) : super(key: key);
  @override
  State<ClubEventsPage> createState() => _ClubEventsPage();
}

class _ClubEventsPage extends State<ClubEventsPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection("events")
                .where("year", arrayContains: widget.user_json[0]["batch"])
                .where("dept", isEqualTo: widget.user_json[0]["dept"])
                // .orderBy("posted_at", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text("please wait");
              } else {
                // ignore: avoid_print
                log('${snapshot.data!.docs.length}');
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (((context, index) {
                      DocumentSnapshot event = snapshot.data!.docs[index];
                      return Event(
                        title: event['title'],
                        posterImgLink: event['posterImgLink'],
                        desc: event['desc'],
                        phoneNumber: event['phoneNumber'].cast<String>(),
                      );
                    })));
              }
            },
          ))
        ]),
      ),
    );
  }
}

class Event extends StatelessWidget {
  final String posterImgLink;
  final String desc;
  final List<String> phoneNumber;
  final String title;
  const Event(
      {Key? key,
      required this.title,
      required this.posterImgLink,
      required this.desc,
      required this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => EventPage(
                    photo: posterImgLink,
                    description: desc,
                    phone: phoneNumber))));
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(posterImgLink, fit: BoxFit.cover),
            ),
          ),
          Text(title,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

class EventPage extends StatelessWidget {
  final String photo;
  final String description;
  final List<String> phone;
  const EventPage(
      {Key? key,
      required this.photo,
      required this.description,
      required this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(5),
                child: Image.network(photo, fit: BoxFit.cover)),
            Padding(
                padding: const EdgeInsets.all(10), child: Text(description)),
            ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 3);
              },
              shrinkWrap: true,
              itemCount: phone.length,
              itemBuilder: (context, index) {
                return CallButton(phoneNumber: phone[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}

class CallButton extends StatelessWidget {
  final String phoneNumber;
  const CallButton({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [const Icon(Icons.phone), Text(" $phoneNumber")],
          ),
        ));
  }
}
