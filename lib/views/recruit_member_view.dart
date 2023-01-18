import 'package:flutter/material.dart';
import 'package:legion/firebase_methods.dart';

dynamic database_functions = FirebaseMethods();

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);

class RecruitMemberView extends StatefulWidget {
  String email;
  String add_club;
  RecruitMemberView(this.email, this.add_club, {super.key});

  @override
  State<RecruitMemberView> createState() => _RecruitMemberViewState();
}

class _RecruitMemberViewState extends State<RecruitMemberView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database_functions.findUsers('email', widget.email),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            dynamic userList = snapshot.data;
            return RecruitMemberViewTmp(userList, widget.add_club);
          default:
            return const Text('Loading...');
        }
      },
    );
  }
}

class RecruitMemberViewTmp extends StatelessWidget {
  dynamic user_json;
  String add_club;
  RecruitMemberViewTmp(this.user_json, this.add_club, {super.key});

  @override
  Widget build(BuildContext context) {
    return RenderRecruitMemberView(user_json, add_club);
  }
}

class RenderRecruitMemberView extends StatefulWidget {
  dynamic user_json;
  String add_club;
  RenderRecruitMemberView(this.user_json, this.add_club, {super.key});

  @override
  State<RenderRecruitMemberView> createState() => _RenderRecruitMemberViewState();
}

class _RenderRecruitMemberViewState extends State<RenderRecruitMemberView> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController phone_number_controller = TextEditingController();

  String name = '';
  String phone_number = "";
  dynamic recruit_icon = Icons.add;
  dynamic recruit_text = "Recruit";

  void assign_values() {
    name = widget.user_json[0]['name'];
    phone_number = widget.user_json[0]['phone'];
  }

  void recruit() {
    database_functions.joinClub(widget.user_json[0]['email'], widget.add_club);
    database_functions.deleteRegistration('club_application', widget.add_club, widget.user_json[0]['email']);
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
        appBar: AppBar(
          title: Text('Profile'),
          actions: <Widget>[
            TextButton(
              style: flatButtonStyle,
              onPressed: () => recruit(),
              child: IconTextPair(recruit_icon, recruit_text, Colors.white,),
            ),
          ],
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: ProfilePage(name, widget.user_json[0]['email'], widget.user_json[0]['roll'], phone_number, widget.user_json[0]['batch'], widget.user_json[0]['dept'], widget.user_json[0]['sex'], widget.user_json[0]['clubs'], widget.user_json[0]['img_url']),
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
  ProfilePage(this.name_param,
              this.email,
              this.roll_number,
              this.phone_number_param,
              this.batch,
              this.department,
              this.gender,
              this.clubs,
              this.profile_photo_link,
              {super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState();

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryProfileDetails(widget.name_param, widget.phone_number_param, widget.gender),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 2.5, 2.5, 0.0),
              child: ProfilePhoto(widget.profile_photo_link),
            ),
          ],
        ),
        CollegeDetails(widget.department, widget.batch, widget.email, widget.roll_number),
        ClubTitle(),
        ProfileClubs(widget.clubs),
      ],
    )]);
  }
}

class PrimaryProfileDetails extends StatefulWidget {
  String name;
  String phone_number;
  String gender;
  PrimaryProfileDetails(this.name, this.phone_number, this.gender, {super.key});

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
          child: ProfilePhoneNumber(widget.phone_number),
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
  String content;
  ProfileName(this.content, {super.key});

  @override
  State<ProfileName> createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.content,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.black,
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
        color: Colors.black,
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
  String phone_number;
  ProfilePhoneNumber(this.phone_number, {super.key});

  @override
  State<ProfilePhoneNumber> createState() => _ProfilePhoneNumberState();
}

class _ProfilePhoneNumberState extends State<ProfilePhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.phone_number,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
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
        color: Colors.black,
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

class ProfileClubs extends StatefulWidget {
  List clubs;
  ProfileClubs(this.clubs, {super.key});

  @override
  State<ProfileClubs> createState() => _ProfileClubsState();
}

class _ProfileClubsState extends State<ProfileClubs> {
  @override
  Widget build(BuildContext context) {
    List<Widget> clubList = [];
    for (int i = 0; i < widget.clubs.length; ++i) {
      clubList.add(ClubItem(widget.clubs[i]));
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Wrap(
        children: clubList,
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
          color: Colors.black,
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
          color: Colors.white,
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(7.0, 7.0, 7.0, 7.0),
            child: Text(
            widget.club_name,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}