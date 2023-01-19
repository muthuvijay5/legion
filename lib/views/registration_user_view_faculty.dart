import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/registrations_list_view.dart';

dynamic database_functions = FirebaseMethods();

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);

class RegistrationUserViewFaculty extends StatelessWidget {
  dynamic user_json;
  String head_email;
  RegistrationUserViewFaculty(this.user_json, this.head_email, {super.key});

  @override
  Widget build(BuildContext context) {
    return RenderProfileView(user_json, head_email);
  }
}

class RenderProfileView extends StatefulWidget {
  dynamic user_json;
  String head_email;
  RenderProfileView(this.user_json, this.head_email, {super.key});

  @override
  State<RenderProfileView> createState() => _RenderProfileViewState();
}

class _RenderProfileViewState extends State<RenderProfileView> {
  void changer() {
    database_functions.activateProfile(widget.user_json['email']);
    Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return RegistrationsListView(widget.head_email);
                },
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
          leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RegistrationsListView(widget.head_email);
        },
      ),
    )
  ),
          title: Text('Profile'),
          centerTitle: true,
          actions: <Widget>[
            TextButton(
              style: flatButtonStyle,
              onPressed: () => changer(),
              child: IconTextPair(Icons.check, 'Accept', Colors.white,),
            ),
          ],
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: ProfilePage(widget.user_json['name'], widget.user_json['email'], widget.user_json['phone'], widget.user_json['sex'], widget.user_json['img_url'], widget.user_json['dob']),
      ),
    ),);
  }
}

class ProfilePage extends StatefulWidget {
  String name;
  String email;
  String phone_number;
  String gender;
  String profile_photo_link;
  String dob;
  ProfilePage(this.name,
              this.email,
              this.phone_number,
              this.gender,
              this.profile_photo_link,
              this.dob,
              {super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryProfileDetails(widget.name, widget.phone_number, widget.gender),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 2.5, 2.5, 0.0),
              child: ProfilePhoto(widget.profile_photo_link),
            ),
          ],
        ),
        CollegeDetails(widget.email, widget.dob),
      ],
    ));
  }
}

class PrimaryProfileDetails extends StatefulWidget {
  String gender;
  String name;
  String phn;
  PrimaryProfileDetails(this.name, this.phn, this.gender, {super.key});

  @override
  State<PrimaryProfileDetails> createState() => _PrimaryProfileDetailsState();
}

class _PrimaryProfileDetailsState extends State<PrimaryProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget> [
        Padding(
          padding: EdgeInsets.fromLTRB(5.0, 15, 0.0, 2.5),
          child: ProfileName(widget.name),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5.0, 2.5, 0.0, 2.5),
          child: ProfilePhoneNumber(widget.phn),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5.0, 2.5, 0.0, 2.5),
          child: ProfileGender(widget.gender),
        ),
      ],
    );
  }
}

class ProfileName extends StatefulWidget {
  String name;
  ProfileName(this.name, {super.key});

  @override
  State<ProfileName> createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.name,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CollegeDetails extends StatefulWidget {
  String email;
  String dob;
  CollegeDetails(this.email, this.dob, {super.key});

  @override
  State<CollegeDetails> createState() => _CollegeDetailsState();
}

class _CollegeDetailsState extends State<CollegeDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(5.0, 2.5, 0.0, 2.5),
            child: ProfileEmail(widget.email),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5.0, 2.5, 0.0, 2.5),
            child: ProfileDOB(widget.dob),
          ),
        ]
      ),
    );
  }
}

class ProfileEmail extends StatefulWidget {
  String email;
  ProfileEmail(this.email, {super.key});

  @override
  State<ProfileEmail> createState() => _ProfileEmailState(email);
}

class _ProfileEmailState extends State<ProfileEmail> {
  String email;
  _ProfileEmailState(this.email);

  @override
  Widget build(BuildContext context) {
    return Text(
      email,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    );
  }
}

class ProfileGender extends StatefulWidget {
  String gender;
  ProfileGender(this.gender, {super.key});

  @override
  State<ProfileGender> createState() => _ProfileGenderState();
}

class _ProfileGenderState extends State<ProfileGender> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.gender,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    );
  }
}

class ProfilePhoneNumber extends StatefulWidget {
  String phn;
  ProfilePhoneNumber(this.phn, {super.key});

  @override
  State<ProfilePhoneNumber> createState() => _ProfilePhoneNumberState();
}

class _ProfilePhoneNumberState extends State<ProfilePhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.phn,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    );
  }
}

class ProfilePhoto extends StatefulWidget {
  String profile_image_url;
  ProfilePhoto(this.profile_image_url, {super.key});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState(profile_image_url);
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  String profile_image_url;
  _ProfilePhotoState(this.profile_image_url);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50.0,
      backgroundImage: NetworkImage(profile_image_url),
    );
  }
}

class IconTextPair extends StatefulWidget {
  IconData icon;
  String text;
  Color color;
  IconTextPair(this.icon, this.text, this.color, {super.key});

  @override
  State<IconTextPair> createState() => _IconTextPairState();
}

class _IconTextPairState extends State<IconTextPair> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          color: widget.color,
          widget.icon,
          size: 20.0,
        ),
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 20.0,
            color: widget.color,
          ),
        ),
      ],
    );
  }
}

class ProfileDOB extends StatefulWidget {
  String dob;
  ProfileDOB(this.dob, {super.key});

  @override
  State<ProfileDOB> createState() => _ProfileDOBState();
}

class _ProfileDOBState extends State<ProfileDOB> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'DOB : ' + widget.dob,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    );
  }
}