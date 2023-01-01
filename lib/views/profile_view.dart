import 'package:flutter/material.dart';

String name = "";
String phone_number = "";
dynamic edit_or_display_name;
dynamic edit_or_display_phone_number;

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);

bool? name_validator(String? name) {
  if (name == '' || name == null || name[0] == ' ' || name[name.length - 1] == ' ') {
    return false;
  }
  String alphabets = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  int space_count = 0;
  for (int i = 0; i < name.length; ++i) {
    if (name[i] == ' ') {
      if (name[i - 1] == ' ') {
        return false;
      }
      ++space_count;
    } else if (!alphabets.contains(name[i])) {
      return false;
    }
  }
  if (space_count >= 5) {
    return false;
  }
  return true;
}

bool? phone_number_validator(String? phone_number) {
  if (phone_number == '' || phone_number == null || phone_number.length != 10 || !(("6789").contains(phone_number[0]))) {
    return false;
  }
  String numbers = "0123456789";
  for (int i = 1; i < 10; ++i) {
    if (!numbers.contains(phone_number[i])) {
      return false;
    }
  }
  return true;
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return RenderProfileView();
  }
}

class RenderProfileView extends StatefulWidget {
  const RenderProfileView({super.key});

  @override
  State<RenderProfileView> createState() => _RenderProfileViewState();
}

class _RenderProfileViewState extends State<RenderProfileView> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController phone_number_controller = TextEditingController();

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

  String name = "Muthu Vijay";
  String phone_number = "8825761030";
  dynamic edit_or_display_name = ProfileName();
  dynamic edit_or_display_phone_number = ProfilePhoneNumber();
  dynamic edit_or_save_icon = Icons.edit;
  dynamic edit_or_save_text = "Edit";
  String error_message = "";

  void changer() {
    setState(() {
      if (edit_or_display_name.runtimeType == NameField) {
        String new_name = get_name();
        String new_phone_number = get_phone_number();
        if (name_validator(new_name) == true && phone_number_validator(new_phone_number) == true) {
          name = new_name;
          phone_number = new_phone_number;
          clear_name();
          clear_phone_number();
          edit_or_display_name = ProfileName();
          edit_or_display_phone_number = ProfilePhoneNumber();
          edit_or_save_icon = Icons.edit;
          edit_or_save_text = "Edit";
          error_message = "";
        } else {
          if (name_validator(new_name) == false) {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: <Widget>[
            TextButton(
              style: flatButtonStyle,
              onPressed: () => changer(),
              child: IconTextPair(edit_or_save_icon, edit_or_save_text, Color.fromARGB(255, 140, 193, 236),),
            ),
          ],
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.teal,
        body: ProfilePage(name, "20i330@psgtech.ac.in", "20I330", phone_number, "2024", "IT", "Male", ["Subash", "Akash", "Hari", "Shankar", "Pradhip", "Kumar", "Muthu", "Vijay"], 'https://www.pixelstalk.net/wp-content/uploads/2016/06/Jungle-HD-Images.jpg', edit_or_display_name, edit_or_display_phone_number, error_message),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  String name_param;
  String email;
  String roll_number;
  String phone_number_param;
  String batch;
  String department;
  String gender;
  List clubs;
  String profile_photo_link;
  dynamic edit_or_display_name_param;
  dynamic edit_or_display_phone_number_param;
  String error_message;
  ProfilePage(this.name_param,
              this.email,
              this.roll_number,
              this.phone_number_param,
              this.batch,
              this.department,
              this.gender,
              this.clubs,
              this.profile_photo_link,
              this.edit_or_display_name_param,
              this.edit_or_display_phone_number_param,
              this.error_message,
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
    return Column(
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
        CollegeDetails(widget.department, widget.batch, widget.email, widget.roll_number),
        ClubTitle(),
        ProfileClubs(widget.clubs),
        ErrorDisplay(widget.error_message),
      ],
    );
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
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CollegeDetails extends StatefulWidget {
  String department;
  String batch;
  String email;
  String roll_number;
  CollegeDetails(this.department, this.batch, this.email, this.roll_number, {super.key});

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
            padding: EdgeInsets.fromLTRB(5.0, 25, 0.0, 2.5),
            child: ProfileDepartmentAndBatch(widget.department, widget.batch),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5.0, 2.5, 0.0, 2.5),
            child: ProfileEmail(widget.email),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5.0, 2.5, 0.0, 2.5),
            child: ProfileRollNumber(widget.roll_number),
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
        color: Colors.white,
      ),
    );
  }
}

class ProfileRollNumber extends StatefulWidget {
  String roll_number;
  ProfileRollNumber(this.roll_number, {super.key});

  @override
  State<ProfileRollNumber> createState() => _ProfileRollNumberState(roll_number);
}

class _ProfileRollNumberState extends State<ProfileRollNumber> {
  String roll_number;
  _ProfileRollNumberState(this.roll_number);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Roll No. : " + roll_number,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
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
        color: Colors.white,
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
        color: Colors.white,
      ),
    );
  }
}

class ProfileBatch extends StatefulWidget {
  String batch;
  ProfileBatch(this.batch, {super.key});

  @override
  State<ProfileBatch> createState() => _ProfileBatchState();
}

class _ProfileBatchState extends State<ProfileBatch> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.batch,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
      ),
    );
  }
}

class ProfileDepartmentAndBatch extends StatefulWidget {
  String department;
  String batch;
  ProfileDepartmentAndBatch(this.department, this.batch, {super.key});

  @override
  State<ProfileDepartmentAndBatch> createState() => _ProfileDepartmentAndBatchState();
}

class _ProfileDepartmentAndBatchState extends State<ProfileDepartmentAndBatch> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.department + " - " + widget.batch,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
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
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: "Update your name",
          labelStyle: TextStyle(
            color: Colors.white,
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
            color: Colors.white,
          ),
          decoration: InputDecoration(
            labelText: "Update your Phone No.",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            border: OutlineInputBorder(),
          ),
        ),
      )
    );
  }
}

class ProfileClubs extends StatefulWidget {
  List clubs;
  ProfileClubs(this.clubs, {super.key});

  @override
  State<ProfileClubs> createState() => _ProfileClubsState();
}

class _ProfileClubsState extends State<ProfileClubs> {
  @override
  Widget build(BuildContext context) {
    List<Widget> club_list = [];
    for (int i = 0; i < widget.clubs.length; ++i) {
      club_list.add(ClubItem(widget.clubs[i]));
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 37, 3, 73),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Wrap(
        children: club_list,
      ),
    );
  }
}

class ClubTitle extends StatefulWidget {
  const ClubTitle({super.key});

  @override
  State<ClubTitle> createState() => _ClubTitleState();
}

class _ClubTitleState extends State<ClubTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 25, 0.0, 2.5),
      child: Text(
        "Clubs",
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ClubItem extends StatefulWidget {
  String club_name;
  ClubItem(this.club_name, {super.key});

  @override
  State<ClubItem> createState() => _ClubItemState();
}

class _ClubItemState extends State<ClubItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Color.fromARGB(255, 75, 30, 122),
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(7.0, 7.0, 7.0, 7.0),
            child: Text(
            widget.club_name,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
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
