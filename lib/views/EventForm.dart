import 'dart:io';
import 'package:legion/views/loading_view.dart';
import 'package:legion/views/staff_home_view.dart';
import 'dept_checkbox.dart';
import 'package:legion/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

dynamic database_functions = FirebaseMethods();
List club_img_flag = [false];

class EventFormView extends StatefulWidget {
  String email;
  EventFormView(this.email, {super.key});

  @override
  State<EventFormView> createState() => _EventFormViewState();
}

String get_cur_date() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(now);
  return formattedDate;
}

class _EventFormViewState extends State<EventFormView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            return EventForm(widget.email, userList);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class EventForm extends StatefulWidget {
  dynamic user_json;
  String email;
  EventForm(this.email, this.user_json, {super.key});

  @override
  EvenFormData createState() {
    return EvenFormData();
  }
}

class EvenFormData extends State<EventForm> {
  File? file;
  ImagePicker? imagePicker;
  final _formKey = GlobalKey<FormState>();
  File? upfile;
  bool? IT_ft = false;
  bool? ECE_ft = false;
  bool? CSE_ft = false;
  final eventname = TextEditingController();
  final eventdescription = TextEditingController();
  final phone = TextEditingController();
  var itCheck = new List.filled(4, false, growable: false);
  var cseCheck = new List.filled(4, false, growable: false);
  var eceCheck = new List.filled(4, false, growable: false);
  Map<String, dynamic> data = {};

  EvenFormData() {
    data = {"IT": itCheck, "CSE": cseCheck, "ECE": eceCheck};
  }

  File? image;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => 
    Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StaffHomeView(widget.email),
              ),
            )
  ),
        title: const Text('Announce Event'), centerTitle: true,),
      body: SingleChildScrollView(
      child: Form(
      key: _formKey,
      child: SingleChildScrollView(


      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(


          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
            child: ElevatedButton(onPressed: database_functions.selectImageEvent, child: Text('Pick Image')),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: eventname,
              validator: (val){
                if (val=="") {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(

                      width: 2, color: Colors.deepPurpleAccent),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: 'Event Name',
                labelText: 'Event Name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(

              controller: eventdescription,
              validator: (val){
                if (val=="") {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration:  InputDecoration(
                hintText: 'Enter event description',
                border: OutlineInputBorder(

                  borderSide: BorderSide(

                      width: 2, color: Colors.deepPurpleAccent),
                  borderRadius: BorderRadius.circular(50.0),
                ),

                labelText: 'Event Description',
              ),
            ),
            SizedBox(
            height: 10,
          ),
            TextFormField(
              controller: phone,
              validator: (value){
                if (value=="") {
                  return 'Mobile can\'t be empty';
                } else  {
                  //bool mobileValid = RegExp(r"^(?:\+88||01)?(?:\d{10}|\d{13})$").hasMatch(value);

                  bool mobileValid =
                  RegExp(r'^[8|9][0-9]{9}$').hasMatch(value!);
                  return mobileValid ? null : "Invalid mobile";
                }
              },
              decoration:  InputDecoration(


                hintText: 'Enter a phone number',
                labelText: 'Phone',
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                DeptCheckBox(itCheck, "IT department"),
                DeptCheckBox(cseCheck, "CSE department"),
                DeptCheckBox(eceCheck, "ECE department"),
              ],
            ),
            new Container(

              padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: new ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () async{
                      if (club_img_flag[0] == false) {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("No Image!"),
                              content: const Text("Please choose the event poster/image"),
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
                          return;
                      }

                      if(_formKey.currentState!.validate()){
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
                        
                        if (for_map.length == 0){
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
                          try {
                            dynamic userJson = {
                              'timestamp': get_cur_date(),
                              'eventname': eventname.text,
                              'eventdescription': eventdescription.text,
                              'phone':phone.text,
                              'for': for_map,
                              'imageurl':'',
                            };
                            database_functions.createEvent(userJson);
                            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StaffHomeView(widget.email),
              ),
            );
                          } catch (e) {
                            String message = e.toString();
                            // print(message);
                          }
                        }
                      }
                     },
                  ),
                )),
          ],
        ),
      )),
    )
    ),);
  }
}