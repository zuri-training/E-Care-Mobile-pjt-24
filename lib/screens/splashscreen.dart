import 'dart:async';

import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/screens/patient_dashboard.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:e_care_mobile/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class SplashScreen extends StatefulWidget {
  final User user;

  const SplashScreen({Key key, @required this.user}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //animation
  Animation<double> _animation;
  AnimationController _animationController;
  //Init State function/method
  @override
  void initState() {
    //Provider.of<UserProvider>(context, listen: false).setUser(widget.user);
    Timer(Duration(seconds: 3), route);
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    final _curvedanimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInCubic,
        reverseCurve: Curves.easeInOutBack);

    _animation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(_curvedanimation)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  checkLoginStatus() async {
    if (widget.user.token == '' || widget.user.token == null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, 'onboarding');
      }
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => PatientDashboard()),
          (Route<dynamic> route) => false);
    }
  }

  //function to navigate to the on-boarding screen
  route() {
    //Navigator.pushReplacementNamed(context, 'onboarding');
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<UserProvider>(context).setUser(widget.user);
    //auth = Provider.of<UserProvider>(context);
    //auth.setUser(widget.user);
    //_buildLoginForm(context);
    /* Future.delayed(Duration.zero, () async {
      Provider.of<UserProvider>(context, listen: false).setUser(widget.user);
    });*/
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).setUser(widget.user);
    });
    return Scaffold(
      body: MainImage(
        animation: _animation,
      ),
    );
  }
}

class MainImage extends AnimatedWidget {
  MainImage({
    Key key,
    @required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.rotate(
      angle: animation.value,
      child: Scaffold(
        backgroundColor: lemon,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Image.asset('assets/images/Logo.png'),
          ),
        ),
      ),
    );
  }
}
