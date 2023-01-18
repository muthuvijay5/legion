import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legion/views/choose_home_view.dart';
import 'package:legion/views/home_view.dart';
import 'package:legion/views/verifyUser_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

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
        builder: (context) => HomeView(),
      ),
    )
  ),
        title: const Text('Login'), centerTitle: true,),
      body: SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email here'),
          ),
          Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
          child: TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Password here'),
          )),
          ElevatedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              if (password == '' || password == null || email == '' || email == null) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Empty Input(s)!"),
                      content: const Text("Please provide valid input"),
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
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                if (userCredential != null) {
                  if (FirebaseAuth.instance.currentUser?.emailVerified ??
                      false) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseView(email),
                          ),
                        );
                  } else {
                    Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyAndAddUser(),
              ),
            );
                  }
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found' || e.code == 'invalid-email') {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("User Not Found!"),
                      content: const Text("The e-mail you have given is not registered yet"),
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
                } else if (e.code == 'wrong-password') {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Wrong Password!"),
                      content: const Text("The password doesn't match the given credentials"),
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
              }}
            },
            child: const Text('Login!'),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeView(),
                  ),
                );
              },
              child: const Text('Not registered yet? Register now!'))
        ],
      ),
    ),);
  }
}
