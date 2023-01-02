import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  late final TextEditingController _email;
  late final TextEditingController _password;

  bool admin;
  String userType;
  _RegisterViewState(this.admin, this.userType);

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
      appBar: AppBar(
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => 
    Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeView(
                    )))
  ),
        title: const Text('Register'), centerTitle: true,),
      body: Column(
        children: [
          Text('Register as $userType'),
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email here'),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
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
                print(e);
                if (e.code == 'weak-password') {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Weak Password"),
                      content: const Text("The password you have given is too weak"),
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
                } else if (e.code == 'email-already-in-use') {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("User Already Exists!"),
                      content: const Text("The e-mail you have given is already exists"),
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
                } else if (e.code == 'invalid-email') {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Invalid E-mail!"),
                      content: const Text("The e-mail you have given is invalid"),
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
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              },
              child: const Text('Already an user? Login!'))
        ],
      ),
    );
  }
}
