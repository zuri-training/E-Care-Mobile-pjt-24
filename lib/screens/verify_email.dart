import 'package:carbon_icons/carbon_icons.dart';
import 'package:e_care_mobile/Authentication/error_handler.dart';
import 'package:e_care_mobile/providers/auth.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/screens/otp_form.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pulsating_button.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    /*AuthProvider auth = Provider.of<AuthProvider>(context);
    UserProvider userDat = Provider.of<UserProvider>(context);
    verify() async {
      final response = await auth.verify();
      print('as');
      if(response['status']) {
        User user = response['user'];
        Future.delayed(Duration.zero, () async {
          Provider.of<UserProvider>(context, listen: false).setUser(user);
        });
        Future.delayed(Duration(milliseconds: 4000)).then(
                (value) => Navigator.pushReplacementNamed(context, '/dashboard'));
      } else {
        ErrorHandler().errorDialog(context,  'Email not yet verified');
      }
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white12,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              top: 0,
              bottom: 8,
            ),
            child: InkWell(
              child: Icon(
                CarbonIcons.menu,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 120,
                    color: Color(0xff6305B1),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CHECK YOUR EMAIL',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(left: 5, right: 1)),
                  Flexible(
                    child: Container(
                      padding: new EdgeInsets.only(left: 20, right: 30.0),
                      child: Text(
                        'We have sent a verification link to your email. ',
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 11,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        primary: Color(0xff6305B1),
                      ),
                      onPressed: () {
                        verify();
                      },
                      child: Text(
                        'Open Email App',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}
