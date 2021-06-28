import 'package:e_care_mobile/providers/auth.dart';
import 'package:e_care_mobile/screens/patient_dashboard.dart';
import 'package:e_care_mobile/services/api.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:e_care_mobile/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:provider/provider.dart';

final otpInputDecoration = InputDecoration(
  errorStyle: TextStyle(height: 0),
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0xff6305B1)),
  );
}

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;

  String _otp;
  String box1, box2, box3, box4, box5;
  bool _isVisible = true;

  Widget _myWidget = CircularProgressIndicator();

  // Colors
  Color _purple = HexColor("#6305B1");

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  otpCode() {
    setState(() {
      _otp = box1 + box2 + box3 + box4 + box5;
    });
    print(_otp);
  }

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  activateUser() async {
    AuthService authInfo = AuthService();
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    print('getUser');
    var response = await authInfo.activateUser(_otp);
    print(response);
    /*if (response != null) {
      setState(() {
        //_isLoading = false;
      });
      print(response['data']['token']);


      Provider.of<UserProvider>(context, listen: false).setUser(user);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => PatientDashboard()),
          (Route<dynamic> route) => false);
    }*/
    if (response['status']) {
      User user = response['user'];
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      Future.delayed(Duration(milliseconds: 4000)).then(
          (value) => Navigator.pushReplacementNamed(context, '/dashboard'));
    } else {
      print(response);
      // todo implement animation
      /*Flushbar(
          title: "Failed Login",
          message: response['message']['message'].toString(),
          duration: Duration(seconds: 3),
        ).show(context);*/
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, top: 32.0, right: 16, bottom: 32),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: auth.verifiedStatus == Status.Loading
                ? Center(child: CircularProgressIndicator())
                : auth.verifiedStatus == Status.Completed
                    ? Center(
                        child: onComplete("Email Verified", Icons.check_circle,
                            Colors.green.shade700))
                    : auth.verifiedStatus == Status.Error
                        ? Center(child: Text(auth.failure.toString()))
                        : Center(
                            child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.verified_user,
                                      color: _purple,
                                      size: 128.0,
                                    ),
                                    SizedBox(height: 12),
                                    Text('Verify your email',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 16),
                                    Visibility(
                                      visible: _isVisible ? false : true,
                                      child: AnimatedSwitcher(
                                        duration: const Duration(seconds: 1),
                                        child: _myWidget,
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isVisible ? true : false,
                                      child: Text(
                                          'Please Enter the 5 digit code sent to aconalexx@gmail.com',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: HexColor("#6305B1"))),
                                    ),
                                    SizedBox(height: 24),
                                    Visibility(
                                      visible: _isVisible ? true : false,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 60,
                                            child: TextFormField(
                                              autofocus: true,
                                              style: TextStyle(fontSize: 24),
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: otpInputDecoration,
                                              onChanged: (value) {
                                                nextField(value, pin2FocusNode);
                                                setState(() {
                                                  box1 = value;
                                                });
                                              },
                                              validator: (value) =>
                                                  value.isEmpty ? '' : null,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 60,
                                            child: TextFormField(
                                              focusNode: pin2FocusNode,
                                              style: TextStyle(fontSize: 24),
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: otpInputDecoration,
                                              onChanged: (value) => {
                                                nextField(value, pin3FocusNode),
                                                setState(() {
                                                  box2 = value;
                                                })
                                              },
                                              validator: (value) =>
                                                  value.isEmpty ? '' : null,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 60,
                                            child: TextFormField(
                                              focusNode: pin3FocusNode,
                                              style: TextStyle(fontSize: 24),
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: otpInputDecoration,
                                              onChanged: (value) => {
                                                nextField(value, pin4FocusNode),
                                                setState(() {
                                                  box3 = value;
                                                })
                                              },
                                              validator: (value) =>
                                                  value.isEmpty ? '' : null,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 60,
                                            child: TextFormField(
                                              focusNode: pin4FocusNode,
                                              style: TextStyle(fontSize: 24),
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: otpInputDecoration,
                                              onChanged: (value) => {
                                                nextField(value, pin5FocusNode),
                                                setState(() {
                                                  box4 = value;
                                                })
                                              },
                                              validator: (value) =>
                                                  value.isEmpty ? '' : null,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 60,
                                            child: TextFormField(
                                              focusNode: pin5FocusNode,
                                              style: TextStyle(fontSize: 24),
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: otpInputDecoration,
                                              onChanged: (value) {
                                                setState(() {
                                                  box5 = value;
                                                });
                                                if (value.length == 1) {
                                                  pin5FocusNode.unfocus();
                                                  // Then you need to check is the code is correct or not
                                                }
                                              },
                                              validator: (value) =>
                                                  value.isEmpty ? '' : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 24),
                                    Visibility(
                                      visible: _isVisible ? true : false,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Did not receive the code?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12)),
                                          Text(' Resend',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: HexColor("#6305B1"))),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Visibility(
                                      visible: _isVisible ? true : false,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              /*setState(() {
                                  _isVisible=false;});
                                Future.delayed(Duration(milliseconds: 2000)).then((_) {
                                  setState(() {
                                    _myWidget=/*Icon(
                                    Icons.check_circle,
                                    size:48,
                                    color: _purple,
                                  );*/Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.check_circle,
                                          size:88,
                                          color: Colors.green.shade700,
                                        ),
                                        ClipRect(
                                          child: SizedBox(
                                            //width: 150,
                                            child: Opacity(
                                                opacity: 1,
                                                child: Text(
                                                  "Verification Successful",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.green.shade800, fontSize: 24),
                                                )),
                                          ),
                                        )
                                      ],
                                    );;
                                  });
                                });*/
                                              if (checkFields()) {
                                                otpCode();
                                                activateUser();
                                                setState(() {
                                                  //_isVisible=false;
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: _purple,
                                            ),
                                            child: Text('Verify',
                                                style:
                                                    TextStyle(fontSize: 16))),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Visibility(
                                      visible: _isVisible ? true : false,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Not aconalexx@gmail.com?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12)),
                                          Text(' Change email',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: HexColor("#6305B1"))),
                                        ],
                                      ),
                                    ),

                                    // DefaultButton(
                                    //   text: "Continue",
                                    //   press: () {},
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ),
          ),
        ),
      ),
    );
  }
}
