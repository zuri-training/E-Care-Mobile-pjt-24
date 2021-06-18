import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

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

  //function to navigate to the on-boarding screen
  route() {
    Navigator.pushReplacementNamed(context, 'onboarding');
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Color(0xff6305B1),
        body: Center(
          child: Image.asset('assets/images/splash.png'),
        ),
      ),
    );
  }
}
