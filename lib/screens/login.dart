import 'dart:ui';

import 'package:e_care_mobile/Authentication/error_handler.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/screens/patient_dashboard.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'signup.dart';
import 'reset_password.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:e_care_mobile/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:e_care_mobile/util/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  static const double figureHeight = 250;

  // Text form field controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Colors
  Color _green = HexColor("#4BA54D");
  Color _purpleText = HexColor("#8237C1");
  Color _gold = HexColor("#F8B25A");
  Color _lightGold = HexColor("#FFE5C4");
  Color _darkGrey = HexColor("#4F4F4F");
  Color _grey = HexColor("#828282");
  Color _lightGrey = HexColor("#BDBDBD");

  // Text field container height
  double _textFieldHeight = 48;

  // Thickness of Text fields
  double _textFieldBorderWidth = 1;

  // Text size
  double _textSize = 14;

  // Text field box shadow
  Color _textFieldShadow = Color.fromRGBO(0, 0, 0, 0.5);

  // TODO CHANGE TO PROVIDER
  // Hide password
  bool _obscureText = true;
  double heightValue = 120;

  // TODO DISPOSE CONTROLLERS
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Opacity(
            opacity: auth.loggedInStatus == Status.Authenticating ||
                    auth.loggedInStatus == Status.LoggedIn
                ? 0.4
                : 1,
            child: AbsorbPointer(
                absorbing: auth.loggedInStatus == Status.Authenticating ||
                    auth.loggedInStatus == Status.LoggedIn,
                child: Form(
                    key: formKey,
                    autovalidateMode: auth.autoValidate
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: _buildLoginForm(context))),
          ),
          Opacity(
            opacity: 1,
            child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: auth.loggedInStatus == Status.Authenticating
                    ? Center(child: loadingSpinner(48.0, 2.0))
                    : auth.loggedInStatus == Status.LoggedIn
                        ? Center(
                            child: onComplete(
                                "Login Success",
                                Icons.check_circle,
                                Colors.green.shade700,
                                heightValue,
                                context))
                        /*: auth.loggedInStatus == Status.Error
                        ? Form(
                            // TODO SOLVE THIS
                            key: formKey,
                            autovalidateMode: auth.autoValidate
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            child: _buildLoginForm(context))*/
                        : null),
          )
        ],
      ),
    ));
  }

  _buildLoginForm(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    // Ensure correct data was entered
    checkFields() {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        return true;
      }
      // Set auto validate to true
      auth.autoValidated();
      return false;
    }

    // Login
    var login = () async {
      // Login Request
      final response =
      await auth.signIn(_emailController.text, _passwordController.text);
      // Check if there's response
      if (response != null) {
        // true
        User user = response['user'];
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Future.delayed(Duration(milliseconds: 6000)).then(
                (value) =>
                Navigator.pushReplacementNamed(context, '/dashboard'));
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            heightValue = 200.0;
            //bottom = 100;
          });
        });
        /*Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => PatientDashboard(user: response['user'],)),
                (Route<dynamic> route) => false));*/
        //Provider.of<UserProvider>(context).setUser(response['user']);
      } else {
        // false
        print('response');
        // Error Alert dialog
        ErrorHandler().errorDialog(context, auth.failure.toString());
        // Snackbar to display error message
        /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          content: Text(auth.failure.toString()),
        ));
        Future.delayed(Duration(milliseconds: 4000))
            .then((value) => auth.delayLogin());*/
      }
    };
    // Stay logged in
    var stayLogged = (value) {
      final response = auth.stayLoggedIn(value);
      return response;
    };

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 24, 24.0, 24.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 40.0),
          Text(
            'Welcome back',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromRGBO(75, 165, 77, 1),
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Email',
                style: TextStyle(
                    fontSize: _textSize, fontWeight: FontWeight.w500)),
          ),
          Container(
              //height: _textFieldHeight,
              decoration: boxDecoration(),
              child: Theme(
                data: Theme.of(context).copyWith(primaryColor: _green),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: buildDecoration(_green, _textFieldBorderWidth,
                      _textSize, Icons.email, 'myemail@gmail.com', false),
                  validator: (value) => validateEmail(value),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  maxLength: 20,
                ),
              )),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Password',
                style: TextStyle(
                    fontSize: _textSize, fontWeight: FontWeight.w500)),
          ),
          Container(
            //height: _textFieldHeight,
            decoration: boxDecoration(),
            child: Theme(
              data: Theme.of(context).copyWith(primaryColor: _green),
              child: TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: _obscureText,
                enableSuggestions: false,
                autocorrect: false,
                decoration: buildDecoration(
                  _green,
                  _textFieldBorderWidth,
                  _textSize,
                  Icons.lock,
                  'Password',
                  true,
                  IconButton(
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
                ),
                validator: (value) => value.isEmpty
                    ? 'Password is required'
                    : value.length < 6
                        ? 'Password must be at least 6 characters'
                        : null,
                textAlign: TextAlign.start,
                maxLines: 1,
                maxLength: 20,
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Checkbox(
                  checkColor: Colors.white,
                  activeColor: _green,
                  value: auth.stayLogged,
                  onChanged: (bool newValue) {
                    stayLogged(newValue);
                  }),
            ),
            Expanded(
              child: Text("Stay logged In",
                  style: TextStyle(
                      fontSize: _textSize,
                      fontWeight: FontWeight.w500,
                      color: _green)),
            ),
          ]),
          SizedBox(height: 40.0),
          GestureDetector(
              onTap: () {
                print(_emailController.text);
                print(_passwordController.text);
                if (checkFields()) {
                  login();
                }
              },
              child: signButton(
                  _textFieldHeight, _textFieldShadow, _textSize, 'SIGN IN')),
          SizedBox(height: 30.0),
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
                          type: PageTransitionType.bottomToTop));
                },
                child: Text('Here',
                    style: TextStyle(
                      color: _green,
                      fontSize: _textSize,
                    )))
          ]),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Do not have an account?',
                style: TextStyle(
                  fontSize: _textSize,
                )),
            SizedBox(width: 5.0),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Signup(),
                          duration: Duration(seconds: 0),
                          type: PageTransitionType.rightToLeftWithFade));
                },
                child: Text('Sign up',
                    style: TextStyle(
                      color: _green,
                      fontSize: _textSize,
                    )))
          ])
        ]),
      ),
    );
  }
}
