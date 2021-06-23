import 'package:e_care_mobile/screens/otp_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pulsating_button.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text('Verification', style: TextStyle(color: Colors.black),),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 10,

          child:  IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
        ) ,

        elevation: 0,
        backgroundColor: Colors.white12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: PulsatingCircleIconButton(),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Column(
                    children: [
                      Text('Verification Code',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.purple,
                        fontWeight: FontWeight.w700,
                      ),
                      ),
                      SizedBox(height:10),
                      Text('We have sent the verification code to your Mobile Number',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                        color: Colors.black54,
                      )
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                OtpForm(),
                SizedBox(
                  height: 20,
                ),
               GestureDetector(
                 onTap: () {},
                 child: Container(
                   height: 40,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15.0),
                     border: Border.all(
                       color: Colors.purple
                     ),
                   ),
                   child: Center(
                       child: Text('Send Again',
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 16,
                               fontWeight: FontWeight.w500)))),
                   ),
                SizedBox(
                  height: 20,
                ),
               GestureDetector(
                onTap: () {},
                child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xff6305B1),
                    ),
                    child: Center(
                        child: Text('Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)))),
              ),
              ],

            ),
          ),
        ),
      ),

    );
  }
}
