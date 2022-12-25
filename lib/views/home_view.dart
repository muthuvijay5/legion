import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:legion/views/register_view.dart';
import 'package:legion/firebase_methods.dart';

FirebaseMethods some = FirebaseMethods();

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Select user')),
//       body: Column(children: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => RegisterView(
//                       admin: false,
//                       userType: "Student",
//                     )));
//           },
//           child: const Text('Student'),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => RegisterView(
//                       admin: true,
//                       userType: "Staff",
//                     )));
//           },
//           child: const Text('Staff'),
//         ),
//         RaisedButton(
//           onPressed: () {
//             StepState
//           },
//         ),
//       ]),
//     );
//   }
// }

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select user')),
      body: Column(children: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterView(
                      admin: false,
                      userType: "Student",
                    )));
          },
          child: const Text('Student'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterView(
                      admin: true,
                      userType: "Staff",
                    )));
          },
          child: const Text('Staff'),
        ),
        TextButton(
          child: Text("Fuck"),
          onPressed: () {
            //setState(() {
            //updateProfileDetails("A", "name", "punda");
            dynamic circularJson = {
              'imgLink': "Link",
              'dateTime': '223',
              'postedBy': 'xyz',
              'yearDept': {
                'u1': ['dept', 123]
              },
            };

            dynamic eventJson = {
              'title': 'useless event',
              'dateTime': 'dt',
              'phoneName': ['123', '123'],
              'posterImgLink': 'link',
              'desc': 'des'
            };
            some.deleteCircular('Link').then((bool res) {
              print(res);
            });

            //});
          },
        )
      ]),
    );
  }
}
