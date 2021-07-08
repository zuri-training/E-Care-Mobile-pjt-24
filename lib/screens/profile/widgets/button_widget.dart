import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const ButtonWidget({
    Key key,
    this.text,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onClicked,
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: Color(0xff6305B1),
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
        ),
        child: Text(
          'Logout',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
}
