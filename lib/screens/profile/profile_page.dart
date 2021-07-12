import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/screens/profile/widgets/appbar_widget.dart';
import 'package:e_care_mobile/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'edit_profile.dart';
import 'widgets/profilehead.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> datas;
  const ProfilePage({Key key, this.datas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userDat = Provider.of<UserProvider>(context);
    var userid = userDat.user.patientId;

    // Image variable
    File _image;
    final picker = ImagePicker();

    String dropdownValue = 'One';

    // variable to check if file was uploaded
    bool _isFileUploaded = false;

    // Method to get image from user
    Future getImage() async {
      final pickedFile = dropdownValue == 'Camera'
          ? await picker.getImage(source: ImageSource.camera)
          : await picker.getImage(source: ImageSource.gallery);
    }

    final CollectionReference _db =
        FirebaseFirestore.instance.collection('patients');
    return Scaffold(
      appBar: buildAppBar(context),
      body: FutureBuilder<DocumentSnapshot>(
        future: _db.doc(userid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data.data() as Map<String, dynamic>;
            TextEditingController fname =
                TextEditingController(text: data['firstName']);
            TextEditingController lname =
                TextEditingController(text: data['surname']);
            TextEditingController dob =
                TextEditingController(text: data['dob']);
            TextEditingController location =
                TextEditingController(text: data['location']);
            TextEditingController nextofkin =
                TextEditingController(text: data['number']);
            TextEditingController gender =
                TextEditingController(text: data['gender']);

            return Padding(
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
                    readOnly: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                BorderSide(color: lightgreen, width: 2))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: lname,
                    readOnly: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                BorderSide(color: lightgreen, width: 2))),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    controller: gender,
                    decoration: InputDecoration(
                        hintText: 'gender',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                BorderSide(color: lightgreen, width: 2))),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: location,
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: 'Location',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                BorderSide(color: lightgreen, width: 2))),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: nextofkin,
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: 'phonenumber',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                BorderSide(color: lightgreen, width: 2))),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfile(datas: data)));
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: lightgreen,
                    ),
                  )
                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
