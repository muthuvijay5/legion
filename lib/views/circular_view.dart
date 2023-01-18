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
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CircularListView(widget.user_json)))),
        title: Text(widget.title_text),
        centerTitle: true,
      ),
      body: CircularRedirector(widget.photo, widget.date),
    );
  }
}

class CircularRedirector extends StatelessWidget {
  final String photo;
  final String date;
  const CircularRedirector(this.photo, this.date, {Key? key})
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
          Text(date)
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