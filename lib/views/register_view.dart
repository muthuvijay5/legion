import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legion/views/verifyUser_view.dart';

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
      appBar: AppBar(title: const Text('Register')),
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
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Password here'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                print(userCredential);
                // ignore: use_build_context_synchronously
                // Navigator.of(context)
                //     .pushNamedAndRemoveUntil('/emailVerify', (route) => false);
                // ignore: use_build_context_synchronously
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
                  print('Weak Password');
                } else if (e.code == 'email-already-in-user') {
                  print('Email is already in use');
                } else if (e.code == 'invalid-email') {
                  print('Invalid Email');
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
              child: const Text('Already a user? Login!'))
        ],
      ),
    );
  }
}
