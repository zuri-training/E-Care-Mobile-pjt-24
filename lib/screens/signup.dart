import 'package:e_care_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'signup.dart';
import 'reset_password.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = new GlobalKey<FormState>();

  static const double figureHeight = 250;

  Color _purple = HexColor("#6305B1");
  Color _purpleText = HexColor("#8237C1");
  Color _gold = HexColor("#F8B25A");
  Color _lightGold = HexColor("#FFE5C4");
  Color _darkGrey = HexColor("#4F4F4F");
  Color _grey = HexColor("#828282");
  Color _lightGrey = HexColor("#BDBDBD");

  // Text size
  double _textSize = 16;

  // variable to store if password is visible or not
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildSignupForm())));
  }

  _buildSignupForm() {
    /*return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          SizedBox(height: 75.0),
          Container(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  Text('Signup',
                      style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0)),
                  //Dot placement
                  Positioned(
                      top: 62.0,
                      left: 200.0,
                      child: Container(
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: _purple)))
                ],
              )),
          SizedBox(height: 25.0),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'EMAIL',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 12.0,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _purple),
                )),
            /*onChanged: (value) {
    this.email = value;
    },
    validator: (value) =>
    value.isEmpty ? 'Email is required' : validateEmail(value)*/
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'PASSWORD',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 12.0,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _purple),
                )),
            obscureText: true,
            /*onChanged: (value) {
                this.password = value;
              },
              validator: (value) =>
              value.isEmpty ? 'Password is required' : null*/
          ),
          SizedBox(height: 50.0),
          GestureDetector(
            /*onTap: () {
          if (checkFields())
            AuthService().signUp(email, password).then((userCreds) {
              Navigator.of(context).pop();
            }).catchError((e) {
              ErrorHandler().errorDialog(context, e);
            });
        },*/
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.deepPurpleAccent,
                    color: _purple,
                    elevation: 7.0,
                    child: Center(
                        child: Text('SIGN UP',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go back',
                    style: TextStyle(
                        color: _purple,
                        fontFamily: 'Trueno',
                        decoration: TextDecoration.underline)))
          ])
        ],
      ),
    );*/
    return SingleChildScrollView(
      //width: MediaQuery.of(context).size.width,
      /*CustomPaint(
        size: MediaQuery.of(context).size,
        painter: CurvePainter(figureHeight: figureHeight),

      ),*/

      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 24, 24.0, 24.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 32.0),
          Center(
            child: Text('Sign Up',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 56)),
          ),
          SizedBox(height: 32.0),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(8),
                ),
                color: Color.fromRGBO(99, 5, 177, 1),
                gradient: LinearGradient(
                    begin: Alignment(6.123234262925839e-17, 1),
                    end: Alignment(-1, 6.123234262925839e-17),
                    colors: [
                      Color.fromRGBO(76, 21, 211, 1),
                      Color.fromRGBO(96, 8, 182, 1)
                    ]),
              ),
              child: OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                return Row(
                  mainAxisAlignment: orientation == Orientation.portrait
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  children: [
                    //Image(image: AssetImage('images/google.png')),
                    Image.asset(
                      ('assets/images/google.png'),
                      height: 24,
                      width: 24,
                    ),
                    Padding(
                      padding: orientation == Orientation.portrait
                          ? const EdgeInsets.only(left: 0.0)
                          : const EdgeInsets.only(left: 24.0),
                      child: Text('Sign Up with Google',
                          style: TextStyle(
                              color: Colors.white, fontSize: _textSize)),
                    ),
                  ],
                );
              })),
          SizedBox(height: 40.0),
          Row(children: <Widget>[
            Expanded(
                child: Divider(
              endIndent: 24,
              color: Colors.black,
            )),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: Text("OR",
                  style: TextStyle(
                      fontSize: _textSize, fontWeight: FontWeight.w500)),
            ),
            Expanded(
                child: Divider(
              indent: 24,
              color: Colors.black,
            )),
          ]),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Email',
                style: TextStyle(
                    fontSize: _textSize, fontWeight: FontWeight.w500)),
          ),
          Container(
              height: 48.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ],
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'myemail@gmail.com',
                    //labelText: 'Email',
                    hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.2),
                        fontSize: _textSize),
                    isDense: true,
                    counterText: "",
                    contentPadding: EdgeInsets.all(10.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        /*borderRadius:
                                new BorderRadius.circular(10.0),*/
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        borderSide: BorderSide.none)),
                /*onChanged: (value) {
                          this.email = value;
                        },
                        validator: (value) =>
                        value.isEmpty ? 'Email is required' : validateEmail(value)*/
                textAlign: TextAlign.start,
                maxLines: 1,
                maxLength: 20,
                // controller: _locationNameTextController,
              )),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Password',
                style: TextStyle(
                    fontSize: _textSize, fontWeight: FontWeight.w500)),
          ),
          Container(
            height: 48.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    offset: Offset(0, 4),
                    blurRadius: 4)
              ],
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            child: TextField(
              obscureText: _obscureText,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  hintText: 'Password',
                  //icon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText == true
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 24.0,
                        color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  //labelText: 'Email',
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.2),
                      fontSize: _textSize),
                  isDense: true,
                  counterText: "",
                  contentPadding: EdgeInsets.all(10.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      /*borderRadius:
                                new BorderRadius.circular(10.0),*/
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      borderSide: BorderSide.none)),
              /*onChanged: (value) {
                          this.email = value;
                        },
                        validator: (value) =>
                        value.isEmpty ? 'Email is required' : validateEmail(value)*/
              textAlign: TextAlign.start,
              maxLines: 1,
              maxLength: 20,
              // controller: _locationNameTextController,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Checkbox(checkColor: _purple, value: false),
            ),
            Expanded(
              child: Text("Stay logged In",
                  style: TextStyle(
                      fontSize: _textSize,
                      fontWeight: FontWeight.w500,
                      color: _purple)),
            ),
          ]),
          SizedBox(height: 40.0),
          GestureDetector(
              /*onTap: () {
                        if (checkFields()) AuthService().signIn(email, password, context);
                      },*/
              /*child: Container(
                          height: 48.0,
                          child: Material(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              color: _purple,
                              elevation: 7.0,
                              child: Center(
                                  child: Text('SIGN UP',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: _textSize,
                                          fontWeight: FontWeight.w500))))),*/
              child: Container(
                  height: 48.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(8),
                    ),
                    color: Color.fromRGBO(99, 5, 177, 1),
                    gradient: LinearGradient(
                        begin: Alignment(6.123234262925839e-17, 1),
                        end: Alignment(-1, 6.123234262925839e-17),
                        colors: [HexColor("#4C15D3"), HexColor("#6305B1")]),
                  ),
                  child: Center(
                      child: Text('SIGN UP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: _textSize,
                              fontWeight: FontWeight.w500))))),
          SizedBox(height: 25.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Forgot Password?',
                style: TextStyle(
                  fontSize: _textSize,
                )),
            SizedBox(width: 5.0),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: ResetPassword(),
                          duration: Duration(seconds: 3),
                          type: PageTransitionType.fade));
                },
                child: Text('Here',
                    style: TextStyle(
                        color: _purple,
                        fontSize: _textSize,
                        decoration: TextDecoration.underline)))
          ]),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Already have an account?',
                style: TextStyle(
                  fontSize: _textSize,
                )),
            SizedBox(width: 5.0),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Login(),
                          duration: Duration(seconds: 3),
                          type: PageTransitionType.bottomToTop));
                },
                child: Text('Login',
                    style: TextStyle(
                      color: _purple,
                      fontSize: _textSize,
                      //decoration: TextDecoration.underline
                    )))
          ])
        ]),
      ),
    );
  }
}
