import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: BackButton(
      color: Colors.black,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(
          CupertinoIcons.moon_stars,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    ],
  );
}
