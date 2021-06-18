import 'package:e_care_mobile/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'screens/onboarding.dart';
import 'screens/login.dart';
import 'medical/view_medical_advice.dart';
import 'chat/chatDetailPage.dart';
import 'chat/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Inter',
          // unselectedWidgetColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          'onboarding': (context) => Onboarding()
        });
  }
}
