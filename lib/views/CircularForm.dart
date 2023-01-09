import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/main.dart';
import 'package:flutter/material.dart';
import 'package:legion/views/home_view.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:legion/firebase_options.dart';
import 'package:image_picker/image_picker.dart';

enum department { IT , CSE , ECE , all , specify,none}

dynamic database_functions = FirebaseMethods();

enum years { First , Second , Third , Four,none }

class CircularFormView extends StatefulWidget {
  String email;
  CircularFormView(this.email, {super.key});

  @override
  State<CircularFormView> createState() => _CircularFormViewState();
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
            return const Text('Loading...');
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
  years? _year = years.none;
  bool? fir = false;
  bool? sec = false;
  bool? thi = false;
  bool? fou = false;
  bool specific_select =false;
  final deptname = TextEditingController();

  final cirname = TextEditingController();

  File? image;
  // Future selectImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if(image == null) return;
  //     final imageTemp = File(image.path);
  //     setState(() => this.image = imageTemp);
  //   }  catch(e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => 
    Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeView(
                    )))
  ),
        title: const Text('Login'), centerTitle: true,),
      body: Form(
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
          TextFormField(
            controller: deptname,
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
              hintText: 'Enter Department Names',
              labelText: 'Enter Department Names',
            ),
          ),
          SizedBox(
            height: 10,
          ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  Expanded(child: CheckboxListTile(
                    title: const Text('1st'),
                    value: this.fir,
                    onChanged: (bool? value) {
                      setState(() {
                        this.fir = value;
                      });
                    },
                  ),
                  ),
                  Expanded(child:    CheckboxListTile(
                    title: const Text('2nd'),
                    value: this.sec,
                    onChanged: (bool? value) {
                      setState(() {
                        this.sec = value;
                      });
                    },
                  ),
                  )
                  ,
                  Expanded(child:   CheckboxListTile(
                    title: const Text('3rd'),
                    value: this.thi,
                    onChanged: (bool? value) {
                      setState(() {
                        this.thi = value;
                      });
                    },
                  ),

                  ),
                  Expanded(child:   CheckboxListTile(
                    title: const Text('4th'),
                    value: this.fou,
                    onChanged: (bool? value) {
                      setState(() {
                        this.fou = value;
                      });
                    },
                  )),

                ]
            ),
          new Container(

    padding: const EdgeInsets.only(top: 10.0),
    child: Center(
    child: new ElevatedButton(
    child: const Text('Submit'),
    onPressed: () async{
        if(_formKey1.currentState!.validate()){

          String destination = 'files/Circulars';

          if(_year==department.none){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Please select any options")));
            return;
          }
          String message,dept;
          dept="";
          //         final fileup = File(upfile!.path!);

          if(this.fir==false && this.sec==false && this.thi==false && this.fou==false){


            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select any options")));
            return;

          }
          if(this.fir==true){

            dept+="1,";


          }
          if(this.sec==true){
            dept+="2,";

          }
          if(this.thi==true){
            dept+="3,";

          }
          if(this.fou==true){
            dept+="4";

          }


          try {
            // Get a reference to the `feedback` collection
            // final collection =
            // FirebaseFirestore.instance.collection('feedback');

            //  final stor = FirebaseStorage.instance.ref(destination).child('file/');
            //  stor.putFile(image!);
            // await collection.doc().set({
            //   'timestamp': FieldValue.serverTimestamp(),
            //   'departments': deptname.text,
            //   'years': dept,
            //   'dept':dept,

                                // });
            dynamic userJson = {
                             'timestamp': FieldValue.serverTimestamp(),
                          'departments': deptname.text,
                         'years': dept,
                         'dept':dept,
                         'imageurl':'',
                    };
                
            database_functions.createCircular(userJson);


            message = 'Form sent successfully';
          } catch (e) {
            message = 'Error when sending feedback';
          }

          // Show a snackbar with the result
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));



        }




    })))


    ]







        ),
      ),

    ));
  }

}

