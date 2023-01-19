import 'package:flutter/material.dart';
import 'package:legion/views/events_list_view.dart';

class EventsView extends StatefulWidget {
  String date;
  String title_text;
  String photo;
  String desc;
  String phone;
  dynamic user_json;
  EventsView(this.photo, this.title_text, this.date, this.desc, this.phone, this.user_json, {super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
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
                builder: (context) => EventsListView(widget.user_json),
              ),
            )),
        title: Text(widget.title_text),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: EventsRedirector(widget.photo, widget.title_text, widget.date, widget.desc, widget.phone, widget.user_json),
    ),);
  }
}

class EventsRedirector extends StatelessWidget {
  String date;
  String title_text;
  String photo;
  String desc;
  String phone;
  dynamic user_json;
  EventsRedirector(this.photo, this.title_text, this.date, this.desc, this.phone, this.user_json, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => Events(photo, title_text, date, desc, phone, user_json))));
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
        ],
      ),
    );
  }
}

class Events extends StatelessWidget {
  String date;
  String title_text;
  String photo;
  String desc;
  String phone;
  dynamic user_json;
  final transformationController = TransformationController();
  Events(this.photo, this.title_text, this.date, this.desc, this.phone, this.user_json, {Key? key}) : super(key: key);

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
                builder: (context) => EventsView(photo, title_text, date, desc, phone, user_json),
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