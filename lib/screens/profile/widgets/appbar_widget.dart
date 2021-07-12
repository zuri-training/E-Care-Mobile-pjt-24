import 'package:e_care_mobile/screens/login.dart';
import 'package:e_care_mobile/util/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(
      color: lightgreen,
    ),
    backgroundColor: Colors.white70,
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          child: Icon(Icons.logout),
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Login())),
        ),
      )
    ],
  );
}
