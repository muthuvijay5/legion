// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:legion/main.dart';
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:legion/firebase_options.dart';
// import 'package:image_picker/image_picker.dart';
// //import 'package:permission_handler/permission_handler.dart';



// Future<void> main() async {

//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(MyApp());

// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final appTitle = 'Event Form';
//     return MaterialApp(
//       title: appTitle,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(appTitle),
//         ),
//         body: EventForm(),
//       ),
//     );
//   }
// }
// // Create a Form widget.
// class EventForm extends StatefulWidget {
//   const EventForm({super.key});

//   @override
//   EvenFormData createState() {
//     return EvenFormData();
//   }
// }
// class CircularForm extends StatefulWidget {
//   const CircularForm({super.key});

//   @override
//   CircularFormData createState() {
//     return CircularFormData();
//   }
// }

// enum department { IT , CSE , ECE , all , specify,none}

// enum years { First , Second , Third , Four,none }
// class CircularFormData extends State<CircularForm>{

//   final _formKey1 = GlobalKey<FormState>();
//   File? file;
//   ImagePicker? imagePicker;
//   final _formKey = GlobalKey<FormState>();
//   File? upfile;
//   years? _year = years.none;
//   bool? fir = false;
//   bool? sec = false;
//   bool? thi = false;
//   bool? fou = false;
//   bool specific_select =false;
//   final deptname = TextEditingController();

//   final cirname = TextEditingController();

//   File? image;
//   // Future selectImage() async {
//   //   try {
//   //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//   //     if(image == null) return;
//   //     final imageTemp = File(image.path);
//   //     setState(() => this.image = imageTemp);
//   //   }  catch(e) {
//   //     print('Failed to pick image: $e');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Form(
//       key: _formKey1,
//       child: Container(
//         padding: EdgeInsets.all(30),
//         child: Column(


//           children: <Widget>[
//           SizedBox(
//           height: 20,
//         ),
//           Center(
//             child: ElevatedButton(onPressed: selectImageCircular, child: Text('Pick Circular Image')),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//             TextFormField(
//               controller: cirname,
//               validator: (val){
//                 if (val=="") {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(

//                       width: 2, color: Colors.deepPurpleAccent),
//                   borderRadius: BorderRadius.circular(50.0),
//                 ),
//                 hintText: 'Enter Circular Name',
//                 labelText: 'Circular Name',
//               ),
//             ),
//           SizedBox(
//             height: 20,
//           ),
//           TextFormField(
//             controller: deptname,
//             validator: (val){
//               if (val=="") {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(

//                     width: 2, color: Colors.deepPurpleAccent),
//                 borderRadius: BorderRadius.circular(50.0),
//               ),
//               hintText: 'Enter Department Names',
//               labelText: 'Enter Department Names',
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children:<Widget>[
//                   Expanded(child: CheckboxListTile(
//                     title: const Text('1st'),
//                     value: this.fir,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         this.fir = value;
//                       });
//                     },
//                   ),
//                   ),
//                   Expanded(child:    CheckboxListTile(
//                     title: const Text('2nd'),
//                     value: this.sec,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         this.sec = value;
//                       });
//                     },
//                   ),
//                   )
//                   ,
//                   Expanded(child:   CheckboxListTile(
//                     title: const Text('3rd'),
//                     value: this.thi,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         this.thi = value;
//                       });
//                     },
//                   ),

//                   ),
//                   Expanded(child:   CheckboxListTile(
//                     title: const Text('4th'),
//                     value: this.fou,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         this.fou = value;
//                       });
//                     },
//                   )),

//                 ]
//             ),
//           new Container(

//     padding: const EdgeInsets.only(top: 10.0),
//     child: Center(
//     child: new ElevatedButton(
//     child: const Text('Submit'),
//     onPressed: () async{
//         if(_formKey1.currentState!.validate()){

//           String destination = 'files/Circulars';

//           if(_year==department.none){
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text("Please select any options")));
//             return;
//           }
//           String message,dept;
//           dept="";
//           //         final fileup = File(upfile!.path!);

//           if(this.fir==false && this.sec==false && this.thi==false && this.fou==false){


//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select any options")));
//             return;

//           }
//           if(this.fir==true){

//             dept+="1,";


//           }
//           if(this.sec==true){
//             dept+="2,";

//           }
//           if(this.thi==true){
//             dept+="3,";

//           }
//           if(this.fou==true){
//             dept+="4";

//           }


//           try {
//             // Get a reference to the `feedback` collection
//             // final collection =
//             // FirebaseFirestore.instance.collection('feedback');

//             //  final stor = FirebaseStorage.instance.ref(destination).child('file/');
//             //  stor.putFile(image!);
//             // await collection.doc().set({
//             //   'timestamp': FieldValue.serverTimestamp(),
//             //   'departments': deptname.text,
//             //   'years': dept,
//             //   'dept':dept,

//                                 // });
//             dynamic userJson = {
//                              'timestamp': FieldValue.serverTimestamp(),
//                           'departments': deptname.text,
//                          'years': dept,
//                          'dept':dept,
//                          'imageurl':'',
//                     };
                
//             createCircular(userJson);


//             message = 'Form sent successfully';
//           } catch (e) {
//             message = 'Error when sending feedback';
//           }

//           // Show a snackbar with the result
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text(message)));



//         }




//     })))


//     ]







//         ),
//       ),

//     );
//   }

// }





// // Create a corresponding State class. This class holds data related to the form.
// // class EvenFormData extends State<EventForm> {
// //   // Create a global key that uniquely identifies the Form widget
// //   // and allows validation of the form.

// //   File? file;
// //   ImagePicker? imagePicker;
// //   final _formKey = GlobalKey<FormState>();
// //   File? upfile;
// //   department? _site = department.none;
// //   bool? IT_ft = false;
// //   bool? ECE_ft = false;
// //   bool? CSE_ft = false;
// //   bool specific_select =false;
// //   final eventname = TextEditingController();
// //   final eventdescription = TextEditingController();
// //   final phone = TextEditingController();

// //   File? image;
// //   // Future selectImage() async {
// //   //   try {
// //   //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
// //   //     if(image == null) return;
// //   //     final imageTemp = File(image.path);
// //   //     setState(() => this.image = imageTemp);
// //   //   }  catch(e) {
// //   //     print('Failed to pick image: $e');
// //   //   }
// //   // }





// //   @override
// //   Widget build(BuildContext context) {
// //     // Build a Form widget using the _formKey created above.
// //     return Form(
// //       key: _formKey,
// //       child: SingleChildScrollView(


// //       child: Container(
// //         padding: EdgeInsets.all(30),
// //         child: Column(


// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: <Widget>[
// //             SizedBox(
// //               height: 20,
// //             ),
// //             Center(
// //             child: ElevatedButton(onPressed: selectImageEvent, child: Text('Pick Image')),
// //             ),
// //             SizedBox(
// //               height: 10,
// //             ),
// //             TextFormField(
// //               controller: eventname,
// //               validator: (val){
// //                 if (val=="") {
// //                   return 'Please enter some text';
// //                 }
// //                 return null;
// //               },
// //               decoration: InputDecoration(
// //                 border: OutlineInputBorder(
// //                   borderSide: BorderSide(

// //                       width: 2, color: Colors.deepPurpleAccent),
// //                   borderRadius: BorderRadius.circular(50.0),
// //                 ),
// //                 hintText: 'Event Name',
// //                 labelText: 'Event Name',
// //               ),
// //             ),
// //             SizedBox(
// //               height: 10,
// //             ),
// //             TextFormField(

// //               controller: eventdescription,
// //               validator: (val){
// //                 if (val=="") {
// //                   return 'Please enter some text';
// //                 }
// //                 return null;
// //               },
// //               decoration:  InputDecoration(
// //                 hintText: 'Enter event description',
// //                 border: OutlineInputBorder(

// //                   borderSide: BorderSide(

// //                       width: 2, color: Colors.deepPurpleAccent),
// //                   borderRadius: BorderRadius.circular(50.0),
// //                 ),

// //                 labelText: 'Event Description',
// //               ),
// //             ),
// //             ListTile(
// //               title: const Text('All Departments'),
// //               leading: Radio(
// //                 value: department.all,
// //                 groupValue: _site,
// //                 onChanged: (department? value) {
// //                   setState(() {
// //                     _site = value;
// //                     specific_select = false ;
// //                   });

// //                 },
// //               ),
// //             ),
// //             ListTile(
// //               title: const Text('Specific Departments'),
// //               leading: Radio(
// //                 value: department.specify,
// //                 groupValue: _site,
// //                 onChanged: (department? value) {
// //                   setState(() {
// //                     _site = value;
// //                     specific_select = true ;
// //                   });

// //                 },
// //               ),
// //             ),
// //             Visibility( visible: specific_select ,child:Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //     children:<Widget>[
// //     Expanded(child: CheckboxListTile(
// //                 title: const Text('CSE'),
// //                 value: this.CSE_ft,
// //                 onChanged: (bool? value) {
// //                   setState(() {
// //                     this.CSE_ft = value;
// //                   });
// //                 },
// //               ),
// //             ),
// //          Expanded(child:    CheckboxListTile(
// //                 title: const Text('ECE'),
// //                 value: this.ECE_ft,
// //                 onChanged: (bool? value) {
// //                   setState(() {
// //                     this.ECE_ft = value;
// //                   });
// //                 },
// //               ),
// //             )
// //          ,
// //         Expanded(child:   CheckboxListTile(
// //             title: const Text('IT'),
// //             value: this.IT_ft,
// //             onChanged: (bool? value) {
// //               setState(() {
// //                 this.IT_ft = value;
// //               });
// //             },
// //           ),
// //         )

// //     ]
// //             ),
// //             ),
// //             TextFormField(
// //               controller: phone,
// //               validator: (value){
// //                 if (value=="") {
// //                   return 'Mobile can\'t be empty';
// //                 } else  {
// //                   //bool mobileValid = RegExp(r"^(?:\+88||01)?(?:\d{10}|\d{13})$").hasMatch(value);

// //                   bool mobileValid =
// //                   RegExp(r'^[8|9][0-9]{9}$').hasMatch(value!);
// //                   return mobileValid ? null : "Invalid mobile";
// //                 }
// //               },
// //               decoration:  InputDecoration(


// //                 hintText: 'Enter a phone number',
// //                 labelText: 'Phone',
// //                 border:OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(30)
// //                 ),
// //               ),
// //             ),
// //             new Container(

// //                 padding: const EdgeInsets.only(top: 10.0),
// //                 child: Center(
// //                   child: new ElevatedButton(
// //                     child: const Text('Submit'),
// //                     onPressed: () async{
// //                       final destination = 'files/' + eventname.text;

// //                       if(_formKey.currentState!.validate()){

// //                         if(_site==department.none){
// //                           ScaffoldMessenger.of(context)
// //                               .showSnackBar(SnackBar(content: Text("Please select any options")));
// //                           return;
// //                         }
// //                         String message,dept;
// //                         dept="";
// //                         //         final fileup = File(upfile!.path!);
// //                         if(_site==department.all){
// //                           dept="all";
// //                         }
// //                         else if(this.CSE_ft==false && this.IT_ft==false && this.ECE_ft==false){


// //                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select any options")));
// //                          return;

// //                         }
// //                         if(this.CSE_ft==true){

// //                           dept+="CSE,";


// //                         }
// //                         if(this.IT_ft==true){
// //                           dept+="IT,";

// //                         }
// //                         if(this.ECE_ft==true){
// //                           dept+="ECE";

// //                         }


// //                         try {
// //                           // Get a reference to the `feedback` collection
// //                           // final collection =
// //                           // FirebaseFirestore.instance.collection('feedback');
// //                           // //   final ref =FirebaseStorage.instance.ref().child(path);
// //                           // // Write the server's timestamp and the user's feedback
// //                           // // final stor = FirebaseStorage.instance.ref(destination).child('file/');
// //                           // // stor.putFile(image!);
// //                           // await collection.doc().set({
// //                           //   'timestamp': FieldValue.serverTimestamp(),
// //                           //   'eventname': eventname.text,
// //                           //   'eventdescription': eventdescription.text,
// //                           //   'phone':phone.text,
// //                           //   'dept':dept,

// //                           // });
// //                            dynamic userJson = {
// //                              'timestamp': FieldValue.serverTimestamp(),
// //                             'eventname': eventname.text,
// //                             'eventdescription': eventdescription.text,
// //                             'phone':phone.text,
// //                             'dept':dept,
// //                             'imageurl':'',
// //                     };
                
// //                        createEvent(userJson);



// //                           message = 'Feedback sent successfully';
// //                         } catch (e) {
// //                           message = e.toString();
// //                         }

// //                         // Show a snackbar with the result
// //                         ScaffoldMessenger.of(context)
// //                             .showSnackBar(SnackBar(content: Text(message)));



// //                       }


// //                      },
// //                   ),
// //                 )),
// //           ],
// //         ),
// //       )),
// //     );
// //   }
// // }