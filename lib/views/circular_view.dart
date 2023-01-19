import 'package:flutter/material.dart';
import 'package:legion/views/circular_list_view.dart';

class CircularView extends StatefulWidget {
  String date;
  String title_text;
  String photo;
  dynamic user_json;
  CircularView(this.photo, this.title_text, this.date, this.user_json, {super.key});

  @override
  State<CircularView> createState() => _CircularViewState();
}

class _CircularViewState extends State<CircularView> {
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
                builder: (context) => CircularListView(widget.user_json),
              ),
            )),
        title: Text(widget.title_text),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: CircularRedirector(widget.photo, widget.title_text, widget.date, widget.user_json),
    ),);
  }
}

class CircularRedirector extends StatelessWidget {
  String date;
  String title_text;
  String photo;
  dynamic user_json;
  CircularRedirector(this.photo, this.title_text, this.date, this.user_json, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => Circular(photo, title_text, date, user_json))));
      },
      child: Column(
        children: [
          AspectRatio(
              aspectRatio: 16 / 7,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(photo, fit: BoxFit.cover),
              )),
          Text(date)
        ],
      ),
    );
  }
}

class Circular extends StatelessWidget {
  String date;
  String title_text;
  String url;
  dynamic user_json;
  final transformationController = TransformationController();
  Circular(this.url, this.title_text, this.date, this.user_json, {Key? key}) : super(key: key);

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
                builder: (context) => CircularView(url, title_text, date, user_json),
              ),
            )),
      ),
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