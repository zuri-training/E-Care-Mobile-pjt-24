import 'package:e_care_mobile/models/patient_profile.dart';
import 'package:e_care_mobile/screens/profile/edit_profile.dart';
import 'package:e_care_mobile/screens/profile/utils/user_pref.dart';
import 'package:e_care_mobile/screens/profile/widgets/appbar_widget.dart';
import 'package:e_care_mobile/screens/profile/widgets/button_widget.dart';
import 'package:e_care_mobile/screens/profile/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final patient = UserPref.patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: patient.imagePath,
            onClicked: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EditProfile()));
            },
          ),
          SizedBox(
            height: 25,
          ),
          buildName(patient),
          SizedBox(
            height: 16,
          ),
          buildStatus(patient),
          SizedBox(
            height: 20,
          ),
          Center(child: buildLogOut(context)),
        ],
      ),
    );
  }

  Widget buildName(PatientProfile patient) => Column(
        children: [
          Text(
            patient.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  Widget buildStatus(PatientProfile patient) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              patient.status,
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      );
}

Widget buildLogOut(BuildContext context) => ButtonWidget(
      text: 'Logout',
      onClicked: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('email');
        Navigator.push(
            context, MaterialPageRoute(builder: (BuildContext ctx) => Login()));
      },
    );
