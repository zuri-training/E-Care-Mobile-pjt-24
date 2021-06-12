import 'dart:async';

import 'package:e_care_mobile/screens/onboarding.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Init State function/method
  @override
  void initState() {
    Timer(Duration(seconds: 3), route);
    super.initState();
  }

  //function to navigate to the on-boarding screen
  route() {
    Navigator.pushReplacementNamed(context, 'onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: Center(
        child: Text(
          'E-care',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
