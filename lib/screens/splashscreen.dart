import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: SvgPicture.asset('assets/images/logo.svg'),
      ),
    );
  }
}
