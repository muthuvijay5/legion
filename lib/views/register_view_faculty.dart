import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/login_view.dart';
import 'package:legion/views/verifyUser_view.dart';
import 'package:legion/views/home_view.dart';

dynamic database_functions = FirebaseMethods();

List faculty_img_flag = [false];

bool? phone_number_validator(String? phoneNumber) {
  if (phoneNumber == '' || phoneNumber == null || phoneNumber.length != 10 || !(("6789").contains(phoneNumber[0]))) {
    return false;
  }
  String numbers = "0123456789";
  for (int i = 1; i < 10; ++i) {
    if (!numbers.contains(phoneNumber[i])) {
      return false;
    }
  }
  return true;
}

bool? isValidDate(String date) {
  final RegExp dateExp = new RegExp(r"((0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4})");
  return dateExp.hasMatch(date);
}

class RegisterViewFaculty extends StatefulWidget {
  String userType;
  RegisterViewFaculty({super.key, required this.userType});
  
  @override
  State<RegisterViewFaculty> createState() =>
      _RegisterViewFacultyState(userType);
}

class _RegisterViewFacultyState extends State<RegisterViewFaculty> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;
  late final TextEditingController _phone;
  late final TextEditingController _dob;
  late final TextEditingController _photoUrl;

  Map<String, dynamic> data = {};

  var gender = ["Male", "Female", "Other"];

  String userType;
  _RegisterViewFacultyState(this.userType);

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    _phone = TextEditingController();
    _dob = TextEditingController();
    _photoUrl = TextEditingController();

    data["sex"] = gender[0];
    faculty_img_flag[0] = false;

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _photoUrl.dispose();
    _phone.dispose();
    _dob.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            )),
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Column(children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('Register as Faculty'),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      controller: _name,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (String? value) {
                        data["name"] = value!;
                      },
                      decoration: const InputDecoration(hintText: 'Name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (String? value) {
                        data["email"] = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Email here'),
                    ),),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _password,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration:
                              const InputDecoration(hintText: 'Password here'),
                          onChanged: (String? value) {
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty || phone_number_validator(value) == false) {
                              return 'Invalid phone number format';
                            }
                            return null;
                          },
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration:
                              const InputDecoration(hintText: 'Phone Number'),
                          onChanged: (String? value) {
                            data["phone"] = value!;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                          ),
                          validator: (value) {
                            if (value == null || value.toString() == "") {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          value: gender[0],
                          items: gender.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items.toString()),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            data["sex"] = value!;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty || isValidDate(value) == false) {
                              return 'DOB format: dd/mm/yyyy';
                            }
                            return null;
                          },
                          controller: _dob,
                          enableSuggestions: false,
                          keyboardType: TextInputType.datetime,
                          autocorrect: false,
                          decoration: const InputDecoration(hintText: 'DOB dd/mm/yyyy'),
                          onChanged: (String? value) {
                            data["dob"] = value!;
                          },
                        )),
                          Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                      child: Center(
                        child: ElevatedButton(
                            onPressed: () async => await database_functions.selectImageUser('2'),
                            child: Text('Choose Profile Picture')),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (faculty_img_flag[0] == true && validate() == true)
                        {
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                          final user = FirebaseAuth.instance.currentUser;
                          await user?.sendEmailVerification();
                          FirebaseMethods fbm = FirebaseMethods();
                          data['admin'] = '2';
                          data['activated'] = false;
                          fbm.createUser(data);
                          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyAndAddUser(),
              ),
            );
                          // print(data);
                          // print("Validate");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Weak Password"),
                                content: const Text(
                                    "The password you have given is too weak"),
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
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (e.code == 'email-already-in-user') {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("User Already Exists!"),
                                content: const Text(
                                    "The e-mail you have given is already exists"),
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
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (e.code == 'invalid-email') {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Invalid E-mail!"),
                                content: const Text(
                                    "The e-mail you have given is invalid"),
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
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      }
                      
                      else if (faculty_img_flag[0] == false) {
                        showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("No Profile Image"),
                                  content: const Text(
                                      "You haven't chosen any profile image"),
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
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      }
                      else {
                        showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Invalid Input(s)!"),
                                  content: const Text(
                                      "Please provide inputs in the correct format"),
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
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      }
                      },
                      child: const Text('Register'),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginView(),
              ),
            );
                        },
                        child: const Text('Already an user? Login!'))
                  ],
                )),
          ]),
        ],
      ),
    );
  }
  bool validate() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }
}
