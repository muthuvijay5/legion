import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/verifyUser_view.dart';
import 'package:legion/views/home_view.dart';

// ignore: must_be_immutable
class RegisterView extends StatefulWidget {
  bool admin;
  String userType;
  RegisterView({super.key, required this.admin, required this.userType});
  @override
  // ignore: no_logic_in_create_state
  State<RegisterView> createState() => _RegisterViewState(admin, userType);
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _roll;
  late final TextEditingController _phone;
  late final TextEditingController _dob;
  late final TextEditingController _photoUrl;

  int startYear = 2020;
  int endYear = 2030;
  String dropdownvalue = "2020";
  String genderValue = "Male";

  Map<String, dynamic> data = {};

  // List of items in our dropdown menu
  var gender = ["Male", "Female", "Other"];
  var items = [
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030",
  ];
  var dept = ["CSE", "IT", "ECE"];

  bool admin;
  String userType;
  _RegisterViewState(this.admin, this.userType);

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _roll = TextEditingController();
    _phone = TextEditingController();
    _dob = TextEditingController();
    _photoUrl = TextEditingController();

    data["sex"] = genderValue;
    data["batch"] = dropdownvalue;
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _roll.dispose();
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
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeView()))),
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
                    Text('Register as Student'),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
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
                    ),
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
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _roll,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration:
                              const InputDecoration(hintText: 'Roll Number'),
                          onChanged: (String? value) {
                            data["roll"] = value!;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
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
                            labelText: 'Sex',
                          ),
                          validator: (value) {
                            if (value == null || value.toString() == "") {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          value: genderValue,
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
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _dob,
                          enableSuggestions: false,
                          keyboardType: TextInputType.datetime,
                          autocorrect: false,
                          decoration: const InputDecoration(hintText: 'DOB'),
                          onChanged: (String? value) {
                            data["dob"] = value!;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _photoUrl,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                              hintText: 'Photo Image Link'),
                          onChanged: (String? value) {
                            data["photoUrl"] = value!;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: 'Department',
                          ),
                          validator: (value) {
                            if (value == null || value.toString() == "") {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          value: dept[0],
                          items: dept.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items.toString()),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            data["dept"] = value!;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: 'Batch',
                          ),
                          validator: (value) {
                            if (value == null || value.toString() == "") {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          value: dropdownvalue,
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items.toString()),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            data["batch"] = value!;
                          },
                        )),
                    ElevatedButton(
                      onPressed: () async {
                        validate();
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                          final user = FirebaseAuth.instance.currentUser;
                          await user?.sendEmailVerification();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyAndAddUser(
                                        admin: admin,
                                        userType: userType,
                                      )),
                              (route) => false);
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
                      },
                      child: const Text('Register'),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (route) => false);
                        },
                        child: const Text('Already an user? Login!'))
                  ],
                )),
          ]),
        ],
      ),
    );
  }

  void validate() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
    FirebaseMethods fbm = FirebaseMethods();
    fbm.createUser(data);
    print(data);
    print("Validate");
  }
}
