import 'package:e_care_mobile/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'screens/onboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        'onboarding': (context) => Onboarding()
      },
    );
  }
}
