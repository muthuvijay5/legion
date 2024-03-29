import 'dart:io';
import 'package:legion/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:legion/views/faculty_home_view.dart';
import 'package:legion/views/loading_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dept_checkbox.dart';

dynamic database_functions = FirebaseMethods();

List circular_img_flag = [false];

class CircularFormView extends StatefulWidget {
  String email;
  CircularFormView(this.email, {super.key});

  @override
  State<CircularFormView> createState() => _CircularFormViewState();
}

String get_cur_date() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(now);
  return formattedDate;
}

class _CircularFormViewState extends State<CircularFormView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            return CircularForm(widget.email, userList);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

class CircularForm extends StatefulWidget {
  String email;
  dynamic userList;
  
  CircularForm(this.email, this.userList, {super.key});

  @override
  CircularFormData createState() {
    return CircularFormData();
  }
}



class CircularFormData extends State<CircularForm>{

  final _formKey1 = GlobalKey<FormState>();
  File? file;
  ImagePicker? imagePicker;
  final _formKey = GlobalKey<FormState>();
  File? upfile;
  var itCheck = new List.filled(4, false, growable: false);
  var cseCheck = new List.filled(4, false, growable: false);
  var eceCheck = new List.filled(4, false, growable: false);
  Map<String, dynamic> data = {};
  final cirname = TextEditingController();
  File? image;

  CircularFormData() {
    data = {"IT": itCheck, "CSE": cseCheck, "ECE": eceCheck};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => 
    Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FacultyHomeView(widget.email),
              ),
            )
  ),
        title: const Text('Announcement'), centerTitle: true,),
      body: SingleChildScrollView(
      child: Form(
      key: _formKey1,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(


          children: <Widget>[
          SizedBox(
          height: 20,
        ),
          Center(
            child: ElevatedButton(onPressed: database_functions.selectImageCircular, child: Text('Pick Circular Image')),
          ),
          SizedBox(
            height: 10,
          ),
            TextFormField(
              controller: cirname,
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
                hintText: 'Enter Circular Name',
                labelText: 'Circular Name',
              ),
            ),
          SizedBox(
            height: 20,
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
      if (circular_img_flag[0] == false) {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("No Image!"),
                              content: const Text("Please choose the circular poster/image"),
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
        if(_formKey1.currentState!.validate()){
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
              'name': cirname.text,
                             'timestamp': get_cur_date(),
                         'for':for_map,
                         'imageurl':'',
                    };
                
            database_functions.createCircular(userJson);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FacultyHomeView(widget.email),
              ),
            );
          } catch (e) {
            // print(e);
          }
          }

          
        }
    })))


    ]
        ),
      ),
    )));
  }
}