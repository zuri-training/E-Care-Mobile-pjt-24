import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care_mobile/database/userprofile.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/screens/patient_dashboard.dart';
import 'package:e_care_mobile/screens/profile/profile_page.dart';
import 'package:e_care_mobile/screens/profile/widgets/appbartwo.dart';
import 'package:e_care_mobile/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/appbar_widget.dart';
import 'widgets/profilehead.dart';

class EditProfile extends StatelessWidget {
  final Map<String, dynamic> datas;
  const EditProfile({Key key, this.datas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userDat = Provider.of<UserProvider>(context);
    var userid = userDat.user.patientId;
    TextEditingController fname =
        TextEditingController(text: datas['firstName']);
    TextEditingController lname = TextEditingController(text: datas['surname']);
    TextEditingController dob = TextEditingController(text: datas['dob']);
    TextEditingController location =
        TextEditingController(text: datas['location']);
    TextEditingController nextofkin =
        TextEditingController(text: datas['number']);
    TextEditingController gender = TextEditingController(text: datas['gender']);
    TextEditingController email = TextEditingController(text: datas['gender']);
    return Scaffold(
      appBar: buildAppBarTwo(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            ProfileHead(),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              minRadius: 40,
            ),
            SizedBox(
              height: 5,
            ),
            Center(
                child: TextButton(
              onPressed: () {},
              child: Text(
                'Change Profile Picture',
                style: TextStyle(fontSize: 17),
              ),
            )),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: fname,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: lightgreen, width: 2))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: lname,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: lightgreen, width: 2))),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: gender,
              decoration: InputDecoration(
                  hintText: 'gender',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: lightgreen, width: 2))),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: location,
              decoration: InputDecoration(
                  hintText: 'Location',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: lightgreen, width: 2))),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: nextofkin,
              decoration: InputDecoration(
                  hintText: 'phonenumber',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: lightgreen, width: 2))),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await UserProfile().updateUserProfile(
                  userid,
                  fname.text,
                  lname.text,
                  gender.text,
                  location.text,
                  nextofkin.text,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Your Profile has been updated')));
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PatientDashboard()));
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: lightgreen,
              ),
            )
          ],
        ),
      ),
    );
  }
}
