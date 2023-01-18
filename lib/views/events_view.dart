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
      child: EventsRedirector(widget.photo, widget.date, widget.desc, widget.phone),
    ),);
  }
}

class EventsRedirector extends StatelessWidget {
  final String photo;
  final String date;
  final String desc;
  final String phone;
  EventsRedirector(this.photo, this.date, this.desc, this.phone, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => Events(url: photo))));
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
  final String url;
  final transformationController = TransformationController();
  Events({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
      child: InteractiveViewer(
        child: Center(
          child: Image.network(
            url,
          ),
        ),
      ),
    ),);
  }
}