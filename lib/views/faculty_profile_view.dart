import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';
import 'package:legion/views/loading_view.dart';
import 'package:legion/views/faculty_home_view.dart';

String name = "";
String phone_number = "";
dynamic edit_or_display_name;
dynamic edit_or_display_phone_number;

dynamic database_functions = FirebaseMethods();

dynamic get_user(email) {
  dynamic val;
  get_user(email).then((value) => val = value);
  return val;
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);



class FacultyProfileView extends StatefulWidget {
  String email;
  FacultyProfileView(this.email, {super.key});

  @override
  State<FacultyProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<FacultyProfileView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            return ProfileViewTmp(userList);
          default:
            return const LoadingView();
        }
      },
    );
  }
}

bool? name_validator(String? name) {
  if (name == '' || name == null || name[0] == ' ' || name[name.length - 1] == ' ') {
    return false;
  }
  String alphabets = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  int spaceCount = 0;
  for (int i = 0; i < name.length; ++i) {
    if (name[i] == ' ') {
      if (name[i - 1] == ' ') {
        return false;
      }
      ++spaceCount;
    } else if (!alphabets.contains(name[i])) {
      return false;
    }
  }
  if (spaceCount >= 5) {
    return false;
  }
  return true;
}

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

class ProfileViewTmp extends StatelessWidget {
  dynamic user_json;
  ProfileViewTmp(this.user_json, {super.key});

  @override
  Widget build(BuildContext context) {
    return RenderProfileView(user_json);
  }
}

class RenderProfileView extends StatefulWidget {
  dynamic user_json;
  RenderProfileView(this.user_json, {super.key});

  @override
  State<RenderProfileView> createState() => _RenderProfileViewState();
}

class _RenderProfileViewState extends State<RenderProfileView> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController phone_number_controller = TextEditingController();

  String name = '';
  String phone_number = "";
  dynamic edit_or_display_name = ProfileName();
  dynamic edit_or_display_phone_number = ProfilePhoneNumber();
  dynamic edit_or_save_icon = Icons.edit;
  dynamic edit_or_save_text = "Edit";
  String error_message = "";

  void assign_values() {
    print(widget.user_json);
    name = widget.user_json[0]['name'];
    phone_number = widget.user_json[0]['phone'].toString();
  }

  dynamic get_name() {
    return name_controller.text;
  }

  void clear_name() {
    name_controller.text = "";
  }

  dynamic get_phone_number() {
    return phone_number_controller.text;
  }

  void clear_phone_number() {
    phone_number_controller.text = "";
  }

  void changer() {
    setState(() {
      if (edit_or_display_name.runtimeType == NameField) {
        String newName = get_name();
        String newPhoneNumber = get_phone_number();
        if (name_validator(newName) == true && phone_number_validator(newPhoneNumber) == true) {
          name = newName;
          phone_number = newPhoneNumber;
          database_functions.updateProfileDetails(widget.user_json[0]['email'], 'name', name);
          database_functions.updateProfileDetails(widget.user_json[0]['email'], 'phone', phone_number);
          clear_name();
          clear_phone_number();
          edit_or_display_name = ProfileName();
          edit_or_display_phone_number = ProfilePhoneNumber();
          edit_or_save_icon = Icons.edit;
          edit_or_save_text = "Edit";
          error_message = "";
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FacultyProfileView(widget.user_json[0]['email']);
              },
            ),
          );
        } else {
          if (name_validator(newName) == false) {
            error_message = "Invalid format for name!";
          } else {
            error_message = "Invalid format for phone number!";
          }
        }
      } else {
        edit_or_display_name = NameField(name_controller, get_name, clear_name);
        edit_or_display_phone_number = PhoneNumberField(phone_number_controller, get_phone_number, clear_phone_number);
        edit_or_save_icon = Icons.save;
        edit_or_save_text = "Save";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    assign_values();
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
          return FacultyHomeView(widget.user_json[0]['email']);
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
              child: IconTextPair(edit_or_save_icon, edit_or_save_text, Colors.white,),
            ),
          ],
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: ProfilePage(name, widget.user_json[0]['email'], phone_number, widget.user_json[0]['sex'], widget.user_json[0]['img_url'], edit_or_display_name, edit_or_display_phone_number, error_message, widget.user_json[0]['dob']),
      ),
    ),);
  }
}

class ProfilePage extends StatefulWidget {
  String name_param;
  String email;
  String phone_number_param;
  String gender;
  String profile_photo_link;
  dynamic edit_or_display_name_param;
  dynamic edit_or_display_phone_number_param;
  String error_message;
  String dob;
  ProfilePage(this.name_param,
              this.email,
              this.phone_number_param,
              this.gender,
              this.profile_photo_link,
              this.edit_or_display_name_param,
              this.edit_or_display_phone_number_param,
              this.error_message,
              this.dob,
              {super.key}) {
    name = this.name_param;
    phone_number = this.phone_number_param;
    edit_or_display_name = this.edit_or_display_name_param;
    edit_or_display_phone_number = edit_or_display_phone_number_param;
  }

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
            PrimaryProfileDetails(widget.gender),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 2.5, 2.5, 0.0),
              child: ProfilePhoto(widget.profile_photo_link),
            ),
          ],
        ),
        CollegeDetails(widget.email, widget.dob),
        ErrorDisplay(widget.error_message),
      ],
    ));
  }
}

class PrimaryProfileDetails extends StatefulWidget {
  String gender;
  PrimaryProfileDetails(this.gender, {super.key});

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
          child: edit_or_display_name,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5.0, 2.5, 0.0, 2.5),
          child: edit_or_display_phone_number,
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
  ProfileName({super.key});

  @override
  State<ProfileName> createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
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
  ProfilePhoneNumber({super.key});

  @override
  State<ProfilePhoneNumber> createState() => _ProfilePhoneNumberState();
}

class _ProfilePhoneNumberState extends State<ProfilePhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Text(
      phone_number,
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

class NameField extends StatefulWidget {
  TextEditingController name_controller;
  Function get_name;
  Function clear_name;
  NameField(this.name_controller, this.get_name, this.clear_name, {super.key});

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.0,
      width: MediaQuery.of(context).size.width * 0.58,
      child: TextFormField(
        controller: widget.name_controller,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: "Update your name",
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class PhoneNumberField extends StatefulWidget {
  TextEditingController phone_number_controller;
  Function get_phone_number;
  Function clear_phone_number;
  PhoneNumberField(this.phone_number_controller, this.get_phone_number, this.clear_phone_number, {super.key});

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: SizedBox(
        height: 35.0,
        width: MediaQuery.of(context).size.width * 0.58,
        child: TextFormField(
          controller: widget.phone_number_controller,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: "Update your Phone No.",
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            border: OutlineInputBorder(),
          ),
        ),
      )
    );
  }
}

class ErrorDisplay extends StatefulWidget {
  String error_message;
  ErrorDisplay(this.error_message, {super.key});

  @override
  State<ErrorDisplay> createState() => _ErrorDisplayState();
}

class _ErrorDisplayState extends State<ErrorDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(7.0, 7.0, 7.0, 7.0),
            child: Text(
              widget.error_message,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
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