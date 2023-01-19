import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legion/views/home_view.dart';

// ignore: must_be_immutable
class VerifyAndAddUser extends StatefulWidget {
  VerifyAndAddUser({Key? key})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<VerifyAndAddUser> createState() =>
      _VerifyAndAddUserState();
}

class _VerifyAndAddUserState extends State<VerifyAndAddUser> {
  String emailMessage = '';
  _VerifyAndAddUserState();
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
        title: const Text('Verify your E-mail')),
      body: SingleChildScrollView(
      child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text('Please check your e-mail for verification link'),
          ),
          Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.currentUser?.reload();
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                // print('Email verified');
                setState(() {
                  emailMessage = "E-mail verified and user added";
                });
              } else {
                setState(() {
                  emailMessage = "E-mail not verified yet";
                });
              }
            },
            child: const Text('Reload'),
          )),
          Text(emailMessage),
        ],
      ),
    )),);
  }
}
