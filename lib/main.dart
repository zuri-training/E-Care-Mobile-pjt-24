import 'package:e_care_mobile/providers/auth.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/screens/checkyouremail.dart';
import 'package:e_care_mobile/screens/otp_form.dart';
import 'package:e_care_mobile/screens/patient_dashboard.dart';
import 'package:e_care_mobile/screens/signup.dart';
import 'package:e_care_mobile/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/auth_provider.dart';
import 'screens/onboarding.dart';
import 'screens/verify_email.dart';
import 'screens/login.dart';
import 'medical/view_medical_advice.dart';
import 'chat/chatDetailPage.dart';
import 'chat/chat_screen.dart';
import 'package:e_care_mobile/util/shared_preference.dart';
import 'package:e_care_mobile/userData/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Color _purple = HexColor("#6305B1");

  asd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientId = prefs.getString("patientId");
    String firstname = prefs.getString("firstname");
    String surname = prefs.getString("surname");
    String email = prefs.getString("email");
    String token = prefs.getString("token");
    print('$patientId $firstname $surname $email $token ');
    print('sdg');
  }

  users(context) {
    UserPreferences().getUser().then((value) {
      //Provider.of<UserProvider>(context).setUser(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    // get User data
    Future<User> getUserData() => UserPreferences().getUser();
    asd();
    users(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider())
        ],
        child: MaterialApp(
            theme: ThemeData(
              fontFamily: 'Inter',
              //primarySwatch: _purple,
              // unselectedWidgetColor: Colors.black,
            ),
            debugShowCheckedModeBanner: false,
            home: FutureBuilder(
                future: getUserData(),
                builder: (context, snapshot) {
                  //print('f');
                  //print(getUserData().then((value) => Provider.of<UserProvider>(context).setUser(value)));

                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else
                        /*if (snapshot.data.token == null)*/
                        return SplashScreen(user: snapshot.data);
                    /*else
                        UserPreferences().removeUser();
                      return PatientDashboard();*/
                  }
                }),
            //initialRoute: '/',
            routes: {
              //'/': (context) => SplashScreen(),
              'onboarding': (context) => Onboarding(),
              '/dashboard': (context) => PatientDashboard(),
              '/otpForm': (context) => OtpForm(),
              '/signUp': (context) => Signup(),
              '/checkEmail': (context) => CheckYourEmail(),
              '/verifyEmail': (context) => VerifyEmail(),
            }));
  }
}
