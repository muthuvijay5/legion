import 'package:flutter/material.dart';
import 'package:legion/views/staff_events_list_view.dart';

class StaffEventView extends StatefulWidget {
  String date;
  String title_text;
  String photo;
  String desc;
  String phone;
  String docId;
  dynamic user_json;
  StaffEventView(this.photo, this.title_text, this.date, this.desc, this.phone, this.docId, this.user_json, {super.key});

  @override
  State<StaffEventView> createState() => _StaffEventViewState();
}

class _StaffEventViewState extends State<StaffEventView> {
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
                builder: (context) => StaffEventListView(widget.user_json['email']),
              ),
            )),
        title: Text(widget.title_text),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: StaffEventRedirector(widget.photo, widget.title_text, widget.date, widget.desc, widget.phone, widget.docId, widget.user_json),
    ),);
  }
}

class StaffEventRedirector extends StatelessWidget {
  String date;
  String title_text;
  String photo;
  String desc;
  String phone;
  String docId;
  dynamic user_json;
  StaffEventRedirector(this.photo, this.title_text, this.date, this.desc, this.phone, this.docId, this.user_json, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => AStaffEvent(this.photo, this.title_text, this.date, this.desc, this.phone, this.docId, this.user_json))));
      },
      child: Column(
        children: [
          AspectRatio(
              aspectRatio: 16 / 7,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(photo, fit: BoxFit.cover),
              )),
          Text(desc),
          Text('Contact: ' + phone),
          Text(date),
          Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Delete!"),
                                  content: const Text("Please confirm that you want to delete the ciircular"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        database_functions.deleteEvent(docId);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => StaffEventListView(user_json['email']),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        color: Colors.blue,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text(
                                          "Confirm",
                                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: IconTextPair(Icons.delete, 'Delete', Colors.white),
                          ),
                      ),
                    ),
        ],
      ),
    );
  }
}

class AStaffEvent extends StatelessWidget {
  String date;
  String title_text;
  String photo;
  String desc;
  String phone;
  String docId;
  dynamic user_json;
  final transformationController = TransformationController();
  AStaffEvent(this.photo, this.title_text, this.date, this.desc, this.phone, this.docId, this.user_json, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => 
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StaffEventView(this.photo, this.title_text, this.date, this.desc, this.phone, this.docId, this.user_json),
              ),
            )),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
      child: InteractiveViewer(
        child: Center(
          child: Image.network(
            photo,
          ),
        ),
      ),
    ),);
  }
}

class IconTextPair extends StatefulWidget {
  IconData icon;
  String text;
  Color color;
  IconTextPair(this.icon, this.text, this.color, {super.key});

  @override
  State<IconTextPair> createState() => _IconTextPairState();
}

class _IconTextPairState extends State<IconTextPair> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          color: widget.color,
          widget.icon,
          size: 20.0,
        ),
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 20.0,
            color: widget.color,
          ),
        ),
      ],
    );
  }
}