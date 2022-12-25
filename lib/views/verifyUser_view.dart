import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VerifyAndAddUser extends StatefulWidget {
  bool admin;
  String userType;
  VerifyAndAddUser({Key? key, required this.admin, required this.userType})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<VerifyAndAddUser> createState() =>
      _VerifyAndAddUserState(admin, userType);
}

class _VerifyAndAddUserState extends State<VerifyAndAddUser> {
  String emailMessage = '';
  bool admin;
  String userType;
  _VerifyAndAddUserState(this.admin, this.userType);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify your email')),
      body: Column(
        children: [
          const Text('Please check your email for verification link'),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.currentUser?.reload();
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                //const Text('Email verified!');
                print('Email verified');
                final CollectionReference userCollection =
                    FirebaseFirestore.instance.collection('users');
                final userJson = {
                  'name': user?.email,
                  'admin': admin,
                };
                userCollection.doc(user?.uid).set(userJson);
                setState(() {
                  emailMessage = "Email verified and user added as $userType";
                });
              } else {
                setState(() {
                  emailMessage = "Email not verified";
                });
                //const Text('Email not verified! Check again');
                print('Email not verified');
              }
            },
            child: const Text('Reload'),
          ),
          Text(emailMessage),
        ],
      ),
    );
  }
}
