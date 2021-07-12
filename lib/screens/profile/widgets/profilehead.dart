import 'package:e_care_mobile/util/colors.dart';
import 'package:flutter/material.dart';

class ProfileHead extends StatelessWidget {
  const ProfileHead({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Profile Details',
      style: TextStyle(
        fontSize: 20,
        color: lightgreen,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
