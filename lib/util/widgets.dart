import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

InputDecoration buildDecoration(Color _purple, double _textFieldBorderWidth,
    double _textSize, IconData iconData, String hint, bool obscure,
    [IconButton obscureButton]) {
  return InputDecoration(
    prefixIcon: Icon(iconData),
    suffixIcon: obscure == true ? obscureButton : null,
    hintText: hint,
//labelText: 'Email',
    hintStyle:
        TextStyle(color: Colors.black.withOpacity(0.2), fontSize: _textSize),
    isDense: true,
    counterText: "",
    contentPadding: EdgeInsets.all(10.0),
    filled: true,
    fillColor: Colors.white,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      borderSide: BorderSide(color: Colors.red, width: _textFieldBorderWidth),
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        borderSide: BorderSide(
            color: _purple,
            style: BorderStyle.solid,
            width: _textFieldBorderWidth)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        borderSide: BorderSide(
            color: _purple,
            style: BorderStyle.solid,
            width: _textFieldBorderWidth)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        borderSide: BorderSide(
            color: _purple,
            style: BorderStyle.solid,
            width: _textFieldBorderWidth)),
  );
}

Container signButton(double _textFieldHeight, Color _textFieldShadow,
    double _textSize, String text) {
  return Container(
      height: _textFieldHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
              color: _textFieldShadow, offset: Offset(0, 4), blurRadius: 4)
        ],
        color: Color.fromRGBO(99, 5, 177, 1),
        gradient: LinearGradient(
            begin: Alignment(6.123234262925839e-17, 1),
            end: Alignment(-1, 6.123234262925839e-17),
            colors: [HexColor("#4C15D3"), HexColor("#6305B1")]),
      ),
      child: Center(
          child: Text(text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: _textSize,
                  fontWeight: FontWeight.w500))));
}

BoxDecoration boxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8),
      topRight: Radius.circular(0),
      bottomLeft: Radius.circular(0),
      bottomRight: Radius.circular(8),
    ),
  );
}

Widget onComplete(String info, IconData iconData, Color color) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Icon(
        iconData,
        size: 88,
        color: color,
      ),
      SizedBox(height: 12),
      DelayedDisplay(
        delay: Duration(seconds: 1),
        child: ClipRect(
          child: SizedBox(
            //width: 150,
            child: Opacity(
                opacity: 1,
                child: Text(
                  info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: color, fontSize: 24),
                )),
          ),
        ),
      ),
      SizedBox(height: 16),
      DelayedDisplay(
          delay: Duration(seconds: 2), child: CircularProgressIndicator())
    ],
  );
}

Widget onFailure(String info, IconData iconData, Color color) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Icon(
        iconData,
        size: 88,
        color: color,
      ),
      SizedBox(height: 12),
      ClipRect(
        child: SizedBox(
          //width: 150,
          child: Opacity(
              opacity: 1,
              child: Text(
                info,
                textAlign: TextAlign.center,
                style: TextStyle(color: color, fontSize: 24),
              )),
        ),
      ),
      /*SizedBox(height: 16),
      Text(
        'Try another email',
        textAlign: TextAlign.center,
        style: TextStyle(color: color, fontSize: 24),
      )*/
    ],
  );
}

//To Validate email
String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter a Valid Email';
  else
    return null;
}

// Component for header of respective fields
Padding textHeaders(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(title,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500)),
  );
}
