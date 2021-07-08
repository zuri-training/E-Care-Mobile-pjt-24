import 'package:e_care_mobile/models/patient_profile.dart';
import 'package:e_care_mobile/screens/profile/utils/user_pref.dart';
import 'package:e_care_mobile/screens/profile/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

import '../../models/patient.dart';
import 'widgets/profile_widget.dart';
import 'widgets/textfield_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  PatientProfile patient = UserPref.patient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: patient.imagePath,
            isEdit: true,
            onClicked: () async {},
          ),
          SizedBox(height: 24),
          TextFieldWidget(
            label: 'Name',
            text: patient.name,
            onChanged: (name) {},
          ),
          SizedBox(height: 24),
          TextFieldWidget(
            label: 'Status',
            maxLines: 5,
            text: patient.status,
            onChanged: (name) {},
          ),
        ],
      ),
    );
  }
}
