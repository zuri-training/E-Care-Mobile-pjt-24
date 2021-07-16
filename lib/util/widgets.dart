import 'package:delayed_display/delayed_display.dart';
import 'package:e_care_mobile/animation/infinite_animation.dart';
import 'package:e_care_mobile/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
      /*borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),*/
      borderSide: BorderSide(color: Colors.red, width: _textFieldBorderWidth),
    ),
    border: OutlineInputBorder(
        /*borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),*/
        borderSide: BorderSide(
            color: Color.fromRGBO(136, 136, 136, 1), //_purple,
            style: BorderStyle.solid,
            width: _textFieldBorderWidth)),
    focusedBorder: OutlineInputBorder(
        /*borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),*/
        borderSide: BorderSide(
            color: Color.fromRGBO(136, 136, 136, 1), //_purple,
            style: BorderStyle.solid,
            width: _textFieldBorderWidth)),
    enabledBorder: OutlineInputBorder(
        /*borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),*/
        borderSide: BorderSide(
            color: Color.fromRGBO(136, 136, 136, 1), //_purple,
            style: BorderStyle.solid,
            width: _textFieldBorderWidth)),
  );
}

Container signButton(double _textFieldHeight, Color _textFieldShadow,
    double _textSize, String text) {
  return Container(
      height: _textFieldHeight,
      decoration: BoxDecoration(
        /*borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(8),
        ),*/
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
              color: _textFieldShadow, offset: Offset(0, 4), blurRadius: 4)
        ],
        color: HexColor("#4BA54D"),
        /*gradient: LinearGradient(
            begin: Alignment(6.123234262925839e-17, 1),
            end: Alignment(-1, 6.123234262925839e-17),
            colors: [HexColor("#4C15D3"), HexColor("#6305B1")]),*/
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
    borderRadius: BorderRadius.all(
      Radius.circular(4),
    ),
  );
}

Widget onComplete(String info, IconData iconData, Color color, heightValue,
    [context]) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 600),
    height: heightValue,
    width: heightValue,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 2.0,
          spreadRadius: 0.0,
          offset: Offset(2.0, 2.0), // shadow direction: bottom right
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Lottie.asset(
          'assets/lottie/on_complete.json',
          width: 112,
          height: 112,
          repeat: false,
          fit: BoxFit.fill,
        ),
        Expanded(
          child: Container(
            child: DelayedDisplay(
              delay: Duration(seconds: 1),
              child: Text(
                info,
                textAlign: TextAlign.center,
                style: TextStyle(color: HexColor('#4BA54D'), fontSize: 20),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: DelayedDisplay(
                delay: Duration(seconds: 3), child: loadingSpinner(40.0, 2.0)),
          ),
        ),
      ],
    ),
    /*child: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          bottom: bottom,
        child:Lottie.asset(
          'assets/lottie/on_complete.json',
          width: 120,
          height: 120,
          repeat: false,
          fit: BoxFit.fill,
        ),),
    Positioned(
      top: 150,
      child: Center(
        child: DelayedDisplay(
            delay: Duration(seconds: 2), child: loadingSpinner(40.0, 2.0)),
      ),
    ),

        Positioned(
          top: 100,

          child: DelayedDisplay(
            delay: Duration(seconds: 1),
            child: Text(
              info,
              textAlign: TextAlign.center,
              style: TextStyle(color: HexColor('#4BA54D'), fontSize: 20),
            ),
          ),
        ),
      ],
    ),*/
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

InfiniteAnimation loadingIndicator() {
  return InfiniteAnimation(
    durationInSeconds: 2, //
    child: SvgPicture.asset('assets/images/loader.svg',
        height: 50, width: 50, semanticsLabel: 'ellipse27'),
  );
}

SizedBox loadingSpinner(size, strokeWidth) {
  return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(HexColor('#4BA54D'))));
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );

DropdownButtonHideUnderline dropDown(dropdownValue, setState) {
  return DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      //hint:
      icon: SvgPicture.asset('assets/images/more_horiz_icon.svg',
          semanticsLabel: 'vector'),
      iconSize: 0,
      isExpanded: true,
      elevation: 16,
      //focusColor: _lightGold,
      style: TextStyle(color: HexColor("#172B4D")),
      /*underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                            ),*/
      onChanged: (newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>[
        'Close Chat',
        'Clear Chat',
        'Change Doctor',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  );
}
